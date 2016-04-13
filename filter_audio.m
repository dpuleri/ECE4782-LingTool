function st_filtered = filter_audio(st)
    st_filtered = st;
    H = notch60(st(1).Fs);
% Get start and end of words
    for i = 1:length(st)
        st_filtered(i).audioFilt = filter(H,st(i).audio);
    end
end
