#!/bin/bash -e

#change directory
cd /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/mapped_CDS_WGS/

#module load bedtools
module load BEDTools/2.28.0-gimkl-2018b

bedtools slop -i final_filtered_CDS_female.bed -g chr_scaffold_lengths.txt -b 20 -s > padded_final_filtered_CDS_female.bed 2> padded_final_filtered_CDS_female.se
