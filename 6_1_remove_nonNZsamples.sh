#!/bin/bash -e

#SBATCH -A uoo02820
#SBATCH -J rm_nonNZsamples
#SBATCH --time 00:15:00
#SBATCH -N 1
#SBATCH -c 4
#SBATCH -n 1
#SBATCH --mem=3G
#SBATCH --qos=debug
#SBATCH --mail-user=anna.clark@postgrad.otago.ac.nz
#SBATCH --mail-type=ALL
#SBATCH --chdir=/nesi/nobackup/uoo02820/Rattus_rattus_pop_data/46_samples/trimmed_data/mapped_reads

module load VCFtools/0.1.14-gimkl-2018b-Perl-5.28.1
module load BEDTools/2.29.2-GCC-9.2.0
module load BEDOPS/2.4.30-gimkl-2017a

#filter based on depth and quality first
vcftools --vcf WGS2020_vars_BCF_46samples_filtered_female.recode.annotated.vcf --remove-indv dedup_sample_23_map_bwa_sorted.bam --remove-indv dedup_sample_24_map_bwa_sorted.bam --remove-indv dedup_sample_37_map_bwa_sorted.bam --remove-indv dedup_sample_38_map_bwa_sorted.bam --recode --recode-INFO-all --out WGS2020_vars_BCF_42samples_filtered_female_annotated

vcftools --vcf WGS2020_vars_BCF_46samples_filtered_male.recode.annotated.vcf --remove-indv dedup_sample_23_map_bwa_sorted.bam --remove-indv dedup_sample_24_map_bwa_sorted.bam --remove-indv dedup_sample_37_map_bwa_sorted.bam --remove-indv dedup_sample_38_map_bwa_sorted.bam --recode --recode-INFO-all --out WGS2020_vars_BCF_42samples_filtered_male_annotated

#expand the annotated variants 
#convert vcf file to bed format (remember 0-based to 1-based)
#use do-not-split to generate one BED record per variant call, irrespective of the number of alleles
#output from vcf2bed is sorted by default 
cat WGS2020_vars_BCF_42samples_filtered_female_annotated.recode.vcf | \
convert2bed --input=VCF --output=BED --do-not-split - >WGS2020_vars_BCF_42samples_filtered_female_annotated.bed

cat WGS2020_vars_BCF_42samples_filtered_male_annotated.recode.vcf | \
convert2bed --input=VCF --output=BED --do-not-split - >WGS2020_vars_BCF_42samples_filtered_male_annotated.bed

#expand the variant range 
#female candidates
bedtools slop -i WGS2020_vars_BCF_42samples_filtered_female_annotated.bed \
-g chr_scaffold_lengths.txt -b 50 >WGS2020_vars_BCF_42samples_filtered_female_annotated.expanded.bed

#male candidates
bedtools slop -i WGS2020_vars_BCF_42samples_filtered_male_annotated.bed \
-g chr_scaffold_lengths.txt -b 50 >WGS2020_vars_BCF_42samples_filtered_male_annotated.expanded.bed

#female targets
bedtools getfasta -name -fi /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/complete_exon_rrattus_ref_seq/GCF_011064425.1_Rrattus_CSIRO_v1_genomic.fasta \
-bed WGS2020_vars_BCF_42samples_filtered_female_annotated.expanded.bed \
-fo WGS2020_vars_BCF_42samples_filtered_female_annotated.expanded.fasta

#male targets
bedtools getfasta -name -fi /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/complete_exon_rrattus_ref_seq/GCF_011064425.1_Rrattus_CSIRO_v1_genomic.fasta \
-bed WGS2020_vars_BCF_42samples_filtered_male_annotated.expanded.bed \
-fo WGS2020_vars_BCF_42samples_filtered_male_annotated.expanded.fasta
