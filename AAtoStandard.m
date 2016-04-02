function [ stand ] = AAtoStandard( AAdata )
%A2TOSTANDARD Converts Ann Arbor-style data to standard
%standard data before scoring has form
%1serialdate, 2Tmax(F), 3Tmin, 4precip(in), 5snowF(in), 6snowD(in),

% Preallocate
stand = zeros(length(AAdata), 16);


% Find dates from 1:3 in yyyy,mm,dd format
disp('Converting dates to serial format (takes a while)...');
select = AAdata(:,1) < 3000; %selects data NOT in serial number form

% Converts dates to datestr -> datenum format
dates = strcat( num2str(AAdata(select,2)),'/',num2str(AAdata(select,3)),'/',num2str(AAdata(select,1)) );
stand(select,1) = datenum(dates,'mm/dd/yyyy');

% Convert rest of dates
% Converts from excel serial dates to matlab serial dates
stand(~select,1) = AAdata(~select,1) + 693960;
% May 31, 2015 missing from file.. ???

disp('Assigning weather data...');
stand(:, 2) = AAdata(:, 4);
stand(:, 3) = AAdata(:, 5);
% 4th column (precip) unused & not given, left as zeros
stand(:, 5) = AAdata(:, 6);
stand(:, 6) = AAdata(:, 7);


end