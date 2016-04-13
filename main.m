% main script

st = read_audio_files('../DanielVoiceData/tst'); % 2 test signals here
st = filter_audio(st);

% indices of word start and word end
word_indices = get_word_start_end(st);

features = zeros(length(st), 13); % 13 so far...
% (01) -> RMS of whole sig
% (02) -> RMS of 1st word
% (03) -> length of 1st word
% (04) -> max freq of 1st word
% (05) -> RMS of 2ns word
% (06) -> length of 2nd word
% (07) -> max freq of 2ns word
% (08) -> RMS of 3rd word
% (09) -> length of 3rd word
% (10) -> max freq of 3rd word
% (11) -> RMS of 4th word
% (12) -> length of 4th word
% (13) -> max freq of 4th word
for i = 1:length(st)
    features(i,1) = sqrt(sum(st(i).audioFilt.^2)); % RMS of whole sig
    
    % loop through each word... fft(signal)
    feat_ind = 2;
    for j = 1:length(word_indices(i, :)) % should be 4
        if j <4
            RMS_cur_word = sqrt(sum(st(i).audioFilt(word_indices(i,j):word_indices(i,j+1)).^2));
            len_cur_word = (word_indices(i,j+1) - word_indices(i,j)) .* (st(i).Fs .^ -1); % in sec
            [~, freq_cur_word] = max(fft(st(i).audioFilt(word_indices(i,j):word_indices(i,j+1)))); % not exactly freq, but doesn't matter
        else
            RMS_cur_word = sqrt(sum(st(i).audioFilt(word_indices(i,j):end).^2));
            len_cur_word = (length(st(i).audioFilt) - word_indices(i,j)) .* (st(i).Fs .^ -1); % in sec
            [~, freq_cur_word] = max(fft(st(i).audioFilt(word_indices(i,j):end))); % not exactly freq, but doesn't matter
        end
        features(i,feat_ind) = RMS_cur_word;
        features(i,feat_ind+1) = len_cur_word;
        features(i,feat_ind+2) = freq_cur_word;
        feat_ind = feat_ind+3;
    end
end

subplot(2,1,1);
plot(st(1).audioFilt); % tired
plot_words(word_indices(1,:));
% hold on
% yl = get(gca,'ylim');
% plot([st(1).Fs.*0.3 st(1).Fs.*0.3], yl, 'r-');
% hold off

title('tired');
subplot(2,1,2);
plot(st(2).audioFilt) % good
plot_words(word_indices(2,:));
title('good');

disp(features);