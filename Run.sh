#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2GB
#SBATCH --time=1:00:00
#SBATCH -p msismall
#SBATCH --mail-type=FAIL  
#SBATCH --mail-user=and02709@umn.edu 
#SBATCH -o MAF.out
#SBATCH -e MAF.err
#SBATCH --job-name MAF

$file=SMILES_GDA
$maf=0.01

echo "input file name: $file"
echo "minor allele frequency: $maf"

sbatch --time 0:10:00 --mem 2GB --array 1-22 --wait -N1 /plink_script/maf_individual.sh ${file} ${maf}


exit 0
