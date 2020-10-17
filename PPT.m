function [number_of_correct_responses, number_of_wrong_responses] = PPT(low_freq, high_freq, ISI, stim_dur, number_of_reversals)

% This script can be used to run pitch pattern test. The current default
% parameters used similar to procedure used in the study
% (https://pubmed.ncbi.nlm.nih.gov/30461390/). But default can be 
% manipulated by user input arguments. Frequeny must be entered in hertz and 
% durations in msec. Stimulus generation functions used in this script took from psychoacoustics toolbox.

% Default settings:
% low frequency stimuli = 880 Hz
% High frequency stimuli = 1430 Hz
% Stimuli duration = 500 msec
% Inter stimulus duration = 200 msec
% number of reversals = 10
% Stimulus envelope rise/fall time = 10 msec

% Usage format:
% [correct, wrong] = PPT
% [correct, wrong] = PPT(low_freq, high_freq)
% [correct, wrong] = PPT(low_freq, high_freq, ISI)
% [correct, wrong] = PPT(low_freq, high_freq, ISI, stim_dur)
% [correct, wrong] = PPT(low_freq, high_freq, ISI, stim_dur, number_of_reversals)

% The response by the participant must be given in the following format:
% Eg: If the subject hears high, high, low pattern. Subject response must 
% be HHL (without space inbetween).

% Further queries contact sathish.sreeni58@gmail.com

if nargin == 4
    number_of_reversals = 10;
elseif nargin == 3
    number_of_reversals = 10;
    stim_dur = 500;
elseif nargin == 2
    number_of_reversals = 10;
    stim_dur = 500;
    ISI = 200;
elseif nargin == 0
    number_of_reversals = 10;
    stim_dur = 500;
    ISI = 200;
    high_freq = 1430;
    low_freq = 880;
end

if nargin == 5
    % Generate tone
    x = (1:number_of_reversals);
    sf = 44100;
    low = GenerateTone(sf,stim_dur,low_freq);
    low = GenerateEnvelope(sf,low,10,10);
    high = GenerateTone(sf,stim_dur,high_freq);
    high = GenerateEnvelope(sf,high,10,10);
    Inter_stim_interval = zeros(round(sf*(ISI/1000)),1);
    silence = zeros(round(sf*(50/1000)),1);
    
    % Generate stimulus sequence
    HHL = [high; Inter_stim_interval; high; Inter_stim_interval; low];
    HLH = [high; Inter_stim_interval; low; Inter_stim_interval; high];
    LHH = [low; Inter_stim_interval; high; Inter_stim_interval; high];
    LLH = [low; Inter_stim_interval; low; Inter_stim_interval; high];
    LHL = [low; Inter_stim_interval; high; Inter_stim_interval; low];
    HLL = [high; Inter_stim_interval; low; Inter_stim_interval; low];
    g = [];
    h = [];
    
    for i = 1
        for j = 1:length(x)
            % randomize the stimulus presentation
            a = randperm(6);
            for ii = 1
                for jj = 1
                    if a(ii,jj) == 1;
                        seq = [silence; HHL; silence];
                        b = HHL;
                        c = 'HHL';
                    elseif a(ii,jj) == 2;
                        seq = [silence; HLH; silence];
                        b = HLH;
                        c = 'HLH';
                    elseif a(ii,jj) == 3;
                        seq = [silence; LHH; silence];
                        b = LHH;
                        c = 'LHH';
                    elseif a(ii,jj) == 4;
                        seq = [silence; LLH; silence];
                        b = LLH;
                        c = 'LLH';
                    elseif a(ii,jj) == 5;
                        seq = [silence; LHL; silence];
                        b = LHL;
                        c = 'LHL';
                    else a(ii,jj) == 6;
                        seq = [silence; HLL; silence];
                        b = HLL;
                        c = 'HLL';
                    end
                end
            end
            % play stimulus sequence
            sound(seq,sf)
            response = input('Type the stimulus sequence you heard: ');
            % analyse the response
            if response == b
                disp('CORRECT')
                score = 1;
                g = [g score];
            else
                disp('WRONG')
                score = 1;
                h = [h score];
            end
            
            % calucalte number of correct and wrong responses
            correct = sum(g);
            wrong = sum(h);
        end
    end
    
    final_response = [correct wrong];
    number_of_correct_responses = final_response(1,1);
    number_of_wrong_responses = final_response(1,2);
else
    % Generate tone
    x = (1:number_of_reversals);
    sf = 44100;
    low = GenerateTone(sf,stim_dur,low_freq);
    low = GenerateEnvelope(sf,low,10,10);
    high = GenerateTone(sf,stim_dur,high_freq);
    high = GenerateEnvelope(sf,high,10,10);
    Inter_stim_interval = zeros(round(sf*(ISI/1000)),1);
    silence = zeros(round(sf*(50/1000)),1);
    
    % Generate stimulus sequence
    HHL = [high; Inter_stim_interval; high; Inter_stim_interval; low];
    HLH = [high; Inter_stim_interval; low; Inter_stim_interval; high];
    LHH = [low; Inter_stim_interval; high; Inter_stim_interval; high];
    LLH = [low; Inter_stim_interval; low; Inter_stim_interval; high];
    LHL = [low; Inter_stim_interval; high; Inter_stim_interval; low];
    HLL = [high; Inter_stim_interval; low; Inter_stim_interval; low];
    g = [];
    h = [];
    
    for i = 1
        for j = 1:length(x)
            % randomize the stimulus presentation
            a = randperm(6);
            for ii = 1
                for jj = 1
                    if a(ii,jj) == 1;
                        seq = [silence; HHL; silence];
                        b = HHL;
                        c = 'HHL';
                    elseif a(ii,jj) == 2;
                        seq = [silence; HLH; silence];
                        b = HLH;
                        c = 'HLH';
                    elseif a(ii,jj) == 3;
                        seq = [silence; LHH; silence];
                        b = LHH;
                        c = 'LHH';
                    elseif a(ii,jj) == 4;
                        seq = [silence; LLH; silence];
                        b = LLH;
                        c = 'LLH';
                    elseif a(ii,jj) == 5;
                        seq = [silence; LHL; silence];
                        b = LHL;
                        c = 'LHL';
                    else a(ii,jj) == 6;
                        seq = [silence; HLL; silence];
                        b = HLL;
                        c = 'HLL';
                    end
                end
            end
            % play stimulus sequence
            sound(seq,sf)
            response = input('Type the stimulus sequence you heard: ');
            % analyse the response
            if response == b
                disp('CORRECT')
                score = 1;
                g = [g score];
            else
                disp('WRONG')
                score = 1;
                h = [h score];
            end
            
            % calucalte number of correct and wrong responses
            correct = sum(g);
            wrong = sum(h);
        end
    end
    
    final_response = [correct wrong];
    number_of_correct_responses = final_response(1,1);
    number_of_wrong_responses = final_response(1,2);
end