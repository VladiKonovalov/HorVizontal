function [  ] = final()
%FINAL Summary of this function goes here
%   Detailed explanation goes here
global dic,global MaxH ,global MaxW ,global Max

[filename,dic] = uigetfile('*.mp4','Select the MATLAB code file');

[y,Fs] = audioread(fullfile(dic,filename));
audiowrite('sound.wav',y,Fs);
MaxH=0;
MaxW=0;
Max=0;

clear y Fs
global vid
vid=filename;
frames();
end

