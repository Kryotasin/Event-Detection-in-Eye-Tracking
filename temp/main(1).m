%% Read teh csv file and get the data from the specified file along with the normalized timestamps and defined parameters

% Define keySet and valueSet to be passed
keySet = {'sz','sg_power','sg_frameSize','med_order', 'confidence_filter'};
valueSet = [7 7 13 50 0.6];
parameters = containers.Map(keySet,valueSet);

% Parameters for sgolay, median filters and scatter plot size are defined
% in read_file_with_parameters file
[data, conf_data, time_vector, conf_time_vector] = read_file_with_params(false, "gaze_positions.csv", parameters);

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
%title(strcat('Raw data plot', parameters('sg_power'), '-', parameters('sg_frameSize'), parameters('med_order')));
title("Raw data 7-13 50 plot");
xlabel('Seconds (a)');
ylabel('Postition');

subplot(3,1,2);
plot(conf_time_vector, conf_data.norm_pos_x, conf_time_vector, conf_data.norm_pos_y, conf_time_vector, conf_data.confidence);
legend("X-norm-pos-conf", "Y-norm-pos-conf", "Confidence");
title("Confidence filtered plot");
xlabel('Seconds (b)');
ylabel('Postition');

subplot(3,1,3);
plot(conf_time_vector, sgdata_x, conf_time_vector, sgdata_y, conf_time_vector, conf_data.confidence);
legend("X-norm-pos-conf", "Y-norm-pos-conf", "Confidence");
title("Sgolay filtered  plot");
xlabel('Seconds (b)');
ylabel('Postition');

% Link all the figures for zooming
all_ha_1 = findobj(handle1, 'type', 'axes', 'tag', '');
linkaxes(all_ha_1, 'x');

%%
handle2 = figure;

subplot(4,1,1);
plot(conf_time_vector, gradient(sgdata_x), conf_time_vector, gradient(sgdata_y));
legend("X-norm-pos-conf", "Y-norm-pos-conf", "Confidence");
title("SGolay filtered gradient plot");
xlabel('Seconds (b)');
ylabel('Postition');

subplot(4,1,2);
plot(conf_time_vector, gradient(med_data_x), conf_time_vector, gradient(med_data_y));
legend("X-norm-pos-conf", "Y-norm-pos-conf", "Confidence");
title("Median filtered gradient plot");
xlabel('Seconds (b)');
ylabel('Postition');

subplot(4,1,3);
plot(conf_time_vector, (gradient(sgdata_x) - gradient(med_data_x)), conf_time_vector, (gradient(sgdata_y) - gradient(med_data_y)));
legend("X-norm-pos-conf", "Y-norm-pos-conf", "Confidence");
title("Plot of difference of Median and Sgolay gradient.");
xlabel('Seconds (b)');
ylabel('Postition');


subplot(4,1,4);
plot(conf_time_vector, gradient(gradient(sgdata_x) - gradient(med_data_x)), conf_time_vector, gradient(gradient(sgdata_y) - gradient(med_data_y)));
legend("X-norm-pos-conf", "Y-norm-pos-conf", "Confidence");
title("Gradient of difference of gradients plot");
xlabel('Seconds (b)');
ylabel('Postition');


% Link all the figures for zooming
all_ha_2 = findobj(handle2, 'type', 'axes', 'tag', '');
linkaxes(all_ha_2, 'x');

%%