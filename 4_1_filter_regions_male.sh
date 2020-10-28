#!/bin/bash -e

#SBATCH -A uoo02820
#SBATCH -J filter_WGS_male
#SBATCH --time 00:15:00
#SBATCH -N 1
#SBATCH -c 3
#SBATCH -n 1
#SBATCH --mem=2G
#SBATCH --qos=debug
#SBATCH --mail-user=anna.clark@postgrad.otago.ac.nz
#SBATCH --mail-type=ALL
#SBATCH --chdir=/nesi/nobackup/uoo02820/Rattus_rattus_pop_data/46_samples/trimmed_data/mapped_reads

module load VCFtools/0.1.14-gimkl-2018b-Perl-5.28.1

#filter based on depth and quality first
vcftools --vcf WGS2020_vars_BCF_46samples.vcf --minDP 2 --minQ 10 --bed /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/mapped_CDS_WGS/padded_final_filtered_CDS_male.bed --recode --recode-INFO-all --out WGS2020_vars_BCF_46samples_filtered_male
