function  ChangeColorFace( image , boundingBox , noseBoundingBox , eyesBoundingBox)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


%let the experimentation begin
eyesBoundingBox(1) = eyesBoundingBox(1) - 25
eyesBoundingBox(3) = eyesBoundingBox(3) + 50

figure;
imshow(imcrop(image,eyesBoundingBox),[]);
eyeArea = imcrop(image,eyesBoundingBox);

hsvImage =  rgb2hsv(eyeArea);
figure;
imshow(hsvImage,[]);

% getting different channels of the image
figure
imshow(eyeArea(:,:,1));
figure
imshow(eyeArea(:,:,2));
figure
imshow(eyeArea(:,:,3));

%edge extraction on 1st one
hue = eyeArea(:,:,1);
edges =  edge(hue,'Roberts');
figure;
imshow(edges,[]);
%get a line through the eyes and 
[m,n] =  size(edges)
edges = edges (floor(m/2),:);
figure;
imshow(edges,[]);

% find where the edge of the face is and where the eyes are
indicies = find(edges)

if indicies(1) < (n - indicies(end))
    fprintf('looking right')
else
    fprintf('looking left')
end


end

