function [  ] = MaxSize( x )
global MaxH;
global MaxW;
global Max;
z=imread(x);
[H W Y]=size(z);
if (H>MaxH)
    MaxH=H;
end
    if (W>MaxW)
        MaxW=W;
    end
    if (Y>Max) 
        Max=Y;
    end
end

