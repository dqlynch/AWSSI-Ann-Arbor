function [ startlog, endlog, plotlog ] = createDateLogs( data )
% Creates datelogs for later use in selectNextYear
%	marks important dates for year cutoffs

% Code was not working due to matlab error in datestr function,
% this is workaround
%dates = datestr(data(:,1));


startlog = zeros(length(data),6); % Indices 4-5 no longer used
								  % startlog(6) is jul01 check

endlog = zeros(length(data),4);
plotlog = zeros(length(data),2);


for year_check = 1850:2050
	
	% Date check for start condition
	date_check = datenum(datetime(year_check,12,01)); %checks for dec01
	startlog(:,3) = startlog(:,3) + (data(:,1) == date_check);
	
	% date check for winter end check limit (see selectnextyear)
	date_check = datenum(datetime(year_check,07,01)); %checks for jul01
	startlog(:,6) = startlog(:,6) + (data(:,1) == date_check);
	
	% date check for end condition
	date_check = datenum(datetime(year_check,03,1)) - 1; %checks for day before mar01
	endlog(:,4) = endlog(:,4) + (data(:,1) == date_check);
	
	% date check for plot start
	date_check = datenum(datetime(year_check,09,01)); %checks for sep01
	plotlog(:,1) = plotlog(:,1) + (data(:,1) == date_check);
	
	% date check for plot end !!changed from may31->30 because of 
	% missing day in data
	date_check = datenum(datetime(year_check,05,30)); %checks for may30
	plotlog(:,2) = plotlog(:,2) + (data(:,1) == date_check);
	
end

%code was not working on frank's cpu due to matlab error in datestr()

% 
% for i = 1:length(data) %date check for start condition
% 	if dates(i,1:6) == ('01-Dec') %#ok<*BDSCA>, marks each dec 1
% 		startlog(i,3) = 1;
% 	end
% 	
% 	%checks for end condition
% 	if dates(i,1:6) == ('28-Feb') | dates(i,1:6) == ('29-Feb') %#ok<OR2>
% 		endlog(i,4) = 1;
% 	end
% 	
% 	%check for plot limit 1
% 	if dates(i,1:6) == ('01-Sep')
% 		plotlog(i,1) = 1;
% 	end
% 	
% 	%check for plot limit 2
% 	if dates(i,1:6) == ('31-May')
% 		plotlog(i,2) = 1;
% 	end
% end
% 





end