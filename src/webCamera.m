%starting to use the webcam to see if I can get images
cam = webcam;
preview(cam);
pause;
% get snapshot of the image
image = snapshot(cam);
%send to detect face
FaceDetection(image);
closePreview(cam);
clear('cam');
