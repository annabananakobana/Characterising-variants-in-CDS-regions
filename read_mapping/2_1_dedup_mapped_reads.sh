#!/bin/bash -e
#SBATCH -A uoo02820
#SBATCH -J dedup_sort_files
#SBATCH --time 06:00:00
#SBATCH -N 1
#SBATCH -c 16
#SBATCH -n 1
#SBATCH --mem=48G
#SBATCH --mail-user=anna.clark@postgrad.otago.ac.nz
#SBATCH --mail-type=ALL
#SBATCH --array=1-46
#SBATCH --chdir=/nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/mapped_reads

#Load modules, make sure you have actually indexed your ref seq
module load SAMtools/1.10-GCC-9.2.0
module load picard/2.21.8-Java-11.0.4
module load BEDTools/2.29.2-GCC-9.2.0

sample=sample_${SLURM_ARRAY_TASK_ID}

# this is a progress update so we can follow along where we are up to
echo removing duplicates from "${sample}"

# Using picard to remove reads that look like sequencing duplicates
java -jar /opt/nesi/mahuika/picard/2.21.8-Java-11.0.4/picard.jar MarkDuplicates \
  INPUT=/nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/mapped_reads/sort_"${sample}"_map_bwa.bam \
  OUTPUT=/nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/mapped_reads/dedup_"${sample}"_map_bwa.bam \
  REMOVE_DUPLICATES=TRUE \
  METRICS_FILE=/nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/mapped_reads/METRICS_"${sample}"

#sort the dedup file so that we can index it later
samtools sort -@ 32 /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/mapped_reads/dedup_"${sample}"_map_bwa.bam > /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/mapped_reads/dedup_"${sample}"_map_bwa_sorted.bam
        
# Grabbing some metrics about our mapping process
echo '## ' "${sample}" before dupe removal >> /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/mapped_reads/stats_mapping_WGS2020.txt

samtools flagstat /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/mapped_reads/sort_"${sample}"_map_bwa.bam >> /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/mapped_reads/stats_mapping_WGS2020.txt

echo '## ' "${sample}" after dupe removal >> /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/mapped_reads/stats_mapping_WGS2020.txt

samtools flagstat /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/mapped_reads/dedup_"${sample}"_map_bwa.bam >> /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/mapped_reads/stats_mapping_WGS2020.txt

echo '########################' >> /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/mapped_reads/stats_mapping_WGS2020.txt

# Using bedtools to get our coverage for each genome
bedtools genomecov -ibam /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/mapped_reads/dedup_"${sample}"_map_bwa.bam -d > /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/mapped_reads/"${sample}".cov
