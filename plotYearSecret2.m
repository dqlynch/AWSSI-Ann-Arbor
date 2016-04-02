function plotYearSecret2(data, plotstart, plotend, fig, location, maxlog, minlog, figname)
%PLOTYEARSECRET2 Summary of this function goes here
%    data is:   1serialdate, 2Tmax, 3Tmin, 4precip, 5snowF, 6snowD,
%				7MXTscr, 8MNTscr, 9TotTScr, 10SnFscr, 11SnDscr, 12TotSnScr
%				13AWSSI, 14AccT, 15AccS, 16AccAWSSI

%plot data


set(fig, 'Position', [100, 100, 1049, 895]);

t = data(plotstart:plotend,1); %x axis
s = data(plotstart:plotend,16);
current = area(t,s,'FaceColor','b','EdgeColor','none',...
	'FaceAlpha',.4);

hold on;

year1 = datestr(data(plotstart,1));
year1 = (year1(8:11));
year2 = num2str( str2num(year1)+1 );

%plot 3 highest and lowest years

try
	
	%max years
	s = data(maxlog(1,1):maxlog(1,2),16);
	plot(t,s,'Color', [0,0,1] ,'LineWidth', 2);
	
	s = data(maxlog(2,1):maxlog(2,2),16);
	plot(t,s,'Color', [0,0,.5] ,'LineWidth', 2);	
	
	s = data(maxlog(3,1):maxlog(3,2),16);
	plot(t,s,'Color', [0,.5,.6] ,'LineWidth', 2);	
	
	%min years
	s = data(minlog(3,1):minlog(3,2),16);
	plot(t,s,'Color', [1,0,0] ,'LineWidth', 2);
	
	s = data(minlog(2,1):minlog(2,2),16);
	plot(t,s,'Color', [.6,.1,.1] ,'LineWidth', 2);
	
	s = data(minlog(1,1):minlog(1,2),16);
	plot(t,s,'Color', [1,.25,.7] ,'LineWidth', 2);

catch
end

legendyear_current = strcat(year1, '-', year2, ' (Current)');
legendyear1a = num2str(year(data(maxlog(1,1),1)));
legendyear1b = num2str(year(data(maxlog(1,1),1)) + 1);
legendyear1 = strcat(legendyear1a, '-', legendyear1b);

legendyear2a = num2str(year(data(maxlog(2,1),1)));
legendyear2b = num2str(year(data(maxlog(2,1),1)) + 1);
legendyear2 = strcat(legendyear2a, '-', legendyear2b);

legendyear3a = num2str(year(data(maxlog(3,1),1)));
legendyear3b = num2str(year(data(maxlog(3,1),1)) + 1);
legendyear3 = strcat(legendyear3a, '-', legendyear3b);

legendyear4a = num2str(year(data(minlog(3,1),1)));
legendyear4b = num2str(year(data(minlog(3,1),1)) + 1);
legendyear4 = strcat(legendyear4a, '-', legendyear4b);

legendyear5a = num2str(year(data(minlog(2,1),1)));
legendyear5b = num2str(year(data(minlog(2,1),1)) + 1);
legendyear5 = strcat(legendyear5a, '-', legendyear5b);

legendyear6a = num2str(year(data(minlog(1,1),1)));
legendyear6b = num2str(year(data(minlog(1,1),1)) + 1);
legendyear6 = strcat(legendyear6a, '-', legendyear6b);



datetick('x','mmmm');
legend(legendyear_current, legendyear1, legendyear2, legendyear3, ...
	legendyear4, legendyear5, legendyear6,'Location','northwest');
xlabel('Date'), ylabel('AWSSI Score');

uistack(current, 'bottom'); %puts current plot on bottom





titlename = strcat(year1,'-', year2);
title({titlename;location});

% ax.YTick = 0:200:2000;
% p1.LineWidth = 2;
% p2.BarWidth = 0;


filename = strcat(year1, year2(3:4), '.png');
filename = strcat('/',figname,'/',filename);
saveas(fig,[pwd filename]);

hold off;

end

