#!/bin/bash -e

cd /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/mapped_CDS_WGS/

module load BEDTools/2.28.0-gimkl-2018b

#combine large and rescued small exons 
cat CDS_small_under_100_apart_m.bed | awk 'BEGIN{OFS="\t"} { print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10}' >> final_filtered_CDS_male.bed
cat large_CDS_male.bed >> final_filtered_CDS_male.bed

cat CDS_small_under_100_apart_f.bed | awk 'BEGIN{OFS="\t"} { print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10}' >> final_filtered_CDS_female.bed
cat large_CDS_female.bed >> final_filtered_CDS_female.bed

#also sort the chromosomes again so the file is ordered
bedtools sort -i final_filtered_CDS_male.bed
bedtools sort -i final_filtered_CDS_female.bed
