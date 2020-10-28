#!/bin/bash -e
#SBATCH -A uoo02820
#SBATCH -J vcf_annotate
#SBATCH --time 00:15:00
#SBATCH -N 1
#SBATCH -c 4
#SBATCH -n 1
#SBATCH --mem=3G
#SBATCH --qos=debug
#SBATCH --mail-user=anna.clark@postgrad.otago.ac.nz
#SBATCH --mail-type=ALL
#SBATCH --chdir=/nesi/nobackup/uoo02820/Rattus_rattus_pop_data/46_samples/trimmed_data/mapped_reads

#load the bcftools module 
module load BCFtools/1.10.2-GCC-9.2.0

#annotate female targets
bcftools annotate -c CHROM,FROM,TO,ID -a padded_final_filtered_CDS_female_edit.bed -o WGS2020_vars_BCF_46samples_filtered_female.recode.annotated.vcf WGS2020_vars_BCF_46samples_filtered_female.recode.vcf
#annotate male targets
bcftools annotate -c CHROM,FROM,TO,ID -a padded_final_filtered_CDS_male_edit.bed -o WGS2020_vars_BCF_46samples_filtered_male.recode.annotated.vcf WGS2020_vars_BCF_46samples_filtered_male.recode.vcf
