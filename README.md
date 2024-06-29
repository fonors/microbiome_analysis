# Scripts for Microbiome Analysis
Contains all the scripts used to perform a 16S analysis to reproduce the results of a study and compare.

## Usage
### Get Sequences script
***WARNING: You MUST have sra-tools installed for this script to run or it will NOT work. Conda environment (with Bioconda) recommended.***
Make `get_seqs.sh` executable and run it inside the folder where your `metadata.csv` file is located in.

### Pipeline Run script
***WARNING: You MUST have Docker, Java and Nextflow installed for this script to run or it will NOT work.***
Make `pipeline_run.sh` executable and input the necessary paths. The pipeline should run considering your machine has enough RAM and CPU power.

## Credits
These scripts were developed by fonors, goncalof21, MadalenaFranco2 & scmdcunha.
