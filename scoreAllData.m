function [ data ] = scoreAllData( data )
%SCOREALLDATA Assigns scores for weather (but not summed scores)
 %    standard: 1serialdate, 2Tmax, 3Tmin, 4precip, 5snowF, 6snowD,
 %				7MXTscr, 8MNTscr, 9TotTScr, 10SnFscr, 11SnDscr, 12TotSnScr
 %				13AWSSI, 14AccT, 15AccS, 16AccAWSSI

 %%%%%%%%%%%TEMP SCORES%%%%%%%%%%
%MAXTEMP scores (2 --> 7)
data(:,7) = (data(:,2) <= 32);
data(:,7) = data(:,7) + (data(:,2) <= 24);
data(:,7) = data(:,7) + (data(:,2) <= 19);
data(:,7) = data(:,7) + (data(:,2) <= 14);
data(:,7) = data(:,7) + (data(:,2) <= 9);
data(:,7) = data(:,7) + (data(:,2) <= 4);
data(:,7) = data(:,7) + (data(:,2) <= -1);
data(:,7) = data(:,7) + (data(:,2) <= -6);
data(:,7) = data(:,7) + (data(:,2) <= -11);
data(:,7) = data(:,7) + (data(:,2) <= -16);
data(:,7) = data(:,7) + (data(:,2) <= -20)*5; %sets to 15

%MINTEMP scores (3 --> 8)
data(:,8) = (data(:,3) <= 32);
data(:,8) = data(:,8) + (data(:,3) <= 24);
data(:,8) = data(:,8) + (data(:,3) <= 19);
data(:,8) = data(:,8) + (data(:,3) <= 14);
data(:,8) = data(:,8) + (data(:,3) <= 9);
data(:,8) = data(:,8) + (data(:,3) <= 4);
data(:,8) = data(:,8) + (data(:,3) <= -1);
data(:,8) = data(:,8) + (data(:,3) <= -6);
data(:,8) = data(:,8) + (data(:,3) <= -11);
data(:,8) = data(:,8) + (data(:,3) <= -16);
data(:,8) = data(:,8) + (data(:,3) <= -20);
data(:,8) = data(:,8) + (data(:,3) <= -26)*4;
data(:,8) = data(:,8) + (data(:,3) <= -35)*5;

%totaltemp scores (7+8 --> 9)
data(:,9) = data(:,7) + data(:,8);

%%%%%%SNOW SCORES%%%%%%%
%Snowfall scores (5 --> 10)
data(:,10) = (data(:,5) >= .1);
data(:,10) = data(:,10) + (data(:,5) >= 1);
data(:,10) = data(:,10) + (data(:,5) >= 2);
data(:,10) = data(:,10) + (data(:,5) >= 3);
data(:,10) = data(:,10) + (data(:,5) >= 4)*2;
data(:,10) = data(:,10) + (data(:,5) >= 5);
data(:,10) = data(:,10) + (data(:,5) >= 6)*2;
data(:,10) = data(:,10) + (data(:,5) >= 7);
data(:,10) = data(:,10) + (data(:,5) >= 8)*2;
data(:,10) = data(:,10) + (data(:,5) >= 9);
data(:,10) = data(:,10) + (data(:,5) >= 10);
data(:,10) = data(:,10) + (data(:,5) >= 12)*4;
data(:,10) = data(:,10) + (data(:,5) >= 15)*4;
data(:,10) = data(:,10) + (data(:,5) >= 18)*4;
data(:,10) = data(:,10) + (data(:,5) >= 24)*10;
data(:,10) = data(:,10) + (data(:,5) >= 30)*9;

%Snowdepth scores (6 --> 11)
data(:,11) = (data(:,6) >= 1);
data(:,11) = data(:,11) + (data(:,6) >= 2);
data(:,11) = data(:,11) + (data(:,6) >= 3);
data(:,11) = data(:,11) + (data(:,6) >= 4);
data(:,11) = data(:,11) + (data(:,6) >= 6);
data(:,11) = data(:,11) + (data(:,6) >= 9);
data(:,11) = data(:,11) + (data(:,6) >= 12);
data(:,11) = data(:,11) + (data(:,6) >= 15);
data(:,11) = data(:,11) + (data(:,6) >= 18);
data(:,11) = data(:,11) + (data(:,6) >= 24);
data(:,11) = data(:,11) + (data(:,6) >= 36)*5;

%total snow scores (10+11 --> 12)
data(:,12) = data(:,10) + data(:,11);

%%%%%%%TOTAL AWSSI SCORES%%%%%%%%%%%%
data(:,13) = data(:,9) + data(:,12);

end

