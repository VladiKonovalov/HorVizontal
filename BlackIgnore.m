function [  ] = BlackIgnore( a )
I2=im2double(imread(a));
sizeI = size(I2);
zeros1 = floor((sizeI(2)  -  max(sum(any(I2))))/2);
if(zeros1>0)
I3 = I2(:, zeros1 : sizeI(2)-zeros1, :);




sizeI2 = size(I3);
zerosRows = floor((sizeI(1) -   max(sum(any(I3, 2))))/2);
if (zerosRows>0)
I4 = I3(zerosRows : sizeI2(1)-zerosRows, :, :);
imwrite(I4,a);
else
imwrite(I3,a);

end

end


end
