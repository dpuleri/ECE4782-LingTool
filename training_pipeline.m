file_loc = '../DanielVoiceData/real';
ground_truth_file = '../DanielVoiceData/real/sleep_ground_truth.xlsx';

st = read_audio_files(file_loc);
st = filter_audio(st);

% indices of word start and word end
word_indices = get_word_start_end(st);

features = gather_features(st, word_indices);

raw_data = data_array_get(ground_truth_file);

ground_truth = match_ground_truth(st, raw_data);