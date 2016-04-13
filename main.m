% main script

st = read_audio_files('../DanielVoiceData/tst'); % 2 test signals here
st = filter_audio(st);

% indices of word start and word end
word_indices = get_word_start_end(st);

features = gather_features(st, word_indices);

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