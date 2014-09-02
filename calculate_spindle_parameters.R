#!/usr/bin/env Rscript
# This file is a collection of functions useful to analyse spindle data. 

# FUNCTION add_spindle_parameters
# INPUT
# The function assumes the argument 'data' to be a dataframe containing the following field:
# left_pole_x -> the x coordinate of the spindle left pole
# left_pole_y -> the y coordinate of the spindle left pole
# right_pole_x -> the x coordinate of the spindle right pole
# right_pole_y -> the y coordinate of the spindle right pole
# spatial_resolution -> resolution in µm/pixel
# OUTPUT
# spindle_length -> the euclidian distance between the two spindle poles
# spindle_angle -> calculated in degrees as the angle between the horizontal axis and the vector pointing from the left spindle pole to the right pole, thus for positive angles the right pole points upwards and for negative angles it points downwards
# spindle_centre_x/y -> the x/y coordinate of the mean point between the spindle poles

add_spindle_parameters <- function(data, spatial_resolution){
    spindle_delta_x <- (data$right_pole_x - data$left_pole_x) * spatial_resolution
    spindle_delta_y <- (data$right_pole_y - data$left_pole_y) * spatial_resolution
    data$spindle_length <- sqrt(spindle_delta_x ^ 2 + spindle_delta_y ^ 2)
    data$spindle_angle <- atan2(spindle_delta_y, spindle_delta_x) * 180 / pi
    data$spindle_centre_x <- (data$left_pole_x + data$right_pole_x) / 2
    data$spindle_centre_y <- (data$left_pole_y + data$right_pole_y) / 2
    return(data)
}

# FUNCTION add_cell_parameters
# INPUT
# The function assumes the same inputs as add_spindle_parameters plus its outputs, and in addition to those 'data' needs to contain the following fields:
# left/right_edge_x/y -> the x/y coordinate of the cell left/right edge
# OUTPUT
# cell_length -> the distance on the x-axis between the two cell extremities
# dist_left_pole_to_edge -> the distance on the x-axis between the spindle left pole and the left cell edge
# dist_right_pole_to_edge -> the distance on the x-axis between the spindle right pole and the right cell edge
# spindle_ratio_asymmetry -> calculated as the ratio between two distances on the x-axis: the longest distance between the spindle center and the cell edge, divided by the shortest distance between the spindle center and the cell edge. Then the asymmetry is normalised and given in percentage (no upper bound)
# spindle_diff_asymmetry -> calculated as the difference on the x-axis between the longest distance from the spindle center to the cell edge and the shortest distance between the spindle center and the cell edge. Then the asymmetry is normalised by its maximum value and given in percentage (between 0 and 100%)

add_cell_parameters <- function(data, spatial_resolution){
    right_sp_centre_to_edge <- ((data$right_edge_x - data$spindle_centre_x)
                               * spatial_resolution)
    left_sp_centre_to_edge <- ((data$spindle_centre_x - data$left_edge_x)
                              * spatial_resolution)
    data$dist_left_pole_to_edge <- ((data$left_pole_x - data$left_edge_x)
                                   * spatial_resolution)
    data$dist_right_pole_to_edge <- ((data$right_edge_x - data$right_pole_x)
                                    * spatial_resolution)
    data$cell_length <- (data$right_edge_x - data$left_edge_x) * spatial_resolution
    data$spindle_ratio_asymmetry <- ifelse(right_sp_centre_to_edge > left_sp_centre_to_edge,
                                    (right_sp_centre_to_edge / left_sp_centre_to_edge - 1) * 100,
                                    (left_sp_centre_to_edge / right_sp_centre_to_edge - 1) * 100)
    data$spindle_diff_asymmetry <- (abs(left_sp_centre_to_edge - right_sp_centre_to_edge) /
                                   (data$cell_length - data$spindle_length) * 100)
    return(data)
}
