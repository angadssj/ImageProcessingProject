% Face detection 
function FaceDetection(image)
%Read in the image
%imageName='../images/Maxine.jpg';
%image = imread(imageName);
%show what we got
figure
imshow(image)
hold on;
%lets detect the face
%link http://angeljohnsy.blogspot.com/2013/07/face-detection-matlab-code.html
faceDetect = vision.CascadeObjectDetector;
boundingBox = step(faceDetect,image);
%create box aroud the face
for i = 1:size(boundingBox,1)
    rectangle('Position',boundingBox(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','y');
end
title('Face Detection');
hold on;
%lets detect the nose as it is one of the salient features of the face
noseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',4);
noseBoundingBox =  step(noseDetect,image);
%create box aroud the face
for i = 1:size(noseBoundingBox,1)
    rectangle('Position',noseBoundingBox(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','y');
end

%lets see if the eyes are a better target
eyesDetect = vision.CascadeObjectDetector('EyePairBig','MergeThreshold',4);
eyesBoundingBox =  step(eyesDetect,image);
%create box aroud the face
for i = 1:size(eyesBoundingBox,1)
    rectangle('Position',eyesBoundingBox(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','y');
end

clear
%end