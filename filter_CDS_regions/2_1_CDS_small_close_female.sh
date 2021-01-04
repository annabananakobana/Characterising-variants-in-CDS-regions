#!/bin/bash -e

cd /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/trimmed_data/mapped_CDS_WGS/

module load BEDTools/2.28.0-gimkl-2018b

#make sure the file is sorted 
bedtools sort -i CDS_loci_f_twothirds.bed

#rescue any small CDS that are close together
input="CDS_loci_f_twothirds.bed"
while IFS= read -r line
do
 echo $line
  echo "$line" > temp_CDS_f.bed
  grep -v "$line" $input | sortBed > temp_allbutCDS_f.bed
  bedtools closest -io -a temp_CDS_f.bed -b temp_allbutCDS_f.bed -d -s > temp_output_f
  cat temp_output_f >> CDS_with_info_f.bed 2>> CDS_with_info_f.se
done < "$input"

#each CDS is a line, so we cut the first entry in the line for
#scaffold, start, end, collapsed variant info, neighbouring exon info, distance
#removed this line from final line as it is obsolete
#cut -f 1-4,8,9 CDS_with_info_f.bed > CDS_with_closest_nonoverlapping_f.bed

#use awk to filter for distances less than or equal to 100bp
awk 'BEGIN{OFS="\t";} {if($3 - $2 <80 && $21 <=100 && $21 >=1) print $0}' CDS_with_info_f.bed > CDS_small_under_100_apart_f.bed
