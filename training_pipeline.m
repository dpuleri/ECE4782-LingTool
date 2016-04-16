%% Read in and filter

file_loc = '../JonVoiceData';
ground_truth_file = '../JonVoiceData/jon.xlsx';

st = read_audio_files(file_loc);
st = filter_audio(st);

%% Feature gathering
% indices of word start and word end
word_indices = get_word_start_end(st);

features = gather_features(st, word_indices);

raw_data = data_array_get(ground_truth_file);

ground_truth = match_ground_truth(st, raw_data);

%% Training
% This script assumes these variables are defined:
%
%   features - input data.
%   ground_truth - target data.

x = features';
t = ground_truth';

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.

% Create a Pattern Recognition Network
hiddenLayerSize = 20;
net = patternnet(hiddenLayerSize);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y)
tind = vec2ind(t);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);

% View the Network
view(net)

% Plots
% Uncomment these lines to enable various plots.
figure, plotperform(tr)
figure, plottrainstate(tr)
figure, ploterrhist(e)
figure, plotconfusion(t,y)
figure, plotroc(t,y)