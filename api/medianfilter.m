%%Function for Median filter
function [med_data_x, med_data_y] = medianfilter(vector_x, vector_y, order)
    med_data_x = medfilt1(vector_x, order);
    med_data_y = medfilt1(vector_y, order);
end