#!/bin/bash -e

#find the chr scaffolds
grep "assembled-molecule" /nesi/nobackup/uoo02820/refseq_rrat_annotation/GCF_011064425.1_Rrattus_CSIRO_v1_assembly_report.txt | awk '{print $1,$7,$10}' >> /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/complete_exon_rrattus_ref_seq/extracted_chr_and_scaffolds.txt 2> /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/complete_exon_rrattus_ref_seq/extracted_chr_and_scaffolds.se

#change directory
cd /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/complete_exon_rrattus_ref_seq/

#filtering for columns 2 and 3
awk '{print $2,$3}' extracted_chr_and_scaffolds.txt >> chr_scaffold_lengths.txt 2> chr_scaffold_lengths.se

#make the text file tab delimited so that bedtools can handle the jandal
sed -i 's/ /\t/g' chr_scaffold_lengths.txt
