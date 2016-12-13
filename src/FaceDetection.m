% Face detection 
function FaceDetection(image)

%show what we got
figure
imshow(image,[]);
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

% %lets detect the nose as it is one of the salient features of the face
noseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',6);% fix threshold
noseBoundingBox =  step(noseDetect,image)
%create box aroud the nose
for i = 1:size(noseBoundingBox,1)
    rectangle('Position',noseBoundingBox(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','y');
end

%lets see if the eyes are a better target
eyesDetect = vision.CascadeObjectDetector('EyePairBig');
eyesBoundingBox =  step(eyesDetect,image);

%create box aroud the face
for i = 1:size(eyesBoundingBox,1)
    rectangle('Position',eyesBoundingBox(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','y');
end
hold off;

%lets detect where the person is looking
%put checks here for having boxes around the salient features
if ~isempty(boundingBox)
    centerFace = locateCenter(boundingBox)
    %check for nose detection
    if ~isempty(noseBoundingBox)
        centerNose = locateCenter(noseBoundingBox)
        leftOrRight =  centerFace(1) - centerNose(1)
        if leftOrRight < 0
            fprintf('Nose = left oriented \n')
        else 
            fprintf('Nose = right oriented \n')
        end
    else
        fprintf('cannot detect nose \n')
    end
    % check using eyes 
    if ~isempty(eyesBoundingBox)
        centerEyes = locateCenter(eyesBoundingBox)
        leftOrRight =  centerFace(1) - centerEyes(1)
        if leftOrRight < 0
            fprintf('Eyes  = left oriented \n')
        else 
            fprintf('Eyes = right oriented \n')
        end
    else
        fprintf('cannot detect eyes \n')
    end
else 
    fprintf('Cannot detect a face \n');
end

%************************************************************************%
if ~isempty(eyesBoundingBox)
    % Sometimes we get 2 rectangles, then we keep the first rectangle1
    [m,n] = size(eyesBoundingBox);
    % check if this works with prof
    if m > 1
        eyesBoundingBox = eyesBoundingBox(1,:)    
    end
    ChangeColorFace(image, boundingBox, noseBoundingBox , eyesBoundingBox);
   
    else
        fprintf('cannot detect eyes \n')
end
%end