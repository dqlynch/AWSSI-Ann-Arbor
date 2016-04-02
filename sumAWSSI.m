function [ data ] = sumAWSSI( data, startindex, endindex )
%SUMAWSSI accumulates AWSSI values
%    data is:   1serialdate, 2Tmax, 3Tmin, 4precip, 5snowF, 6snowD,
%				7MXTscr, 8MNTscr, 9TotTScr, 10SnFscr, 11SnDscr, 12TotSnScr
%				13AWSSI, 14AccT, 15AccS, 16AccAWSSI


for i = startindex:endindex
	try
		data(i,14) = data(i-1,14) + data(i,9);
		data(i,15) = data(i-1,15) + data(i,12);
		data(i,16) = data(i-1,16) + data(i,13); %awssi
	catch %if i = 1, set as daily score
		data(i,14) = data(i,9);
		data(i,15) = data(i,12);
		data(i,16) = data(i,13);
end

end

