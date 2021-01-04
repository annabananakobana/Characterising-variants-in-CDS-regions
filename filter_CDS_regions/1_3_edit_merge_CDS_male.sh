#!/bin/bash -e 

cd /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/complete_exon_rrattus_ref_seq

cat merged_CDS_loci_male.bed | \
awk -v "OFS=\t" '{$4=$4;sub(/cds-XP_032746038.1/, "Spaca1", $4); sub(/cds-XP_032746045.1/, "Spaca1", $4); \
sub(/cds-XP_032747026.1/, "Catsper1", $4); sub(/cds-XP_032749518.1/, "Izumo1", $4); \
sub(/cds-XP_032749809.1/, "Gapdhs", $4); sub(/cds-XP_032749807.1/, "Gapdhs", $4); \
sub(/cds-XP_032749808.1/, "Gapdhs", $4); sub(/cds-XP_032753719.1/, "Oaz3", $4); \
sub(/cds-XP_032759951.1/, "Catsper2", $4); sub(/cds-XP_032758304.1/, "Sun5", $4); \
sub(/cds-XP_032758305.1/, "Sun5", $4); sub(/cds-XP_032758306.1/, "Sun5", $4); \
sub(/cds-XP_032760449.1/, "Spag4", $4); sub(/cds-XP_032760450.1/, "Spag4", $4); \
sub(/cds-XP_032763206.1/, "Capza3", $4); sub(/cds-XP_032763571.1/, "Ppp3r2", $4); \
sub(/cds-XP_032766093.1/, "Dpy19l2", $4); sub(/cds-XP_032767713.1/, "Spem1", $4); \
sub(/cds-XP_032772655.1/, "Zpbp", $4); sub(/cds-XP_032774762.1/, "Tssk6", $4); \
sub(/cds-XP_032741117.1/, "Meig1", $4); sub(/cds-XP_032745160.1/, "Slc26a8", $4); \
sub(/cds-XP_032745161.1/, "Slc26a8", $4); sub(/cds-XP_032745162.1/, "Slc26a8", $4); \
sub(/cds-XP_032745163.1/, "Slc26a8", $4); sub(/cds-XP_032745164.1/, "Slc26a8", $4); print}' \
> merged_CDS_loci_male_edited.bed 2> merged_CDS_loci_male_edited.se

#i then manually edit the bed output so that there is only one gene name listed in column 4
