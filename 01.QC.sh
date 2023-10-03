##########################################################################
# File Name: 01.FastQC.sh
# Author: Instant-Eternity
# mail: hunterfirstone@i.smu.edu.cn
# Created Time: Thu 25 Mar 2021 09:28:47 AM CST
#########################################################################
#!/bin/bash
# Default output path for FastQC and MultiQC reports
output_path=$PWD

# Function to display usage information
usage() {
    echo "Usage: $(basename "$0") [-o <output_path>] <input_path1> <input_path2> ... <input_pathN>"
    echo "Options:"
    echo "  -o <output_path>    Set output path (default: $output_path)"
    exit 1
}

# Parse command line options
while getopts ":o:" opt; do
    case $opt in
        o)
            output_path="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done

# Shift option index so that $1 now refers to the first non-option argument
shift $((OPTIND - 1))

# Check if at least one input path is provided
if [ "$#" -lt 1 ]; then
    echo "Error: At least one input path is required."
    usage
fi

# Loop through provided input paths and run FastQC
for input_path in "$@"; do
    echo "Running FastQC for $input_path"
    time fastqc -o "$output_path" -f fastq "$input_path"/*.fq.gz
done

# Run MultiQC to summarize the FastQC results
echo "Running MultiQC to summarize FastQC reports"
time multiqc "$output_path" -o "$outputpath"

echo "FastQC and MultiQC analysis completed."
