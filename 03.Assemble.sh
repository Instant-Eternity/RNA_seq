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
ref="path/to/your/reference.gtf"  # Specify the path to your reference genome GTF file

# Function to display usage information
usage() {
    echo "Usage: $(basename "$0") -i <input_directory> -o <output_directory>"
    echo "Options:"
    echo "  -i <input_directory>  Path to input directory [default: current directory]"
    echo "  -o <output_directory> Path to output directory [default: current directory]"
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
if [ ! -d "$input_dir" ] || [ ! -d "$output_dir" ]; then
    echo "Error: Input or output directory not found."
    usage
fi

# Ensure a sample list exists before processing
if [ ! -f "$output_dir/sample.list" ]; then
    echo "Error: Sample list not found. Make sure to create the sample list in your output directory."
    exit 1
fi

# Create output directories if they don't exist
mkdir -p "$output_dir/03.StringTie"

# Perform StringTie assembly for each sample
while IFS= read -r sample; do
    echo "Processing sample: $sample"
    time stringtie "$input_dir/$sample.Sorted.bam" -l "$sample" \
        -o "$output_dir/03.StringTie/$sample/$sample.gtf" \
        -p 28 -G "$ref" \
        -A "$output_dir/03.StringTie/$sample/$sample.gene_abund.tab" \
        -B -e
done < "$output_dir/sample.list"

echo "StringTie assembly completed."
