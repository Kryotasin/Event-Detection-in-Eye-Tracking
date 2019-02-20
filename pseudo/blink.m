function [change, interval] = blink(vector)
    % Declare the array to store last points below -3 * SD
        change = [];
    % Declare the array to store points of change of slope direction
        interval = [];
    % Find the Standard deviation of the vector passed
        sd = std(vector);
        
     % first find the negative point below -3 * SD
     for all elements in vector
         if (point value is less than -3 * SD)
            insert this value into change
         end
     end
     
     for all elements in change
        % Check if the point after the points stored in change are above 3
        % * SD
         if (the next point value is > +3 * SD)
            insert this value into interval
        end
     end
     return interval and change to be plotted
end
