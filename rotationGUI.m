function [] = rotationGUI()
I = imread('frames/001.jpg');


hFig = figure('menu','none');
hAx = axes('Parent',hFig);
global hButton;


hTxt = uicontrol('Style','text', 'Position',[290 28 20 15], 'String','0');
uicontrol('Parent',hFig, 'Style','slider', 'Value',0, 'Min',0,...
    'Max',360, 'SliderStep',[1 10]./360, ...
    'Position',[150 5 300 20], 'Callback',{@slider_callback,I,hAx,hTxt,hFig})

hButton=uicontrol(hFig,'Style','pushbutton','String','Save and Close',...
    'Position',[10 20 120 40],'Callback',{@ok_Callback,I,hTxt,hFig,'frames/001.jpg'});
set(hButton,'Enable','off');


imshow(I, 'Parent',hAx)

%# Callback function
return;
end
    function slider_callback(hObj, eventdata,I,hAx,hTxt,hFig)
global angle
global Irot
global hButton
set(hButton,'Enable','on');
angle = round(get(hObj,'Value'));        %# get rotation angle in degrees

Irot = imrotate(I,angle);
imshow(Irot, 'Parent',hAx)  %# rotate image
if (angle==0) 
    angle=360;
end
set(hTxt, 'String',num2str(angle))       %# update text
end

function ok_Callback(hObj, eventdata,I,hTxt,hFig,path1)
global MaxH,global MaxW ,global Max

global Irot
set(hTxt, 'String','save')
imwrite(Irot,path1);
[MaxH ,MaxW ,Max]=size(Irot);
delete(hFig);
a=sprintf('rotated first frame');
disp(a);
FramesRotate();
end
