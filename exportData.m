function exportData( data, location )
%EXPORTDATA converts to table and excel dates then exports to folder

disp('Creating/finding directory to export data');
%create folder for data
foldername = strcat(location, ' data');
if ~exist(foldername,'dir')
	mkdir(foldername);
end

%change dates to datestr
datestable = table(datestr(data(:,1)),'VariableNames', {'Dates'});


%create table for data 
datatable = array2table(data(:,2:end),'VariableNames', {'MaxTemp' 'MinTemp' 'Precipitation' 'Snowfall' 'Snowdepth' ...
	'MaxTscore' 'MinTscore' 'TotalTscore' 'SnowFscore' 'SnowDscore' 'TotalSscore'...
	'AWSSIscore' 'AccumTscore' 'AccumSscore' 'AccumAWSSI'});

%concat dates & data

datatable = horzcat(datestable,datatable);


%write to file
disp('Writing data spreadsheet to file (takes a while)...');
filename = strcat('/',foldername,'/AWSSI ',location,'.csv'); %.xlsx or .csv
writetable(datatable,[pwd filename]);



end

