#!/bin/bash -e

cd /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/complete_exon_rrattus_ref_seq/

module load BEDTools/2.28.0-gimkl-2018b

#merge the bedfile based on chr start and end positions so that we don't have overlaps from alt alleles
bedtools merge -i CDS_loci_male.bed -s -c 4,5,6,7,8,9,10 -o distinct > merged_CDS_loci_male.bed 2> merged_CDS_loci_male.se
