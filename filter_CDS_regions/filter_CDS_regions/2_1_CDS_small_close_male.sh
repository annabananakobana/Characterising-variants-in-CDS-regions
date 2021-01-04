#!/bin/bash -e

cd /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/mapped_CDS_WGS/

module load BEDTools/2.28.0-gimkl-2018b

#make sure the file is sorted 
bedtools sort -i CDS_loci_m_twothirds.bed

#rescue any small CDS that are close together
input="CDS_loci_m_twothirds.bed"
while IFS= read -r line
do
 echo $line
  echo "$line" > temp_CDS_m.bed
  grep -v "$line" $input | sortBed > temp_allbutCDS_m.bed
  bedtools closest -io -a temp_CDS_m.bed -b temp_allbutCDS_m.bed -d -s > temp_output_m
  cat temp_output_m >> CDS_with_info_m.bed 2>> CDS_with_info_m.se
done < "$input"

#use awk to filter for distances less than or equal to 100bp
awk 'BEGIN{OFS="\t";} {if($3 - $2 <80 && $21 <=100 && $21 >=1) print $0}' CDS_with_info_m.bed > CDS_small_under_100_apart_m.bed
