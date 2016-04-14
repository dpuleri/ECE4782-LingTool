function indices = get_word_start_end(st)
% Get start and end of words
    THRESH = 0.07; % got from looking at graphs
    SILENCE_THRESH = THRESH;
    check_ahead = st(1).Fs .* 0.2; % check 200ms ahead..
    jump_ahead = st(1).Fs .* 0.05; % jump 50ms ahead..
    indices = zeros(length(st), 4); % 4 for 4 words...
    for i = 1:length(st) % root mean square stuff
        audio = [st(i).audioFilt];
%         THRESH = sqrt(sum(st(i).audioFilt.^2))/15; % got from looking at graphs
%         SILENCE_THRESH = THRESH/10;
        start = 1;
        for j = 1:4
            found = find(audio(start:end) > THRESH, 1);
            if ~isempty(found)
                indices(i,j) = start + found - 1; % off by 1 crap.. matlab!
            else
                indices(i,j) = start - 1; % off by 1 crap.. matlab!
            end
        
            % maybe try seaching ahead to see if I'm in a dead space
            % b/w words
            start = indices(i,j); % re-init start index
            done = false;
            while ~done
                done = all(audio(start:start+check_ahead) < SILENCE_THRESH);
                start = start+jump_ahead;
                if start >= length(audio)
                    break; % something is up...
                end
            end
            start = start+jump_ahead; % new search start
            
            if start >= length(audio)
                break; % something is up...
            end
        end
%         plot(st(i).audioFilt); % debug
%         plot_words(indices(i,:));
    end
end

