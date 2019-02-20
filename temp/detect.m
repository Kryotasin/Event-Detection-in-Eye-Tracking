%% Call the given funtion and read the csv file in its entirety
%x = read_pupil_lab_data2("gaze_positions.csv");

% Read from 0th to 10th second
%y = read_pupil_lab_data2("gaze_positions.csv", 2, 1462);

% Count time from 0
t = y.timestamp - 151887;

%Define size of scatter plot bubble
sz = 7;

%% Plot the scater plots, both 2D and 3D of the gaze data for first 10 seconds. Raw data used as is.

% 2D scatter plot
%scatter (y.norm_pos_x, y.norm_pos_y, sz, 'filled');

% Create a new figure and plot the 3D gaze Data
figure;


scatter3 (y.gaze_point_3d_x, y.gaze_point_3d_y, y.gaze_point_3d_z, sz, 'filled');

%% Clean the data

% Removing rows with confidence lower than 0.4

% Create a backup copy of the data for first 10 seconds
y1 = y;

% Define the condition to check for deletion
toDelete = y.confidence < 0.4;

% Apply the condition to the table 
y1(toDelete,:) = [];

%% 2D plot of the clean data
% figure;
% scatter (y1.norm_pos_x, y1.norm_pos_y, sz, 'filled');

%% 3D plot of the clean data
% figure;

XYZ = [y1.gaze_point_3d_x, y1.gaze_point_3d_y, y1.gaze_point_3d_z];

%# K-means clustering
%# (K: number of clusters, G: assigned groups, C: cluster centers)
K = 3;
[G,C] = kmeans(XYZ, K, 'distance','sqEuclidean', 'start','sample');
[G1,C] = kmeans(C, K, 'distance','sqEuclidean', 'start','sample');
[G2,C] = kmeans(C, K, 'distance','sqEuclidean', 'start','sample');
[G3,C] = kmeans(C, K, 'distance','sqEuclidean', 'start','sample');

%# show points and clusters (color-coded)
clr = lines(K);
hold on;
scatter3(y1.gaze_point_3d_x, y1.gaze_point_3d_y, y1.gaze_point_3d_z, sz, clr(G,:), 'Marker','.');
scatter3(C(:,1), C(:,2), C(:,3), 100, clr, 'Marker','o', 'LineWidth',3);
scatter3(C(:,1), C(:,2), C(:,3), 100, clr, 'Marker','+', 'LineWidth',1);
hold off;


