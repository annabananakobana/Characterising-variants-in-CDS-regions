#!/bin/bash -e
#SBATCH -A uoo02820
#SBATCH -J cutadaptors # This is the same as job name we used previously
#SBATCH --time 06:00:00 
#SBATCH -N 1
#SBATCH -c 8
#SBATCH -n 1
#SBATCH --mem=3G # Total amount of memory. Generally the formula is 3GB/cpu for optimal "billing"
#SBATCH --partition=large # Same one as last time
#SBATCH --mail-user=anna.clark@postgrad.otago.ac.nz # email address
#SBATCH --mail-type=ALL
#SBATCH --array 1-46
#SBATCH --chdir=/nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/

## load modules
module load cutadapt/2.3-gimkl-2018b-Python-3.7.3
module load FastQC/0.11.7

# This script depends on a key.txt file being available in the folder where the fastq.gz files are located
# (i.e. in the directory listed in the sbatch commands above). This key.txt file should have the R1 filename
# followed by a space and then the sample name, and on the next line the R2 filenmae followed by a space and
# then the sample name.

#no_lines_in_key=`wc -l key.txt | awk '{print $1}'` # we are creating a variable that saves the number of lines in key.txt

# This for loop is going to step through every second line in our key.txt file
# i.e. is going to do cutadapt on a per sample basis, not a per file basis
# NEW going to modify the loop so it is just "straight code" that runs off the slurm array #
# NEW this is going to go from 0 to 45 all in one go (i.e. 46 jobs in one go)
line_no=`expr ${SLURM_ARRAY_TASK_ID} \* 2 - 1`

# The following variable captures the contents of the key.txt file for the sample we are up to
sample_name=`head -n $line_no key.txt | tail -n 1 | awk '{print $2}'`;
R1_name=`head -n $line_no key.txt | tail -n 1 | awk '{print $1}'`;
R2_name=`head -n $(expr $line_no + 1) key.txt | tail -n 1 | awk '{print $1}'`;
cutadapt -j 0 -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
  -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
  -m 100 \
  -q 20 \
  -o /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/${sample_name}.trimmed.R1.fastq.gz \
  -p /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/${sample_name}.trimmed.R2.fastq.gz \
  ${R1_name} \
  ${R2_name}

fastqc -t 16 /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/trimmed_data/${sample_name}.trimmed.*

