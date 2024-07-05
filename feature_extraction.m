% This script will process the .mat files located in the main directory and
% organzied in 3 folders 'Session 1','Session 2' and
% 'Session 3'. Each folder contains 43 .mat files, with 7x17 cell matrix (runs x gestures)
% Each cell: 10240x32 (sampfreq*5sec x channels)
%
%
% Standard windowing of EMG signal is performed followed by frequency
% division technique feature extraction
%
% output %%%%%%%%%
% Main Folder: 'Feature Extracted BM'
% File: 'Forearm_Session1.mat' 'Forearm_Session2.mat' 'Forearm_Session3.mat'
% VarOut: FeatSet (NSUB x NGESTURES cell matrix)
% Each cell: NSAMPLE x NFEATURES
%
% note: the following code is for forearm featureset extraction, the wrist
% featureset can be extracted in a similar manner
%
% Forearm Electrode Configuration %%%%%%%%%
%  1  2  3  4  5  6  7  8
%  9 10 11 12 13 14 15 16
%
% Wrist Electrode Configuration %%%%%%%%%
%  1  2  3  4  5  6
%  7  8  9 10 11 12
%
% Written by Ashirbad Pradhan
% email: ashirbad.pradhan@uwaterloo.ca


%obtain the total number of subject. Note the total subjects should be same
% in all the three folders
fs = 2048;                   %sampling frequency
a1=[];                      % temporary variable to merge trials of a specific contraction
a2=[];                      % temporary variable to
CompleteSet=[];        % store final gestures and subjects for each session

%% Define output folder
if ~exist('Feature Extracted BM', 'dir')
    mkdir('Feature Extracted BM')
else
    disp('Overwriting')
    rmdir('Feature Extracted BM','s')
    mkdir('Feature Extracted BM')
end

%% flatten the trials to obtain Gestures x Subjects
for isession=1:NSESSION
    for isub =1:NSUB
        fileName = ['session' num2str(isession) '_participant',num2str(isub),'.mat'];
        datafile=load(fileName,'DATA');
        for igesture = 1:NGESTURE+1        % +1 to include rest gesture
            for itrial=1:NTRIALS
                a1=[a1; datafile.DATA{itrial,igesture}];
            end
            a2=[a2,{a1}];
            a1=[];
        end
        CompleteSet=[CompleteSet;a2];
        a2=[];
        disp(['Loaded: ' num2str(isession) ' ' num2str(isub)])
    end
end

%% segmentation and processing
count=0;
for isession = 1: NSESSION
    FeatSet={};
    for isub =1:NSUB
        for igesture = 1:NGESTURE
            OneSet = CompleteSet{isub,igesture}';       %shape=16xTotalSamples
            post_process=[];
            for ichannel_2=1:8         % monopolar 8 channel with average referencing
                temp2 = OneSet(1:8,:);
                post_process(ichannel_2,:)=OneSet(ichannel_2,:)-mean(temp2,1);
            end
            % %         for ichannel_2=1:8         % bipolar 8 channel processing
            % %             post_process(ichannel_2,:)=OneSet(ichannel_2,:)-OneSet(ichannel_2+8,:);
            % %         end
            % segment the EMG Data
            segData = segmentEMG(post_process', 0.2, 0.15, NTRIALS*5, fs, 1);  % post_process' has to be NSampx8
            %extract the frequency features
            feat= featiDFTl(2048,6,segData);
            FeatSet(isub,igesture)={feat};
        end
        count=count+1;
        disp(['processed: ',num2str(count),' of ', num2str(NSUB*NSESSION),' files'])
    end
    disp(['saving: Session ',num2str(isession),' biometric data'])
    save(['Feature Extracted BM' filesep 'Forearm_Session' num2str(isession) '.mat'],'FeatSet')
end