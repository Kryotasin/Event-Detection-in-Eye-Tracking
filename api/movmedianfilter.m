%%Function for moving Median 
function [mov_med_data_x, mov_med_data_y] = movmedianfilter(vector_x, vector_y, windowSize)
    mov_med_data_x = medfilt1(vector_x, windowSize);
    mov_med_data_y = medfilt1(vector_y, windowSize);
end