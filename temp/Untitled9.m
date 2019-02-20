%% Read teh csv file and get the data from the specified file along with the normalized timestamps and defined parameters
% Parameters for sgolay, median filters and scatter plot size are defined
% in read_file_with_parameters file
[data, conf_data, time_vector, conf_time_vector, parameters] = read_file_with_params(false, "gaze_positions.csv");

%% Pass the raw data through the sgolay filter
%[sgdata_x, sgdata_y] = sgolayfilter(data.norm_pos_x, data.norm_pos_y, parameters('sg_power'), parameters('sg_frameSize'));
[sgdata_x, sgdata_y] = sgolayfilter(conf_data.norm_pos_x, conf_data.norm_pos_y, parameters('sg_power'), parameters('sg_frameSize'));

%% Pass the raw data through the median filter
%[med_data_x, med_data_y] =  medianfilter(data.norm_pos_x, data.norm_pos_y, parameters('med_order'));
[med_data_x, med_data_y] =  medianfilter(conf_data.norm_pos_x, conf_data.norm_pos_y, parameters('med_order'));


%% Start the figure to plot the graphs
handle1 = figure;

% Plot the raw x-y data against time
subplot(3,1,1);
plot(time_vector, data.norm_pos_x, time_vector, data.norm_pos_y, time_vector, data.confidence);
legend("X-norm-pos", "Y-norm-pos", "Confidence");
title("Raw data 7-13 30 plot");
xlabel('Seconds (a)');
ylabel('Postition');

subplot(3,1,2);
plot(conf_time_vector, conf_data.norm_pos_x, conf_time_vector, conf_data.norm_pos_y, conf_time_vector, conf_data.confidence);
legend("X-norm-pos-conf", "Y-norm-pos-conf", "Confidence");
title("Confidence filtered Raw plot");
xlabel('Seconds (b)');
ylabel('Postition');

% Plot the sgfiltered x-y data against time
% subplot(3,1,2);
% plot(conf_time_vector, sgdata_x, conf_time_vector, sgdata_y);
% legend("X-sg", "Y-sg");
% title("SG Filter plot");
% xlabel('Seconds');
% ylabel('Postition');

% Plot the median filtered x-y data against time
subplot(3,1,3);
plot(conf_time_vector, med_data_x, conf_time_vector, med_data_y, conf_time_vector, conf_data.confidence);
legend("X-med", "Y-med", "Confidence");
title("Median filter plot");
xlabel('Seconds (c)');
ylabel('Postition');

% Link all the figures for zooming
all_ha_1 = findobj(handle1, 'type', 'axes', 'tag', '');
linkaxes(all_ha_1, 'x');

%% Plot the graph for combined filters
handle2 = figure;

% Plot the raw x-y data against time
subplot(3,1,1);
% plot(conf_time_vector, conf_data.norm_pos_x, conf_time_vector, conf_data.norm_pos_y, conf_time_vector, conf_data.confidence);
% legend("X-norm-pos", "Y-norm-pos");
% title("3-5 3 Norm plot");
% xlabel('Seconds');
% ylabel('Postition');
subplot(3,1,1);
plot(conf_time_vector, sgdata_x, conf_time_vector, sgdata_y, conf_time_vector, conf_data.confidence);
legend("X-sg", "Y-sg", "Confidence");
title("SG Filter plot");
xlabel('Seconds (d)');
ylabel('Postition');

% Plot the raw data -> sgfiltered -> media filtered data against time
subplot(3,1,2);

% sg_med indicates that the raw data was passed to the SGolay filter and
% then to Median filter. 
[sg_med_data_x, sg_med_data_y] =  medianfilter(sgdata_x, sgdata_y, parameters('med_order'));

plot(conf_time_vector, sg_med_data_x, conf_time_vector, sg_med_data_y, conf_time_vector, conf_data.confidence);
legend("X-sg-med", "Y-sg-med", "Confidence");
title("SG then Median Filter plot");
xlabel('Seconds (e)');
ylabel('Postition');

% Plot the median filtered x-y data against time
subplot(3,1,3);

[med_sg_data_x, med_sg_data_y] = sgolayfilter(med_data_x, med_data_y, parameters('sg_power'), parameters('sg_frameSize'));

plot(conf_time_vector, med_data_x, conf_time_vector, med_data_y, conf_time_vector, conf_data.confidence);
legend("X-med-sg", "Y-med-sg", "Confidence");
title("Median then SG filter plot");
xlabel('Seconds (f)');
ylabel('Postition');

% Link all the figures for zooming
all_ha_2 = findobj(handle2, 'type', 'axes', 'tag', '');
linkaxes(all_ha_2, 'x');
