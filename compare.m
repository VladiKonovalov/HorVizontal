function [  ] = compare( a,b ) 
global MaxH;
global MaxW;
global Max;

origina = imread(a);
original=rgb2gray(origina);
%imshow(original);
%text(size(original,2),size(original,1)+15, ...
%    'Image courtesy of Massachusetts Institute of Technology', ...
 %   'FontSize',7,'HorizontalAlignment','right');

%% Step 2: Resize and Rotate the Image

distorted = rgb2gray(imread(b)); % Try varying the angle, theta.
%figure, imshow(distorted)

%%
% You can experiment by varying the scale and rotation of the input image.
% However, note that there is a limit to the amount you can vary the scale
% before the feature detector fails to find enough features.

%% Step 3: Find Matching Features Between Images
% Detect features in both images.
ptsOriginal  = detectSURFFeatures(original);
ptsDistorted = detectSURFFeatures(distorted);

%%
% Extract feature descriptors.
[featuresOriginal,  validPtsOriginal]  = extractFeatures(original,  ptsOriginal);
[featuresDistorted, validPtsDistorted] = extractFeatures(distorted, ptsDistorted);

%%
% Match features by using their descriptors.
index_pairs = matchFeatures(featuresOriginal, featuresDistorted);

%%
% Retrieve locations of corresponding points for each image.
matchedOriginal  = validPtsOriginal(index_pairs(:,1));
matchedDistorted = validPtsDistorted(index_pairs(:,2));

%%
% Show putative point matches.
%figure;
%showMatchedFeatures(original,distorted,matchedOriginal,matchedDistorted);
%title('Putatively matched points (including outliers)');

%% Step 4: Estimate Transformation
% Find a transformation corresponding to the matching point pairs using the
% statistically robust M-estimator SAmple Consensus (MSAC) algorithm, which
% is a variant of the RANSAC algorithm. It removes outliers while computing
% the transformation matrix. You may see varying results of the
% transformation computation because of the random sampling employed by the
% MSAC algorithm.
[tform, inlierDistorted, inlierOriginal] = estimateGeometricTransform(...
    matchedDistorted, matchedOriginal, 'similarity');

%%
% Display matching point pairs used in the computation of the
% transformation.
%figure; 
%showMatchedFeatures(original,distorted,inlierDistorted, inlierOriginal);
%title('Matching points (inliers only)');
%legend('ptsOriginal','ptsDistorted');

%% Step 5: Solve for Scale and Angle
% Use the geometric transformation, tform, to recover the scale and angle.
% Since we computed the transformation from the distorted to the original
% image, we need to compute its inverse to recover the distortion.
%
%  Let sc = s*cos(theta)
%  Let ss = s*sin(theta)
%
%  Then, Tinv = [sc -ss  0;
%                ss  sc  0;
%                tx  ty  1]
%
%  where tx and ty are x and y translations, respectively.
%

%%
% Compute the transformation matrix for the invert transform.
Tinv  = tform.invert.T;

ss = Tinv(2,1);
sc = Tinv(1,1);
  scale_recovered = sqrt(ss*ss + sc*sc);
 theta_recovered = atan2(ss,sc)*180/pi;


%%
% The recovered values should match your scale and angle values selected in
% *Step 2: Resize and Rotate the Image*.

%% Step 6: Recover the Original Image
% Recover the original image by transforming the distorted image.
 %outputView = imref2d(size(original));
 %recovered  = imwarp(distorted,tform,'OutputView',outputView);
 c=imread(b);
angle=double(360-theta_recovered);
c=imrotate(c,angle);
imwrite(c,b);
%BlackIgnore(recovered);
% x=imrotate(b,int16(atan2(ss,sc)*180/pi)+180);
%imwrite(recovered,b);

%%
% Compare |recovered| to |original| by looking at them side-by-side in a
% montage.

 %figure, imshowpair(original,recovered,'montage')

%%
% The |recovered| (right) image quality does not match the |original|
% (left) image because of the distortion and recovery process. In
% particular, the image shrinking causes loss of information. The artifacts
% around the edges are due to the limited accuracy of the transformation.
% If you were to detect more points in *Step 4: Find Matching Features
% Between Images*, the transformation would be more accurate. For example,
% we could have used a corner detector, detectFASTFeatures, to complement
% the SURF feature detector which finds blobs. Image content and image size
% also impact the number of detected features.

% displayEndOfDemoMessage(mfilename)


end

