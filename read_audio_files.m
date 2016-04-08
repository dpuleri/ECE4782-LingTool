function struct_obj = read_audio_files(directory)
%
% function struct_obj = read_audio_files(directory)
% input: directory (string) -> name of the directory where the file
%   is being read from; can be a relative path
% outut: struct_obj (structure) -> contains the following fields
%   day
%   timeOfDay
%   isNoisy
%   audio
%   Fs


    fileList = dir(directory); % reads in the directory
    fileList = fileList(~[fileList.isdir]);
    
    % ignore files that are not audio files
    PAT = '\d{2}-\d{2}-\w-\w.[mp3|m4u]'; % regex pattern to match to
    i = 1;
    while i <= length(fileList)
        if isempty(regexp(fileList(i).name, PAT, 'ONCE'))
            fileList(i) = []; % delete the offending file
        else
            i = i + 1;
        end
    end
    
    struct_obj = struct;
    for ind = 1:length(fileList)
        % File naming protocol: MM-DD-T-X.mp3
        fileName = fileList(ind).name;
        day = fileName(1:5);
        timeOfDay = fileName(7);
        isNoisy = strcmp(fileName(9), 'N') || strcmp(fileName(9), 'L');
        
        % now get the audio
        [audio, Fs] = audioread([directory '/' fileName]);
        
        % store it in the structure
        struct_obj(ind).day = day;
        struct_obj(ind).timeOfDay = timeOfDay;
        struct_obj(ind).isNoisy = isNoisy;
        struct_obj(ind).audio = audio;
        struct_obj(ind).Fs = Fs;
    end
    
end