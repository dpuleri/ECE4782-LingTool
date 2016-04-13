% main script

st = read_audio_files('../DanielVoiceData/tst'); % 2 test signals here
st = filter_audio(st);
subplot(2,1,1);
plot(st(1).audioFilt); % tired
title('tired');
subplot(2,1,2);
plot(st(2).audioFilt) % good
title('good');

meanAmp = zeros(length(st),1); % possible first feature
for i = 1:length(st)
    meanAmp(i) = sqrt(mean([st(i).audioFilt].^2));
end

disp(meanAmp);