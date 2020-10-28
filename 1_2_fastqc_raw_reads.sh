#!/bin/bash -e
#SBATCH --account=uoo02820 # The account that will be "billed" for this job
#SBATCH --job-name=fastqc # job name (shows up in the queue)
#SBATCH --time=48:00:00 # Walltime (HH:MM:SS)
#SBATCH --mem=48GB # Memory in GB
#SBATCH --partition=large # "large" is the normal patition or queue we run jobs in
#SBATCH --ntasks=1 # We are not running stuff using fancy massively parallelness, so just one task
#SBATCH --cpus-per-task=16 # One "real" CPU = 2 hyperthreaded CPUs (NeSI makes them magically turn into 2!)
#SBATCH --mail-user=anna.clark@postgrad.otago.ac.nz
#SBATCH --chdir=/nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/

# That last one above is the directory we are running in
# We don't need to specify the directory if we submit the script in the directory we want stuff to happen in
# but it can be a good idea to do it just to remember where we ran things if we save the script
# OK, so all the stuff above are the "SBATCH" or "SLURM" parameters. They tell mahuika how many resources
# we need for this job and what we want to call it etc. After defining those, now we can tell the computer
# this script is going to run on, what we want it to do:

# Even though this is loaded for us on the headnode, we need to tell the computer that this job
# is going to run on to load it
module load FastQC/0.11.7

# Run fastqc using two threads (it will use the 2 magic hyperthread CPUs we've requested)
fastqc -t 32 *.fastq.gz
