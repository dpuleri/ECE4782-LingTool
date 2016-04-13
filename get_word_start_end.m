function indices = get_word_start_end(st)
% Get start and end of words
    THRESH = 0.05; % got from looking at graphs
    SILENCE_THRESH = 0.007;
    indices = zeros(length(st), 4); % 4 for 4 words...
    for i = 1:length(st) % root mean square stuff
        audio = [st(i).audioFilt];
        start = 1;
        for j = 1:4
            indices(i,j) = start + find(audio(start:end) > THRESH, 1) - 1; % off by 1 crap.. matlab!
        
%             start = indices(i,j) + st(i).Fs.*0.35; % assume word ~400ms long
            % maybe try seaching ahead to see if I'm in a dead space
            % b/w words
            start = indices(i,j); % re-init start index
            done = false;
            check_ahead = st(i).Fs .* 0.02; % check 20ms ahead..
            while ~done
                done = all(audio(start:start+check_ahead) < SILENCE_THRESH);
                start = start+check_ahead;
                if start >= length(audio)
                    break; % something is up...
                end
            end
            start = start+check_ahead; % new search start
            
            if start >= length(audio)
                break; % something is up...
            end
        end
    end

end

