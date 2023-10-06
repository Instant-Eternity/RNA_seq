##########################################################################
# File Name: 05.Merge.R
# Author: Instant-Eternity
# mail: hunterfirstone@i.smu.edu.cn
# Created Time: Sun 30 May 2021 14:15:06 PM CST
#########################################################################
#!/usr/bin/env Rscript
rm(list = ls())
gc()

# Load necessary libraries
library(getopt)

options(stringsAsFactors = FALSE)

# Define command line options
options <- getopt(
	command.line = TRUE,
	options = list(
		'input-path=',
		'sample-list=',
		'output-path=',
		'help'
	),
	longnames = c("input-path", "sample-list", "output-path", "help"),
	shortnames = c("i", "s", "o", "h"),	
	usage = "Usage: script.R --input-path=<input-path> --sample-list=<sample-list> --output-path=<output-path>"
)

# Function to print help document
print_help <- function() {
    cat("Usage: script.R\n")
	cat("-i, --input-path=<input-path>   : Path to input directory\n")
	cat("-s, --sample-list=<sample-list>   : Sample list\n")
	cat("-o, --output-path=<output-path>: Path to output directory\n")
	cat("-h, --help                 : Print this help message\n")
	quit(save = "no")
}

# Check if help option is provided
if ("help" %in% names(options)) {
	print_help()
}

# Check if required options are provided
if (length(options$input-path) == 0 || length(options$sample-list) == 0 || length(options$output-path) == 0) {
	stop("Error: All parameters are required. Use -h or --help for usage information.")
}

# Access the parameters
input_path <- options$input-path
sample_list_path <- options$sample-list
output_path <- options$output-path

# Read sample list file
sample_list <- read.table(sample_list_path, header = FALSE, stringsAsFactors = FALSE)

# Create empty list to store sample objects
sample_objects <- list()

# Loop through the sample list and create objects
for (i in 1:(nrow(sample_list) - 1)) {
    sample_name <- sample_list[i, 1]
    sample_object <- read.table(paste0(input_path, "/", sample_name, ".count"), 
                                sep = "\t",
                                col.names = c("gene_id", sample_name))
    # Add the sample object to the list
    sample_objects[[sample_name]] <- sample_object
}

# Merge sample objects
merged_object <- sample_objects[[1]]

for (i in 2:(length(sample_objects))) {
    merged_object <- merge(merged_object, sample_objects[[i]], by = "gene_id", all = TRUE)
}

ENSEMBL <- gsub("\\.\\d*", "", Raw_count_filt$gene_id) 
row.names(Raw_count_filt) <- ENSEMBL
head(merged_object)

saveRDS(merged_object, paste0(output_path, "/01.MergeData.rds")
