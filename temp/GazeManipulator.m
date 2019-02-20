classdef GazeManipulator < handle

    properties
        %Declare properties of the class
        data, time_vector;
        % Define size of scatter plot bubble
        sz = 7;

        % Define Savitsky-Golay filter parameters
        sg_power = 5;
        sg_frameSize = 9;
        
        % Define Median filter parameters
        med_order = 5;
    end
    
    methods
        %%Read the file from specified start and end rows. 
        % Call the given funtion and read the csv file in its entirety
        function [data, time_vector]  = getData(full)
            if full 
                data = read_pupil_lab_data2("gaze_positions.csv");

            else
            % Read from 0th to 10th second
            data = read_pupil_lab_data2("gaze_positions.csv", 2, 1462);
            end

            % Convert time stamp to count from 0 by subtracting all timestamp values
            % from the first timestamp value
            time_vector = data.timestamp - data.timestamp(1);
        end
    end
    
        
end
