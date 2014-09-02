#!/usr/bin/env Rscript
# This script is used to analyse spindle positioning in cells confined in channels. It takes a .csv file with cell edge and spindle pole coordinates and calculates spindle length, angle and asymmetry with respect to the cell.

# INPUT
# The script assumes that the cell long axis is horizontal with respect to the channel, and assumes the header of the .csv file to contain the following fields:
# cell_number, ID, frame, left_edge_x, left_edge_y, left_pole_x, left_pole_y, right_pole_x, right_pole_y, right_edge_x, right_edge_y
# Here is a description of the different fields:
# cell_number is an integer used to distinguish different cells in the same .csv file
# ID is a unique string identifying the cell
# frame is the frame number for time-lapse movies
# left_edge_x is the x coordinate of the cell left edge
# left_edge_y is the y coordinate of the cell left edge
# left_pole_x is the x coordinate of the spindle left pole
# left_pole_y is the y coordinate of the spindle left pole
# right_pole_x is the x coordinate of the spindle right pole
# right_pole_y is the y coordinate of the spindle right pole
# right_edge_x is the x coordinate of the cell right edge
# right_edge_y is the y coordinate of the cell right edge

# PROCESSING
# The script processes the input in order to obtain the following:
# spindle_length -> the euclidian distance between the two spindle poles
# spindle_angle -> calculated in degrees as the angle between the horizontal axis and the vector pointing from the left spindle pole to the right pole, thus for positive angles the right pole points upwards and for negative angles it points downwards
# cell length -> the distance on the x-axis between the two cell extremities
# dist_left_pole_to_edge -> the distance on the x-axis between the spindle left pole and the left cell edge
# dist_right_pole_to_edge -> the distance on the x-axis between the spindle right pole and the right cell edge
# spindle_ratio_asymmetry -> calculated as the ratio between two distances on the x-axis: the longest distance between the spindle center and the cell edge, divided by the shortest distance between the spindle center and the cell edge. Then the asymmetry is normalised and given in percentage (no upper bound)
# spindle_diff_asymmetry -> calculated as the difference on the x-axis between the longest distance from the spindle center to the cell edge and the shortest distance between the spindle center and the cell edge. Then the asymmetry is normalised by its maximum value and given in percentage (between 0 and 100%)

channel_cross_section <- 98 # µm^2 area of channels
temporal_resolution <- 3 # minutes
spatial_resolution <- 0.645 # µm/pixel

data <- read.csv('/Users/andimi/Desktop/FromClotilde/140627-HeLa-HCTG-MCAKRNAi-Channels98_analyse_140715_15cells.csv', header = TRUE)

source("calculate_spindle_parameters.R")
data <- add_spindle_parameters(data, spatial_resolution)
data <- add_cell_parameters(data, spatial_resolution)

#write.csv(data, 'write_test.csv')
head(data)
