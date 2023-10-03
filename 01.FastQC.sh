##########################################################################
# File Name: 01.FastQC.sh
# Author: Instant-Eternity
# mail: hunterfirstone@i.smu.edu.cn
# Created Time: Thu 25 Mar 2021 09:28:47 AM CST
#########################################################################
#!/bin/bash

# Default values for input and output paths
input_path=""
output_path=""

# Function to display usage information
usage() {
    echo "Usage: $(basename "$0") -i <input_path> -o <output_path>"
    echo "Options:"
    echo "  -i, --input <input_path>    Set input path"
    echo "  -o, --output <output_path>  Set output path"
    exit 1
}

# Parse command line options
while getopts ":i:o:h" opt; do
    case $opt in
        i|--input)
            input_path="$OPTARG"
            ;;
        o|--output)
            output_path="$OPTARG"
            ;;
        h)
            usage
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done

# Shift option index so that $1 now refers to the first non-option argument
shift $((OPTIND - 1))

# Your fastqc commands using the input and output paths
time fastqc -o "$output_path" -f fastq "$input_path/*.fq.gz"
