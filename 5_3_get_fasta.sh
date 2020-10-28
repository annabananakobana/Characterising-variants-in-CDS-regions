#!/bin/bash -e
#SBATCH -A uoo02820
#SBATCH -J get_fasta
#SBATCH --time 00:15:00
#SBATCH -N 1
#SBATCH -c 4
#SBATCH -n 1
#SBATCH --mem=3G
#SBATCH --qos=debug
#SBATCH --mail-user=anna.clark@postgrad.otago.ac.nz
#SBATCH --mail-type=ALL
#SBATCH --chdir=/nesi/nobackup/uoo02820/Rattus_rattus_pop_data/46_samples/trimmed_data/mapped_reads

#load the modules
module load BEDTools/2.29.2-GCC-9.2.0

#female targets
bedtools getfasta -name -fi /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/complete_exon_rrattus_ref_seq/GCF_011064425.1_Rrattus_CSIRO_v1_genomic.fasta \
-bed WGS2020_vars_BCF_46_filtered_female.recode.annotated.expanded.bed \
-fo WGS2020_vars_BCF_46_filtered_female.recode.annotated.expanded.fasta

#male targets
bedtools getfasta -name -fi /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/complete_exon_rrattus_ref_seq/GCF_011064425.1_Rrattus_CSIRO_v1_genomic.fasta \
-bed WGS2020_vars_BCF_46_filtered_male.recode.annotated.expanded.bed \
-fo WGS2020_vars_BCF_46_filtered_male.recode.annotated.expanded.fasta
