# Spindle Positioning Analysis for cells in microfabricated channels

This script is used to analyse spindle positioning in cells confined in channels. It takes a *.csv* file with cell edge and spindle pole coordinates and calculates spindle length, angle and asymmetry with respect to the cell.

## analysis\_asymmetric\_division\_in\_channels.R

### INPUT

The script assumes that the cell long axis is horizontal with respect to the channel, and assumes the header of the .csv file to contain the following fields:

cell\_number, ID, frame, left\_edge\_x, left\_edge\_y, left\_pole\_x, left\_pole\_y, right\_pole\_x, right\_pole\_y, right\_edge\_x, right\_edge\_y
Here is a description of the different fields:
* cell\_number is an integer used to distinguish different cells in the same .csv file
* ID is a unique string identifying the cell
* frame is the frame number for time-lapse movies
* left\_edge\_x is the x coordinate of the cell left edge
* left\_edge\_y is the y coordinate of the cell left edge
* left\_pole\_x is the x coordinate of the spindle left pole
* left\_pole\_y is the y coordinate of the spindle left pole
* right\_pole\_x is the x coordinate of the spindle right pole
* right\_pole\_y is the y coordinate of the spindle right pole
* right\_edge\_x is the x coordinate of the cell right edge
* right\_edge\_y is the y coordinate of the cell right edge

### PROCESSING

The script processes the input in order to obtain the following:
* spindle\_length -> the euclidian distance between the two spindle poles
* spindle\_angle -> calculated in degrees as the angle between the horizontal axis and the vector pointing from the left spindle pole to the right pole, thus for positive angles the right pole points upwards and for negative angles it points downwards
* cell length -> the distance on the x-axis between the two cell extremities
* dist\_left\_pole\_to\_edge -> the distance on the x-axis between the spindle left pole and the left cell edge
* dist\_right\_pole\_to\_edge -> the distance on the x-axis between the spindle right pole and the right cell edge
* spindle\_ratio\_asymmetry -> calculated as the ratio between two distances on the x-axis: the longest distance between the spindle center and the cell edge, divided by the shortest distance between the spindle center and the cell edge. Then the asymmetry is normalised and given in percentage (no upper bound)
* spindle\_diff\_asymmetry -> calculated as the difference on the x-axis between the longest distance from the spindle center to the cell edge and the shortest distance between the spindle center and the cell edge. Then the asymmetry is normalised by its maximum value and given in percentage (between 0 and 100%)
