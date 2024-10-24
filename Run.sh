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
@@ -26,10 +23,6 @@ set -- $OPTS
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
@@ -46,14 +39,12 @@ while [[ $# -gt 0 ]]; do
  esac
done

echo "working directory: $wd"
echo "input file name: $file"
echo "minor allele frequency: $maf"

mkdir maf_files

sbatch --time 1:00:00 --mem 8GB --array 1-22 --wait -N1 maf_individual.sh ${wd} ${file} ${maf}
exit 0
