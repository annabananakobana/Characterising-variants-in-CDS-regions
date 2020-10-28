#!/bin/bash -e
#SBATCH --account=uoo02820 
#SBATCH --job-name=fastqc 
#SBATCH --time=48:00:00 
#SBATCH --mem=48GB
#SBATCH --ntasks=1 
#SBATCH --cpus-per-task=16 
#SBATCH --mail-user=anna.clark@postgrad.otago.ac.nz
#SBATCH --chdir=/nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/

module load FastQC/0.11.7

# Run fastqc using two threads
fastqc -t 32 *.fastq.gz
