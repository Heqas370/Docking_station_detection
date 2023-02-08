clear all;
%%%%%%%%%%%%%%%%%%%%%%%% LOAD ROSBAG AND SETUP PARAMETERS %%%%%%%%%%%%%%%%
bag = rosbag("docking_station_10sample\station_3\0.5m_right.bag");
bSel = select(bag,'Topic','/scan');
msgStructs = readMessages(bSel,'DataFormat','struct');
tabela=[-3.1241:0.0175:3.1618]';
timeStamps = bSel.MessageList.Time;
station = load("docking_station_noise\stattion_3\0.5m_left_noise_3.mat");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SHOW LIDAR SCAN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scan1 = lidarScan(msgStructs{1}.Ranges, tabela);
plot(scan1);
grid off
axis off
title('');
%%%%%%%%%%%%%%%%%%%%% REMOVE SURROUNDINGS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:10
    for i=1:171
    msgStructs{j}.Ranges(i) = 0;
    end
end

for j=1:10
    for i=184:360
    msgStructs{j}.Ranges(i) = 0;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%% SHOW PATTERNS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:3
scan(i) = lidarScan(msgStructs{i, 1}.Ranges, tabela);
figure(i)
plot(scan(i))
end
%%%%%%%%%%%%%%%%%%%%%%%%% SAVE PATTERN AS ROSBAG %%%%%%%%%%%%%%%%%%%%%%%%%%
%  bagwrite = rosbagwriter('0.5m_right_crop.bag');
%  write(bagwrite,'/scan',timeStamps,station.station.msgStructs{1,1});