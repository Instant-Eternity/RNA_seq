##########################################################################
# File Name: 02.HISAT2.sh
# Author: Instant-Eternity
# mail: hunterfirstone@i.smu.edu.cn
# Created Time: Sun 28 Mar 2021 09:54:06 PM CST
#########################################################################
#!/bin/bash
# Default values for paths and species
species="human"
ref="hg38"
data=$PWD
output_dir=$PWD
sam_bam_dir="$output_dir/04_sam_to_bam"

# Function to display usage information
usage() {
    echo "Usage: $(basename "$0") -s <species> -a <abx_data_path> -c <ctrl_data_path> -o <output_directory>"
    exit 1
}

# Parse command line options
while getopts ":s:a:c:o:" opt; do
    case $opt in
        s)
            species="$OPTARG"
            case $species in
                "human")
                    ref="/path/to/human_reference"
                    ;;
                "mouse")
                    ref="/path/to/mouse_reference"
                    ;;
                *)  
                    echo "Invalid species: $species" >&2
                    usage
                    ;;
            esac
            ;;
        a)
            data_ABX="$OPTARG"
            ;;
        c)
            data_Ctrl="$OPTARG"
            ;;
        o)
            output_dir="$OPTARG"
            sam_bam_dir="$output_dir/04_sam_to_bam"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done

# Check if required directories exist
for dir in "$ref" "$data_ABX" "$data_Ctrl" "$output_dir" "$sam_bam_dir"; do
    if [ ! -d "$dir" ]; then
        echo "Error: Directory '$dir' not found."
        usage
    fi
done

# Rest of your script remains unchanged

# Example usage:
# ./03.hisat2.sh -s human -a /path/to/abx_data -c /path/to/ctrl_data -o /path/to/output_directory
# ./03.hisat2.sh -s mouse -a /path/to/abx_data -c /path/to/ctrl_data -o /path/to/output_directory
