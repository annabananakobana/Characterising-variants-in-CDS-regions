#!/bin/bash -e
#SBATCH -A uoo02820
#SBATCH -J expand_variant_regions
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
module load BEDTools/2.29.2-GCC-9.2.0
module load BEDOPS/2.4.30-gimkl-2017a

#convert vcf file to bed format (remember 0-based to 1-based)
#use do-not-split to generate one BED record per variant call, irrespective of the number of alleles
#output from vcf2bed is sorted by default 
cat WGS2020_vars_BCF_46samples_filtered_female.recode.annotated.vcf | \
convert2bed --input=VCF --output=BED --do-not-split - >WGS2020_vars_BCF_46samples_filtered_female.recode.annotated.bed

cat WGS2020_vars_BCF_46samples_filtered_male.recode.annotated.vcf | \
convert2bed --input=VCF --output=BED --do-not-split - >WGS2020_vars_BCF_46samples_filtered_male.recode.annotated.bed

#expand the variant range 
#female candidates
bedtools slop -i WGS2020_vars_BCF_46samples_filtered_female.recode.annotated.bed \
-g chr_scaffold_lengths.txt -b 50 >WGS2020_vars_BCF_46_filtered_female.recode.annotated.expanded.bed

#male candidates
bedtools slop -i WGS2020_vars_BCF_46samples_filtered_male.recode.annotated.bed \
-g chr_scaffold_lengths.txt -b 50 >WGS2020_vars_BCF_46_filtered_male.recode.annotated.expanded.bed
