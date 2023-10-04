##########################################################################
# File Name: 02.HISAT2.sh
# Author: Instant-Eternity
# mail: hunterfirstone@i.smu.edu.cn
# Created Time: Sun 28 Mar 2021 09:54:06 PM CST
#########################################################################
#!/bin/bash

# Default values for paths and species
alignment="STAR"
species="human"
data_dir=$PWD
output_dir=$PWD

# Function to display usage information
usage() {
    echo "Usage: $(basename "$0") -s <species> -d <data_path> -o <output_directory> -a <alignment_method>"
    exit 1
}

# Parse command line options
while getopts ":s:d:o:a:" opt; do
    case $opt in
        a)
            alignment="$OPTARG"
            ;;
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

if [ "$alignment" == "HISAT2" ]; then
    # Create output directories if they don't exist
    mkdir -p "$output_dir/02.HISAT2SAM"
    mkdir -p "$output_dir/02.HISAT2BAM"
    mkdir -p "$output_dir/02.Alignment"

    # Extract sample names and store them in an array
    samples=()
    for file in "$data_dir"/*.1.clean.fq.gz; do
        # Extract the part of the filename before the dot
        sample=$(basename "$file" | cut -d'.' -f1-2)
        # Check if the sample is not already in the array and add it
        if [[ ! " ${samples[@]} " =~ " ${sample} " ]]; then
            samples+=("$sample")
        fi
    done

    for sample in "${samples[@]}"; do
        echo "Processing sample: $sample"
        time hisat2 --dta -t -x $ref \
            -1 "$data_dir/$sample.1.clean.fq.gz" \
            -2 "$data_dir/$sample.2.clean.fq.gz" \
            -S "$output_dir/02.HISAT2SAM/$sample.sam"
        time samtools view -bS "$output_dir/02.HISAT2SAM/$sample.sam" > "$output_dir/02.HISAT2BAM/$sample.bam"
        time samtools sort "$output_dir/02.HISAT2BAM/$sample.bam" -o "$output_dir/02.HISAT2Sort/$sample.Sorted.bam"
        time samtools index "$output_dir/02.HISAT2Sort/$sample.Sorted.bam"
        rm -rf "$output_dir/02.HISAT2SAM"
        rm -rf "$output_dir/02.HISAT2BAM"
    done
elif [ "$alignment" == "STAR" ]; then
    # Create output directories if they don't exist
    mkdir -p "$output_dir/02.Alignment"

    # Extract sample names and store them in an array
    samples=()
    for file in "$data_dir"/*.1.clean.fq.gz; do
        # Extract the part of the filename before the dot
        sample=$(basename "$file" | cut -d'.' -f1-2)
        # Check if the sample is not already in the array and add it
        if [[ ! " ${samples[@]} " =~ " ${sample} " ]]; then
            samples+=("$sample")
        fi
    done

    for sample in "${samples[@]}"; do
        echo "Processing sample: $sample"
        time STAR --runThreadN 20 \
            --genomeDir $ref \
            --readFilesCommand gunzip \
            -c --readFilesIn "$data_dir/$sample.1.clean.fq.gz" "$data_dir/$sample.2.clean.fq.gz" \
            --outSAMtype BAM SortedByCoordinate \
            --outFileNamePrefix "$output_dir/02.Alignment/$sample.Sorted.bam"
    done
fi

echo "Alignment and conversion completed."
