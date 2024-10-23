#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4GB
#SBATCH --time=2:00:00
#SBATCH -p agsmall
#SBATCH -o rfmix_%a.out
#SBATCH -e rfmix_%a.err
#SBATCH --job-name rfmix

FILE=$1
MAF=$2
CHR=$SLURM_ARRAY_TASK_ID

module load singularity

singularity exec plink.sif plink --bfile /input/$file --chr $CHR --maf $MAF --make-bed --out /output/maf_${CHR}
