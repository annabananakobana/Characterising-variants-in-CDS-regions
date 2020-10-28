#!/bin/bash -e 

#To be run in fastqc folder
# Used to extract summary.txt file from each fastqc file
# After running will have to run fastqc_summary.R
# Compares before and after trimming fastqc results

cd /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data

for i in *.zip;
do foldername=`echo $i | sed 's/.zip//g'`;
unzip $i;
cat $foldername/summary.txt >> fastqc_summary.txt;
rm -rf $foldername;
done

