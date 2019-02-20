%% Function to detect blinks in certain condition
function [change, interval] = blink(vector)
start = 0; % Store the start of negative points below -3 SD
change = []; % Store the last point below -3 SD
interval = []; % Store the point where slope change occurs 
sd = std(vector); % standard deviation of vector

% Find all points which have value below -3 SD but are just before the points whose values are not
% below -3 SD
for i = 1:length(vector)
     if vector(i) < -(3 * sd)
         if start == 0
            start = i;
         end
            change = [change i];
     end      
end

% Using the change vector above, find the points which are below -3 SD and
% the next point is above +3 SD
for i = 1: length(change)

     if vector(change(i) + 1) > (3 * sd)
       interval = [interval i];
     end
end




 %% Tried but not working using sliding window
% % Window variables
% window_size = 8; % Actual window size becomes window_size + 1
% prev_sd = 0;
% prev_right_edge = 0;
% count = 0;
% buffer = 4;
% temp = [];
% intervals = [];
% 
% steps = (length(vector) - window_size)/sensitivity;
% 
% for i = 1:steps
%     
%     point = vector(ceil((i + window_size)/2));
%     
%     left_grad = mean(gradient(vector(i: floor((i + window_size)/2))));
%     
%     right_grad = mean(gradient(vector(ceil((i + window_size)/2) + 2: i + window_size)));
%     
%     if right_grad > left_grad
%         count = count + 1;
%         temp = [temp i];
%             if count == buffer
%                 intervals = [intervals temp];
%                 temp = [];
%                 break;
%             end
%     else
%         count = 0;
%         temp = [];
%     end
%     
% end


end
