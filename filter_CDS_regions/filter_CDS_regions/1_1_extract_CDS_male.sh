#!/bin/bash -e

cd /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/complete_exon_rrattus_ref_seq/

module load BEDTools/2.28.0-gimkl-2018b
module load BEDOPS/2.4.30-gimkl-2017a

#find our genes in the gene feature file and output the CDS
#use bedtools to convert from gff format to bed, bc they have different feature coordinate systems
#take the output from previous run and filter for the stuff we actually need
#use sed to make a tab delim file
#merge the bedfile based on chr start and end positions so that we don't have overlaps from alt alleles
grep -Fwf male_genes.txt GCF_011064425.1_Rrattus_CSIRO_v1_genomic.gff | awk '{if ($3=="CDS") print $0}' | convert2bed --input=gff | sed -e 's/ /_/g' > CDS_loci_male.bed 2> CDS_loci_male.se
