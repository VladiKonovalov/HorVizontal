function [  ] = FramesRotate()
global ir;
global numFrames
global angle



if (angle~= 360)
for i = 2 : numFrames 
img=imread( sprintf( 'frames/%03i.jpg', i ) ); 
ir=imrotate( img, angle,'crop'); 
imwrite(ir,sprintf( 'frames/%03i.jpg', i ) );



end
end
a=sprintf('rotated all frames');
disp(a);
b=sprintf('please wait...');
disp(b);
for i=1:(numFrames-1)
file_name1 = sprintf('frames/%0.3d.jpg', i);
file_name2 = sprintf('frames/%0.3d.jpg', (i+1));
compare(file_name1,file_name2);
BlackIgnore(file_name1);
MaxSize(file_name1);
end
BlackIgnore(sprintf('frames/%0.3d.jpg', numFrames));
MaxSize(sprintf('frames/%0.3d.jpg', numFrames));

e=sprintf('make video');
disp(e);
video();
end