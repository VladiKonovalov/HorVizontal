function [  ] = video( )
global MaxH;
global MaxW;
global vid;
 global dic;

 shuttleVideo = VideoReader(fullfile(dic,vid));
 
 imageNames = dir(fullfile('frames','*.jpg'));
 imageNames = {imageNames.name}';
 imageStrings = regexp([imageNames{:}],'(\d*)','match');
 imageNumbers = str2double(imageStrings);
[~,sortedIndices] = sort(imageNumbers);
 sortedImageNames = imageNames(sortedIndices);
 


outputVideo = VideoWriter(fullfile('shuttle_out'));
outputVideo.FrameRate = shuttleVideo.FrameRate;
open(outputVideo);

if (mod(MaxH,2)~=0)
    MaxH=MaxH+1;
end
if (mod(MaxW,2)~=0)
    MaxW=MaxW+1;
end

for ii = 2:length(sortedImageNames)
    file_name1 = sprintf('frames/%0.3d.jpg', ii);
    Resize(file_name1);
    img = imread(fullfile('frames',sortedImageNames{ii}));
    
    writeVideo(outputVideo,img);
end
close(outputVideo);

rmdir('frames','s')

end

