#!/usr/bin/env Rscript
# This script is used to analyse spindle positioning in cells confined in channels. It takes a list of .csv file with cell edge and spindle pole coordinates and calculates spindle length, angle and asymmetry with respect to the cell. This script uses the calculate_spindle_cell_parameters collection of functions and the script needs to be in the same folder

# INPUT - raw data
# This script is called from the command line as shown in this example:
# Rscript analysis_asymmetric_division_in_channels.R path/to/collection_of_inputs.csv path/to/output.csv
# collection_of_inputs.csv is a two column file with each line containing the path/to/input.csv and the condition of that experiment. This is later used to aggregate the statistics
# PROCESSING - spindle parameters and statistics
# The functions add_spindle_parameters and add_cell_parameters are used to compute spindle positioning data with respect to the cell edge. See calculate_spindle_parameters.R for more details about their use and implementation
# OUTPUT - visualisation
# TO DO

args <- commandArgs(TRUE)

# channel_cross_section <- 98 # µm^2 area of channels
# temporal_resolution <- 3 # minutes
spatial_resolution <- 0.645 # µm/pixel

collection <- read.csv(args[1], header = TRUE)
source("calculate_spindle_parameters.R")
for (i in 1:nrow(collection)){
    tmp_data <- add_spindle_cell_parameters(toString(collection$path[i]), toString(collection$condition[i]), spatial_resolution)
    if (i == 1) data <- tmp_data else data <- rbind(data, tmp_data)
}
#write.csv(data, args[2])
