% hold on;
% plot(t1, atand(y1.gaze_point_3d_x/y1.gaze_point_3d_z));
% plot(t1, atand(y1.gaze_point_3d_y/y1.gaze_point_3d_z));
% hold off;

% u = gradient(y1.norm_pos_x, 0.1);
%   v = gradient(y1.norm_pos_y, 0.1);
%   figure;
%   scatter(u, v);

%sqrt of sum of differences

% D = [];
% 
% for i=3:632
%     temp_x = y1.norm_pos_x(i) - y1.norm_pos_x(i-1);
%     temp_y = y1.norm_pos_y(i) - y1.norm_pos_y(i-1);
%     
%     temp_x = temp_x.^2;
%     temp_y = temp_y.^2;
%     
%     value = sqrt(temp_x + temp_y);
%     
%     D = [D ; value];
% end
% 
% plot(t1(1:630), D);

y = read_pupil_lab_data2("gaze_positions.csv", 2, 3446);

t = y.timestamp - y.timestamp(1);
  figure;
  subplot(3,1,1);
  plot(t, y.norm_pos_x, t, y.norm_pos_y);
  legend("X-norm-pos", "Y-norm-pos");
  title("Norm plot");
  
xlabel('Seconds');
ylabel('Postition');
  
  %%
  [med_data_x, med_data_y] = medianfilter(y.norm_pos_x, y.norm_pos_y, 30);
  subplot(3,1,2);
  plot(t, med_data_x, t, med_data_y);
  legend("X-med-norm-pos", "Y-med-norm-pos-conf");
  title("Median filter on raw data");
xlabel('Seconds');
ylabel('Postition');

%%
[sgdata_x, sgdata_y] = sgolayfilter(y.norm_pos_x, y.norm_pos_y, 7, 13);
  subplot(3,1,3);
  plot(t, sgdata_x, t, sgdata_y);
  legend("X-sg-norm-pos", "Y-sg-norm-pos");
  title("SGolay filter on raw data plot");
  
xlabel('Seconds');
ylabel('Postition');

