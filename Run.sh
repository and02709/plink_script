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

# Check for command line arguments
if [ $# -eq 0 ]; then
  echo "No arguments provided."
  show_help
  exit 1
fi

wd=$(pwd)

# *** Make sure you have a new enough getopt to handle long options (see the man page)
getopt -T &>/dev/null
if [[ $? -ne 4 ]]; then echo "Getopt is too old!" >&2 ; exit 1 ; fi

declare {wd,file,maf}
OPTS=$(getopt -u -o '' -a --longoptions 'wd:,file:,maf:' -n "$0" -- "$@")
    # *** Added -o '' ; surrounted the longoptions by ''
if [[ $? -ne 0 ]] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi
    # *** This has to be right after the OPTS= assignment or $? will be overwritten

set -- $OPTS
    # *** As suggested by chepner

while [[ $# -gt 0 ]]; do
  key=$1
  case $key in
	--wd )
		wd=$2
		shift 2
		;;
	--file )
		file=$2
		shift 2
		;;
	--maf )
		maf=$2
		shift 2
		;;
    --)
			shift
			break
			;;
    	*)
  esac
done


echo "working directory: $wd"
echo "input file name: $file"
echo "minor allele frequency: $maf"

# Make output directory
cd $wd
mkdir maf_files

# Load singularity image for plink
module load singularity
singularity pull docker://and02709/plink_container:slim

sbatch --time 0:10:00 --mem 2GB --array 1-22 --wait -N1 ${wd}/plink_script/maf_individual.sh ${wd} ${file} ${maf}

rm plink_container_slim.sif

exit 0
