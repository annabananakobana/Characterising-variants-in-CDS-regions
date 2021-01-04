#!/bin/bash -e
#SBATCH -A uoo02820
#SBATCH -J mapping_WGS
#SBATCH --time 23:00:00
#SBATCH -N 1
#SBATCH -c 16
#SBATCH -n 1
#SBATCH --mem=48G
#SBATCH --array 1-46
#SBATCH --chdir=/nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/

#Load modules, make sure you have actually indexed your ref seq
module load BWA/0.7.17-gimkl-2017a
module load SAMtools/1.10-GCC-9.2.0
module load picard/2.21.8-Java-11.0.4
module load BEDTools/2.29.2-GCC-9.2.0

# NEW going to modify the loop so it is just "straight code" that runs off the slurm array #
# NEW this is going to go from 0 to 45 all in one go (i.e. 46 jobs in one go)
line_no=`expr ${SLURM_ARRAY_TASK_ID} \* 2 - 1`

# Getting the sample name and R2 name from the R1 name
# The following variable captures the contents of the file_list.txt file for the sample we are up to
sample=`head -n $line_no file_list.txt | tail -n 1 | awk '{print $2}'`;
R1=`head -n $line_no file_list.txt | tail -n 1 | awk '{print $1}'`;
R2=`head -n $(expr $line_no + 1) file_list.txt | tail -n 1 | awk '{print $1}'`;

# Mapping reads using bwa
bwa mem -t 32 /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/complete_exon_rrattus_ref_seq/GCF_011064425.1_Rrattus_CSIRO_v1_genomic.fasta \
  "$R1" \
  "$R2" > /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/mapped_reads/"${sample}"_map_bwa.sam
	
# this is a progress upate echo so we can follow along where we are up to
echo removing duplicates from ${sample}

#note: We used the output sort files for script 2_1_dedup_mapped_reads.sh due to corrupted files in downstream
#processing. Need to lower resource req if you are to run this specific mapping script again and 
#remove --partition=large so it runs faster.
