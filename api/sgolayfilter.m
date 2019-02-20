%%Function for Savitsky-Golay filter
function [sgdata_x, sgdata_y] = sgolayfilter(vector_x, vector_y, power, frameSize)
    sgdata_x = sgolayfilt(vector_x, power, frameSize);
    sgdata_y = sgolayfilt(vector_y, power, frameSize);
end