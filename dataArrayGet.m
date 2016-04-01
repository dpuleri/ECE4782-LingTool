function [rawData] = dataArrayGet(filename)
[num text rawData] = xlsread(filename)
rawData = rawData(2:end, :)
end

