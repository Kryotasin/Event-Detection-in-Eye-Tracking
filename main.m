%% Read teh csv file and get the data from the specified file along with the normalized timestamps and defined parameters

% Define keySet and valueSet to be passed as parameters
keySet = {'sz','sg_power','sg_frameSize','med_order', 'confidence_filter'};
valueSet = [7 7 13 50 0.6];
parameters = containers.Map(keySet,valueSet);

% Parameters for sgolay, median filters and scatter plot size are defined
% in read_file_with_parameters file
% [data, conf_data, time_vector, conf_time_vector] = read_file_with_params(false, "gaze_positions.csv", parameters);

%% Pass the confidence filtered data through the sgolay filter
[sgdata_x, sgdata_y] = sgolayfilter(conf_data.norm_pos_x, conf_data.norm_pos_y, parameters('sg_power'), parameters('sg_frameSize'));

%% Pass the confidence filtered data through the median filter
[med_data_x, med_data_y] =  medianfilter(conf_data.norm_pos_x, conf_data.norm_pos_y, parameters('med_order'));

% %% Plot the gradient of confidence filtered data
figure;
grad_x = gradient(conf_data.norm_pos_x);
grad_y = gradient(conf_data.norm_pos_y);
plot(conf_time_vector, grad_x, conf_time_vector, grad_y);hold on;
legend("X-norm-pos-conf", "Y-norm-pos-conf");
title("Confidence filtered gradient plot");
xlabel('Seconds');
ylabel('Postition');
yline(3 * std(grad_x), 'g', 'DisplayName', 'Mean + 3SD');
yline(-3 * std(grad_x), 'g', 'DisplayName', 'Mean - 3SD');
% %% Get the change points and interval of X data adn plot it with confidence filtered data

[change, interval] = blink(grad_x);

% Plot the individial points
plot(conf_time_vector(change(interval)), grad_x(change(interval)), '*', 'DisplayName', 'Change Points');

for i = 1:length(interval)
xline(conf_time_vector(change(interval(i))), '--m', 'DisplayName', 'Blink');
end

%% Get the change points and interval of Y data and plot it over X data

[change, interval] = blink(grad_y);

% Plot the individial points
plot(conf_time_vector(change(interval)), grad_y(change(interval)), '*', 'DisplayName', 'Change Points');

for i = 1:length(interval)
xline(conf_time_vector(change(interval(i))), '--c', 'DisplayName', 'Blink');
end

hold off;

% Plot Raw data with found blinks
figure;

plot(time_vector, data.norm_pos_x, time_vector, data.norm_pos_y);hold on;
title("Raw data plot");
legend("X-norm-pos", "Y-norm-pos");
xlabel('Seconds');
ylabel('Postition');

[change, interval] = blink(grad_x);

% Plot the individial points
plot(conf_time_vector(change(interval)), grad_x(change(interval)), '*', 'DisplayName', 'Change Points');

for i = 1:length(interval)
xline(conf_time_vector(change(interval(i))), '--m', 'DisplayName', 'Blink');
end

hold off;

%% DBSCAN attempt
figure;
scatter3(conf_time_vector, conf_data.norm_pos_y, conf_data.norm_pos_x, parameters('sz'));
title("3d scatter plot of time-y-x values");
xlabel("Confidence filtered X data");
ylabel("Confidence filtered Y data");
zlabel("Time (s)");
% 
% %%
% scatter3(conf_time_vector(1), conf_data.norm_pos_y(1), conf_data.norm_pos_x(1), parameters('sz') + 25, 'r');
%   % Get the rows to delete which don't pass the confidence test an remove
%     % them
%     toDelete = data.confidence < parameters('confidence_filter');
%     conf_data = data;
%     conf_data(toDelete,:) = [];
    
   %% Clustering X and Y values and finding the centroid using Hierarchical Clustering Algorithm
   
   % For X
   pd_x = pdist(conf_data.norm_pos_x); % Get the distance between all points with each other
   pd_x_s = squareform(pd_x); % Square form of pd_x to visualize
   l_x = linkage(pd_x); % Agglomerative Hierarchical Cluster Tree
   
   % Dissimilarity check
   c_x = cophenet(l_x, pd_x); 
   
   % cophenet again with distance calculated using cityblock filter
   pd_cb_x = pdist(conf_data.norm_pos_x,'cityblock');
   l_cb_x = linkage(pd_cb_x, 'average');
   c_cb_x = cophenet(l_cb_x, pd_cb_x);
   
   % Verify Consistency
   i_x = inconsistent(l_x);
   
   % creating clusters
   clust_x = cluster(l_x, 'cutoff', 1);
   
   centroids_x = zeros();
   
   for i = min(clust_x):max(clust_x)
    
   end
   
cutoff = median([l_x(end-2,3) l_x(end-1,3)]);
figure;
dendrogram(l_x, 'ColorThreshold', cutoff);
title("Colorized Dendrogram of constructed tree");
   