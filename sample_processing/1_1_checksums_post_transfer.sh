#!/bin/bash -e 

cd /nesi/nobackup/uoo02820/Rattus_rattus_pop_data/30_samples/

md5sum -c md5.md5 > verify_file_integrity.txt 2>verify_file_integrity.se
