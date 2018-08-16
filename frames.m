function [  ] = frames()
global vid, global dic
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
mov = VideoReader(fullfile(dic,vid));
global numFrames
% Defining Output folder as 'snaps'
opFolder = fullfile(cd, 'frames');
%if  not existing 
if ~exist(opFolder, 'dir')
%make directory & execute as indicated in opfolder variable
mkdir(opFolder);
end

%getting no of frames
numFrames = mov.NumberOfFrames;

%setting current status of number of frames written to zero
numFramesWritten = 0;

%for loop to traverse & process from frame '1' to 'last' frames 
for t = 1 : numFrames    
currFrame = read(mov, t);
%%  add a black borders 
%currFrame(:,1:10,:) = 0;
%currFrame(1:10,:,:) = 0;
%currFrame(:,end-09:end,:) = 0;
%currFrame(end-09:end,:,:) = 0; %reading individual frames
%%
opBaseFileName = sprintf('%3.3d.jpg', t);
opFullFileName = fullfile(opFolder, opBaseFileName);
imwrite(currFrame, opFullFileName, 'jpg');   %saving as 'png' file
%indicating the current progress of the file/frame written
if (mod(t,100)==0)
progIndication = sprintf('Wrote frame %4d of %d.', t, numFrames);
disp(progIndication);
end
numFramesWritten = numFramesWritten + 1;
end      %end of 'for' loop

 progIndication = sprintf('Wrote %d frames to folder "%s"',numFramesWritten, opFolder);
disp(progIndication);
%End of the code
rotationGUI();
end

