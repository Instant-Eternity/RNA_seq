##########################################################################
# File Name: 04.Count.sh
# Author: Instant-Eternity
# mail: hunterfirstone@i.smu.edu.cn
# Created Time: Sun 30 May 2021 12:10:20 PM CST
#########################################################################
#!/bin/bash
# Default values for paths and species
input_dir=$PWD
output_dir=$PWD
species="human"
alignment="02.HISAT2Sort"

# Function to display usage information
usage() {
    echo "Usage: $(basename "$0") -i <input_directory> -o <output_directory> -a <alignment_type> -s <species>"
    exit 1
}

# Parse command line options
while getopts ":s:a:i:o:" opt; do
    case $opt in
        a)
            alignment="$OPTARG"
            case $alignment in
                "hisat2")
                    alignment="02.HISAT2Sort"
                    ;;
                "star")
                    alignment="02.STARSort"
                    ;;
                *)
                    echo "Invalid alignment type: $alignment" >&2
                    usage
                    ;;
            esac
            ;;
        s)
            species="$OPTARG"
            case $species in
                "human")
                    ref="human.gtf"
                    ;;
                "mouse")
                    ref="gencode.vM27.annotation.gtf"
                    ;;
                *)
                    echo "Invalid species: $species" >&2
                    usage
                    ;;
            esac
            ;;
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
if [ ! -d "$input_dir" ] || [ ! -d "$output_dir" ]; then
    echo "Error: Input or output directory not found."
    usage
fi

# Create output directories if they don't exist
mkdir -p "$output_dir/04.Count"

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

# Perform HTSeq-count for each sample
for sample in "${samples[@]}"; do
    echo "Processing sample: $sample"
    htseq-count -r pos -f bam "$output_dir/$alignment/$sample.Sorted.bam" "$ref" > "$output_dir/04.Count/$sample.count"
done

echo "HTSeq-count completed."
