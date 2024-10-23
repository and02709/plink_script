#!/bin/bash

# Check for command line arguments
if [ $# -eq 0 ]; then
  echo "No arguments provided."
  show_help
  exit 1
fi

# *** Make sure you have a new enough getopt to handle long options (see the man page)
getopt -T &>/dev/null
if [[ $? -ne 4 ]]; then echo "Getopt is too old!" >&2 ; exit 1 ; fi

declare {wd,input_directory,input_file_name,path_to_github_repo,user_x500,use_crossmap,use_genome_harmonizer,use_rfmix,make_report,custom_qc,help}
OPTS=$(getopt -u -o '' -a --longoptions 'wd:,input_directory:,input_file_name:,path_to_github_repo:,user_x500:,use_crossmap:,use_genome_harmonizer:,use_rfmix:,make_report:,custom_qc:,help' -n "$0" -- "$@")
    # *** Added -o '' ; surrounted the longoptions by ''
if [[ $? -ne 0 ]] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi
    # *** This has to be right after the OPTS= assignment or $? will be overwritten

set -- $OPTS
    # *** As suggested by chepner

while [[ $# -gt 0 ]]; do
  key=$1
  case $key in
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

echo "input file name: $file"
echo "minor allele frequency: $maf"

mkdir maf_files

sbatch --time 0:10:00 --mem 2GB --array 1-22 --wait -N1 /plink_script/maf_individual.sh ${file} ${maf}


exit 0
