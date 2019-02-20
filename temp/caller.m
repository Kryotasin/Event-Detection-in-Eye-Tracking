%x = read_pupil_lab_data2("gaze_positions.csv");

%y = read_pupil_lab_data2("gaze_positions.csv", 1462, 2742);

y = read_pupil_lab_data2("gaze_positions.csv", 2, 3446);

%disp(x.norm_pos_x);
 %%
t = y.timestamp - y.timestamp(1);
  figure;
  subplot(4,1,1);
  plot(t, y.norm_pos_x, t, y.norm_pos_y);
  legend("X-norm-pos", "Y-norm-pos");
  title("Norm plot");
  
xlabel('Seconds');
ylabel('Postition');
  
  %%
    % Create a backup copy of the data for first 10 seconds
    y1 = y;

    % Define the condition to check for deletion
    toDelete = y1.confidence < 0.4;

    % Apply the condition to the table 
    y1(toDelete,:) = [];

  t1 = y1.timestamp - y1.timestamp(1);
  subplot(4,1,2);
  plot(t1, y1.norm_pos_x, t1, y1.norm_pos_y);
  legend("X-norm-pos", "Y-norm-pos");
  title("0.4 confidence");
xlabel('Seconds');
ylabel('Postition');
  %%
  % Define the condition to check for deletion
toDelete = y1.confidence < 0.6;

% Apply the condition to the table 
y1(toDelete,:) = [];

t1 = y1.timestamp - y1.timestamp(1); 

  subplot(4,1,3);
  plot(t1, y1.norm_pos_x, t1, y1.norm_pos_y);
  legend("X-norm-pos", "Y-norm-pos");
  title("0.6 confidence plot");
xlabel('Seconds');
ylabel('Postition');
  %%
    % Define the condition to check for deletion
toDelete = y1.confidence < 0.9;

% Apply the condition to the table 
y1(toDelete,:) = [];

t1 = y1.timestamp - y1.timestamp(1); 

  subplot(4,1,4);
  plot(t1, y1.norm_pos_x, t1, y1.norm_pos_y);
  legend("X-norm-pos", "Y-norm-pos");
  title("0.9 confidence plot");
xlabel('Seconds');
ylabel('Postition');

  %%
%   u = gradient(y.norm_pos_x);
%   v = gradient(y.norm_pos_y);
%   figure, hold on;
%   scatter(u, v);
%   title("gradient scatter on norm");
  
%   u = medfilt1(gradient(y.norm_pos_x, 0.1));
%   v = medfilt1(gradient(y.norm_pos_y, 0.1));
%   figure;
%   plot(t, u, t, v);
%   legend("X-norm-pos-med", "Y-norm-pos-med");
  
  %figure;
  %plot(t, medfilt1(y.norm_pos_x), t, medfilt1(y.norm_pos_y));
  %legend("X-norm-pos-med", "Y-norm-pos-med");
  
 % figure;
 %sz = 7;
 %scatter(x.norm_pos_x, x.norm_pos_y, sz,'filled');
 %scatter(x.index, x.norm_pos_x, sz,'filled');
 %hold on;
 %scatter(x.index, x.norm_pos_y, sz,'filled');
 %hold off;
 
 %figure;
 %binscatter(x.norm_pos_x, x.norm_pos_y);
 %binscatter(x.timestamp, x.norm_pos_y);

