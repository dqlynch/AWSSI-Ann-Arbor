
%%%%%%%%%%%%%%%%%
% Driver script %
%%%%%%%%%%%%%%%%%

clear;

% Set input file here (xlsx of data)
input_filename = 'annarborawssi_thruoct2015.xlsx';

% Set location here (for plot titles, directory names, fig names)
location = 'Ann Arbor, MI';

disp('Creating/finding directory to hold plots...');

%create folder for figures
figname = strcat(location,' figures');
if ~exist(figname,'dir')
	mkdir(figname);
end

%read data from excel file
disp('Reading data from file (takes a while)...'); 
xlsread = xlsread(input_filename);

% Convert to standard matrix
disp('Converting data to standard form...');
data = AAtoStandard(xlsread); %no longer uses x2mdate (weird conflict)

disp('Assigning scores...');
data = scoreAllData(data);

disp('Creating date logs for winter start/end conditions...');

% For use in selectNextYear
[startlog, endlog, plotlog] = createDateLogs(data);

endindex = 1;
disp('Separating years and summing data...');
done = 0;
while (~done)
	%get indices
	[startindex, endindex, plotstart, plotend, done] = ...
		selectNextYear(data, endindex, startlog, endlog, plotlog);
	%accumulate data
	data = sumAWSSI(data, startindex, endindex);
end

% Determine 3 highest and 3 lowest years for plotting
disp('Finding extreme years...');
[maxlog, minlog, data] = determineExtremeYears(data, startlog, endlog, plotlog);


% Export data as excel sheet
exportData(data, location);


disp('Plotting figures to file (takes a few minutes)...');

fig = figure;
set(fig, 'Visible', 'off');

done = 0;
endindex = 1; % Reset initial value 
while ~done
	% Get indices
	[startindex, endindex, plotstart, plotend, done] = selectNextYear(data, endindex, startlog, endlog, plotlog);
	
	% Plot data
	if (plotend - plotstart) == 271
		plotYearSecret2(data, plotstart, plotend, fig, location, maxlog, minlog, figname);
	end
end


