cross_section <- 98 # µm^2 area of channels
sampling_time <- 3 # minutes

data <- read.csv('test1.csv', header = TRUE)

spindle_delta_x <- data$right_pole_x - data$left_pole_x
spindle_delta_y <- data$right_pole_y - data$left_pole_y

data$cell_length <- data$right_edge_x - data$left_edge_x
data$spindle_length <- sqrt(spindle_delta_x ^ 2 + spindle_delta_y ^ 2)
data$spindle_angle <- atan2(spindle_delta_y, spindle_delta_x) * 180 / pi
# spindle_angle is calculated as the angle between the horizontal axis 
# and the vector from the left spindle pole to the right pole (x and y),
# thus for positive angles the right pole points upward and for negative
# values points downwards

write.csv(data, 'write_test.csv')