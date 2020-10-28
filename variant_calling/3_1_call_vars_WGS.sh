#!/bin/bash -e
#SBATCH -A uoo02820
#SBATCH -J var_call
#SBATCH --time 24:00:00
#SBATCH -N 1
#SBATCH -c 72
#SBATCH -n 1
#SBATCH --mem=12G
#SBATCH --mail-user=anna.clark@postgrad.otago.ac.nz
#SBATCH --mail-type=ALL
#SBATCH --chdir=/nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/mapped_reads/

# Before running this code, the reference needs to be faidx indexed using samtools
# module load SAMtools/1.10-GCC-9.2.0
# samtools faidx GCF_011064425.1_Rrattus_CSIRO_v1_genomic.fasta

# Before you run this command, you will need a list of your de-duplicated bam files
# that are found within your mapping directory
# ls dedup_* > new_bamlist

# Load module
module load BCFtools/1.10.2-GCC-9.2.0

# run var caller
bcftools mpileup -a AD -C 0 -d 20000 --threads 144 -Ou \
  -f /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/complete_exon_rrattus_ref_seq/GCF_011064425.1_Rrattus_CSIRO_v1_genomic.fasta \
  -b new_bamlist | bcftools call -mv -Ov \
  -o WGS2020_vars_BCF_46samples.vcf
