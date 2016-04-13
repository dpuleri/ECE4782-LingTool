function ground_truth = match_ground_truth(st, raw_data)
% function ground_truth = match_ground_truth(st, raw_data)
%
% assume that the raw data comes in ordered from earliest to most recent
% raw_data second column has hours of sleep and third column has the
% tired_feeling index. Higher the index, the more tired the person is

% output, ground truth with 1 if sleepy/tired and 0 if good

    ground_truth = zeros(length(raw), 1); % pre-alloc
    for i = 1:length(st)
        raw_data_ind = ceil(i/3); % map this to the raw data indices
 
        % if we have the previous day's data, take it into account
        if raw_data_ind > 1
            sleep_hours = 0.75.*raw_data(raw_data_ind,2) + 0.25*.raw_data(raw_data_ind-1,2); % weighted
            tired_feeling = 0.75.*raw_data(raw_data_ind,3) + 0.25*.raw_data(raw_data_ind-1,3); % weighted
        else
            sleep_hours = raw_data(raw_data_ind,2); % un-weighted
            tired_feeling = raw_data(raw_data_ind,3); % un-weighted
        end
        
        % assign value based on this threshold
        % no need to assign good value since pre-allocated
        if sleep_hours <= 6 || tired_feeling <= 3
            ground_truth(i) = 1;
        end
    end
end