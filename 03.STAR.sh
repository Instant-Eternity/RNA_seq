##########################################################################
# File Name: 03.STAR.sh
# Author: Instant-Eternity
# mail: hunterfirstone@i.smu.edu.cn
# Created Time: Mon 29 Mar 2021 09:31:56 PM CST
#########################################################################
#!/bin/bash
# Default values for paths and species
species="human"
data_dir=$PWD
output_dir=$PWD

# Function to display usage information
usage() {
    echo "Usage: $(basename "$0") -s <species> -d <data_path> -o <output_directory>"
    exit 1
}

# Parse command line options
while getopts ":s:d:o:" opt; do
    case $opt in
        s)
            species="$OPTARG"
            case $species in
                "human")
                    ref="hg38"
                    ;;
                "mouse")
                    ref="mm10"
                    ;;
                *)  
                    echo "Invalid species: $species" >&2
                    usage
                    ;;
            esac
            ;;
        d)
            data_dir="$OPTARG"
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
for dir in "$data_dir" "$output_dir"; do
    if [ ! -d "$dir" ]; then
        echo "Error: Directory '$dir' not found."
        usage
    fi
done

# Create output directories if they don't exist
mkdir -p "$output_dir/03.STAR"

time STAR --runThreadN 20 \
	--genomeDir $ref \
 	--readFilesCommand gunzip \
  	-c --readFilesIn $data_ABX/clp-abx-1_FRAS210074515-1r_1.clean.fq.gz $data_ABX/clp-abx-1_FRAS210074515-1r_2.clean.fq.gz \
	--outSAMtype BAM SortedByCoordinate \
 	--outFileNamePrefix $result/ABX-1
