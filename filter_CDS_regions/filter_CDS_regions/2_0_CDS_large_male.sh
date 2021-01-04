#!/bin/bash -e

cd /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/mapped_CDS_WGS/

#select for CDS regions bigger than 80nt
awk 'BEGIN{OFS="\t";} {if (($3 - $2)>80) print $0}' CDS_loci_m_twothirds.bed > large_CDS_male.bed 2> large_CDS_male.se
