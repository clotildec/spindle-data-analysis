#!/usr/bin/env Rscript
# This file is a collection of functions useful to analyse spindle data. 

# FUNCTION add_spindle_parameters
# INPUT
# The function assumes the argument 'data' to be a dataframe containing the following field:
# left_pole_x -> the x coordinate of the spindle left pole
# left_pole_y -> the y coordinate of the spindle left pole
# right_pole_x -> the x coordinate of the spindle right pole
# right_pole_y -> the y coordinate of the spindle right pole
# OUTPUT
# spindle_length -> the euclidian distance between the two spindle poles
# spindle_angle -> calculated in degrees as the angle between the horizontal axis and the vector pointing from the left spindle pole to the right pole, thus for positive angles the right pole points upwards and for negative angles it points downwards
# spindle_centre_x/y -> the x/y coordinate of the mean point between the spindle poles

add_spindle_parameters <- function(data){
    spindle_delta_x <- (data$right_pole_x - data$left_pole_x) * spatial_resolution
    spindle_delta_y <- (data$right_pole_y - data$left_pole_y) * spatial_resolution
    data$spindle_length <- sqrt(spindle_delta_x ^ 2 + spindle_delta_y ^ 2)
    data$spindle_angle <- atan2(spindle_delta_y, spindle_delta_x) * 180 / pi
    data$spindle_centre_x <- (data$left_pole_x + data$right_pole_x) / 2
    data$spindle_centre_y <- (data$left_pole_y + data$right_pole_y) / 2
    return(data)
}
