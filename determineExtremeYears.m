function [maxlog, minlog, data] = determineExtremeYears( data, startlog, endlog, plotlog )
%DETERMINEEXTREMEYEARS determines the 3 highest and lowest years
%ALSO EXTENDS AWSSI SUMS TO END OF PLOT


%logs all final awssi values
extrlog = zeros(100,2);
j = 1;

for i = 1:size(data)-1;
	if (data(i,16) ~= 0) && (data(i+1,16) == 0)
		extrlog(j,1) = data(i,1);  %index of final awssi value
		extrlog(j,2) = data(i,16); %2 column is final awssi value
		j = j+1;
	end
end

%finds 3 max and 3 min values
maxlog = zeros(3,2);
minlog = ones(3,2) * 999999;

for i = 1:size(extrlog)
	
	%check max of extrlog
	if extrlog(i,2) >= maxlog(3,2)
		%swap to 3
		maxlog(3,2) = extrlog(i,2);
		maxlog(3,1) = extrlog(i,1);
		
		if extrlog(i,2) >= maxlog(2,2)
			%swap 3 to 2
			maxlog(3,2) = maxlog(2,2);
			maxlog(3,1) = maxlog(2,1);
			
			maxlog(2,2) = extrlog(i,2);
			maxlog(2,1) = extrlog(i,1);
			
			if extrlog(i,2) >= maxlog(1,2)
				%swap 2 to 1
				maxlog(2,2) = maxlog(1,2);
				maxlog(2,1) = maxlog(1,1);
				
				maxlog(1,2) = extrlog(i,2);
				maxlog(1,1) = extrlog(i,1);
			end
		end
	end
	
	%check same for minlog
	if extrlog(i,2) <= minlog(3,2)
		%swap to 3
		minlog(3,2) = extrlog(i,2);
		minlog(3,1) = extrlog(i,1);
		
		if extrlog(i,2) <= minlog(2,2)
			%swap 3 and 2
			minlog(3,2) = minlog(2,2);
			minlog(3,1) = minlog(2,1);
			
			minlog(2,2) = extrlog(i,2);
			minlog(2,1) = extrlog(i,1);
			
			if extrlog(i,2) <= minlog(1,2)
				%swap 2 and 1
				minlog(2,2) = minlog(1,2);
				minlog(2,1) = minlog(1,1);
				
				minlog(1,2) = extrlog(i,2);
				minlog(1,1) = extrlog(i,1);
			end
		end
	end
	
end

maxlog(:,2) = maxlog(:,1);
maxlog(:,1) = 0;

minlog(:,2) = minlog(:,1);
minlog(:,1) = 0;

%iterate through to find matching start indices
done = 0;
endindex = 1; %start value
while (~done)
	[~, endindex, plotstart, plotend, done] = selectNextYear(data, endindex, startlog, endlog, plotlog);
	for i = 1:3
		if data(endindex,1) == maxlog(i,2);
			maxlog(i,1) = plotstart;
			maxlog(i,2) = plotend;
			if (plotend - plotstart) == 273 %adjusts vectors to be same length on leap years
				plotend = plotend - 1;
			end
		end
		if data(endindex,1) == minlog(i,2);
			minlog(i,1) = plotstart;
			minlog(i,2) = plotend;
			if (plotend - plotstart) == 273 
				plotend = plotend - 1;
			end
		end
	end
	
	%extend awssi sums to end of graph
	for i = endindex+1:plotend
		data(i,16) = data(i-1,16);
	end
	
end



end

