%%Read the file from specified start and end rows. 
% Call the given funtion and read the csv file in its entirety
function [data, conf_data, time_vector, conf_time_vector]  = read_file_with_params(full, fileName, parameters)    
    if full 
        data = read_pupil_lab_data2(fileName);

    else
    % Read from 0th to 25th second - 3446 :- 42 -6003
    data = read_pupil_lab_data2("gaze_positions.csv", 2, 3446);
    end
     
    % Get the rows to delete which don't pass the confidence test an remove
    % them
    toDelete = data.confidence < parameters('confidence_filter');
    conf_data = data;
    conf_data(toDelete,:) = [];
    
    % Convert time stamp to count from 0 by subtracting all timestamp values
    % from the first timestamp value
    time_vector = data.timestamp - data.timestamp(1);
    conf_time_vector = conf_data.timestamp - conf_data.timestamp(1);
end
