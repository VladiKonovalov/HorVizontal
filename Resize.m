function [  ] = Resize( A )
%TT Summary of this function goes here
%   Detailed explanation goes here
im=imread(A);
global MaxH;
global MaxW;
global Max;

[H W N] = size(im);
if (mod(H,2)~=0)
    H=H-1;
end
if (mod(W,2)~=0)
    W=W-1;
end

    y=floor((MaxH-H)/2);
    x=floor((MaxW-W)/2);

    d=padarray(im,[y x]);

 d= imresize(d,[MaxH MaxW]);
imwrite(d,A);


end

