##########################################################################
# File Name: 03.Assemble.sh
# Author: Instant-Eternity
# mail: hunterfirstone@i.smu.edu.cn
# Created Time: Mon 29 Mar 2021 09:31:56 PM CST
#########################################################################
#!/bin/bash

# Default values for paths and species
input_dir=$PWD
output_dir=$PWD

# Function to display usage information
usage() {
    echo "Usage: $(basename "$0") -i <input_directory> -o <output_directory>"
    exit 1
}

# Parse command line options
while getopts ":i:o:" opt; do
    case $opt in
        i)
            input_dir="$OPTARG"
            ;;
        o)
            output_dir="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done

# Check if required directories exist
for dir in "$input_dir" "$output_dir"; do
    if [ ! -d "$dir" ]; then
        echo "Error: Directory '$dir' not found."
        usage
    fi
done

# Create output directories if they don't exist
mkdir -p "$output_dir/03.StringTie"

# Extract sample names and store them in an array
samples=()
for file in "$input_dir"/*.Sorted.bam; do
    # Extract the part of the filename before the dot
    sample=$(basename "$file" | cut -d'.' -f1-2)
    # Check if the sample is not already in the array and add it
    if [[ ! " ${samples[@]} " =~ " ${sample} " ]]; then
        samples+=("$sample")
    fi
done

# Perform StringTie assembly for each sample
for sample in "${samples[@]}"; do
    echo "Processing sample: $sample"
    time stringtie "$input_dir/$sample.Sorted.bam" -l "$sample" \
        -o "$output_dir/03.Assemble/$sample/$sample.gtf" \
        -p 28 -G "$ref" \
        -A "$output_dir/03.Assemble/$sample/$sample.gene_abund.tab" \
        -B -e
done

echo "StringTie assembly completed."
