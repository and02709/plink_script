#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4GB
#SBATCH --time=0:30:00
#SBATCH -p agsmall
#SBATCH -o rfmix_%a.out
#SBATCH -e rfmix_%a.err
#SBATCH --job-name rfmix

WD=$1
FILE=$2
MAF=$3
CHR=$SLURM_ARRAY_TASK_ID

module load singularity

singularity exec plink.sif plink --bfile $FILE --chr $CHR --maf $MAF --make-bed --out /${WD}/maf_${CHR}
