function [startindex, endindex, plotstart, plotend, done] = selectNextYear(data, lastend, startlog, endlog, plotlog)
%SELECTNEXTYEAR Gives indices of where the next winter is
%   Everything commented out moved to createDateLogs

done = 0;
%determine when winter starts
startlog(:,1) = (data(:,5) >= .1); %snowfall check
startlog(:,2) = (data(:,2) <= 32); %temp check


startindex = length(data);
for i = lastend+30:length(data) %checks for start date starting month after last end
    if sum(startlog(i,:)) ~= 0
        startindex = i;
        break;
    end
end

%if startindex is not found, last year has been reached
if startindex == length(data);
	done = 1;
end

%finds plot start 

for i = startindex:-1:1
	if plotlog(i,1) == 1;
		plotstart = i;
		break;
	end
end


%%%%%%%%%%%%%%%%ENDING STUFF%%%%%%%%%%%%

%determine when winter ends
endlog(:,1) = (data(:,5) >= .1); %snowfall check
endlog(:,2) = (data(:,6) >= 1); %snowdepth
endlog(:,3) = (data(:,2) <= 32); %temp

%find next july 1 (limit for checking end of winter)
for i = startindex:length(data)
	if (startlog(i,6) == 1) || (i == length(data))
		endlimit = i; %will be last day if no next july 1 exists
		break;
	end
end

endindex = endlimit; %will be hard capped at endlimit if none is found (EXTREMELY UNLIKELY)
for i = startindex:endlimit
   if sum(endlog(i,:)) ~= 0
       endindex = i;
   end
end
%find plot end
plotend = plotstart + 271;
if plotend > length(data)
	plotend = length(data);
	done = 1;
end

end

