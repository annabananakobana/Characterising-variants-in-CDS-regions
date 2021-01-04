#!/bin/bash -e 

cd /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/complete_exon_rrattus_ref_seq

cat merged_CDS_loci_female.bed | \
awk -v "OFS=\t" '{$4=$4;sub(/cds-XP_032748085.1/, "Il11ra", $4); \
sub(/cds-XP_032743886.1/, "Padi6", $4); sub(/cds-XP_032752937.1/, "Kpna6", $4); \
sub(/cds-XP_032765109.1/, "Tle6", $4); sub(/cds-XP_032752185.1/, "Nlrp5", $4); \
sub(/cds-XP_032761249.1/, "Figla", $4); sub(/cds-XP_032761067.1/, "Nobox", $4); \
sub(/cds-XP_032765339.1/, "Pgr", $4); sub(/cds-XP_032766685.1/, "Izumo1r", $4); \
sub(/cds-XP_032767379.1/, "Ooep", $4); sub(/cds-XP_032769113.1/, "Gdf9", $4); \
sub(/cds-XP_032772113.1/, "Afp", $4); sub(/cds-XP_032772748.1/, "Zar1", $4); \
sub(/cds-XP_032773974.1/, "Dlgap5", $4); sub(/cds-XP_032742890.1/, "Zp3", $4); print}' \
> merged_CDS_loci_female_edited.bed 2> merged_CDS_loci_female_edited.se
