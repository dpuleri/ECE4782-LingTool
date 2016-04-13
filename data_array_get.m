function [rawData] = data_array_get(filename)
    [~, ~, rawData] = xlsread(filename);
    rawData = rawData(2:end, :);
end

