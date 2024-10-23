#!/bin/bash

$file=$1
$maf=$2

echo "input file name: $file"
echo "minor allele frequency: $maf"

sbatch --time 0:10:00 --mem 2GB --array 1-22 --wait -N1 /plink_script/maf_individual.sh ${file} ${maf}


exit 0
