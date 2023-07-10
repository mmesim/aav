%Absolute average value 
% add comments
clear;clc; close all

%% 00. Parameters
directory='data/FP1'; %data 
wlen=86400; % seconds [daily wavofrms]
window=60; % In seconds -- i.e. one minute
type='high';
co=10;  % Hz 

%% 01. Load sac files and construct structures
pdir=sprintf('%s/src/',pwd);  % get working directory path
addpath(genpath(pdir)); %add all *.m scripts to path
waveforms=load_waveforms(directory,wlen);

%% 02. Calculate Absolute Average Value
[cha_val,aav]=aav(waveforms,type,co,window);
