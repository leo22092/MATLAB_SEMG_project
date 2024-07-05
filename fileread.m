% This script will read the .mat files downloaded locally to
% to your hard drive. The downloaded files are organzied in 3 folders
% 'Session 1','Session 2' and 'Session 3'. Each folder contains 43 .mat
% files
%
% signal properties
% total channels = 28 (16 forearm + 12 wrist)
% sampling frequency = 2048 Hz
% bandpass filtering (hardware) = 10Hz-500Hz
%
%
% In order to run this script make sure the above three folders are and
% codes feature_extraction.m segmentEMG.m and featiDFTl.m are in the same 
% directory as fileread.m
%
%
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



clear 
addpath(genpath([pwd filesep 'Session 1']))
addpath(genpath([pwd filesep 'Session 2']))
addpath(genpath([pwd filesep 'Session 3']))

%obtain the total number of subject. Note the total subjects should be same
% in all the three folders
NSUB = length(dir([pwd filesep 'Session 1']))-2; %please make sure the number 
                        %of subjects in the three session folders are the
                        %same. Default value is 43
NSESSION = 1;
NGESTURE = 16;              %total number of gestures
NTRIALS = 7;                %total number of trials

display(['Next: EMG Signal Processing: ' pwd])
cont = upper(input('Proceed (Y/N)?','s'));
if(strcmp(cont,'Y') || strcmp(cont,'N'))
    if(strcmp(cont,'Y'))
        feature_extraction;        
    else
        flag=1;
        disp('Exiting Script !')
        return;
    end
end


