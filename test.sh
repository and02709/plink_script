#!/bin/bash

echo "Beginning plink sequence"

plink --bfile /input/SMILES_GDA --maf 0.01 --make-bed --out /output/maffy
