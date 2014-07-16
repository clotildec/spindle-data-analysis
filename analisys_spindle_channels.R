cross_section <- 98 # µm^2 area of channels
temporal_resolution <- 3 # minutes
spatial_resolution <- 0.645 # µm/pixel

data <- read.csv('/Users/andimi/Desktop/FromClotilde/140619-HeLa-HCTG-Channels98-analyse140715-15cells.csv', header = TRUE)

spindle_delta_x <- (data$right_pole_x - data$left_pole_x) * spatial_resolution
spindle_delta_y <- (data$right_pole_y - data$left_pole_y) * spatial_resolution
spindle_centre_x <- (data$left_pole_x + data$right_pole_x) / 2
spindle_centre_y <- (data$left_pole_y + data$right_pole_y) / 2
right_sp_centre_to_edge <- ((data$right_edge_x - spindle_centre_x) 
                       * spatial_resolution)
left_sp_centre_to_edge <- ((spindle_centre_x - data$left_edge_x)
                      * spatial_resolution)

data$spindle_length <- sqrt(spindle_delta_x ^ 2 + spindle_delta_y ^ 2)
data$spindle_angle <- atan2(spindle_delta_y, spindle_delta_x) * 180 / pi
# spindle_angle is calculated in degrees as the angle between the horizontal
# axis and the vector from the left spindle pole to the right pole (x and y),
# thus for positive angles the right pole points upwards and for negative
# angles it points downwards

data$dist_left_pole_to_edge <- ((data$left_pole_x - data$left_edge_x)
                                * spatial_resolution)
data$dist_right_pole_to_edge <- ((data$right_edge_x - data$right_pole_x)
                                * spatial_resolution)
# the distance is calculated as the difference of the x coordinates
# from the spindle poles (left or right) to the nearest edge

data$cell_length <- (data$right_edge_x - data$left_edge_x) * spatial_resolution
data$spindle_ratio_asymmetry <- ifelse(right_sp_centre_to_edge > left_sp_centre_to_edge,
                                       right_sp_centre_to_edge / left_sp_centre_to_edge,
                                       left_sp_centre_to_edge / right_sp_centre_to_edge)
# the spindle asymmetry is calculated as the ratio between two distances:
# the longest distance between the spindle center and the cell edge, over 
# the shortest distance between the spindle center and the cell edge. 
# These distances are only considered on the horizontal axis
  
data$spindle_diff_asymmetry <- left_sp_centre_to_edge - right_sp_centre_to_edge

write.csv(data, 'write_test.csv')