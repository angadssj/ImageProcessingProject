% This file will be used to see if we can recognise a face as an input

%Setup matconvnet, change this to a non hard coded path
run ../resources/matconvnet-1.0-beta23/matlab/vl_setupnn;

% link where this code is from https://github.com/vlfeat/matconvnet/blob/
%master/examples/vggfaces/cnn_vgg_faces.m
%Get the net and see what happens
net = load('vgg-face.mat');
net = vl_simplenn_tidy(net) ;

% load image
im = imread('../images/Maxine.jpg')
im_ = single(im) ; % note: 255 range
im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
im_ = bsxfun(@minus,im_,net.meta.normalization.averageImage) ;
res = vl_simplenn(net, im_) ;

% Show the classification result.
scores = squeeze(gather(res(end).x)) ;
[bestScore, best] = max(scores) ;
figure(1) ; clf ; imagesc(im) ; axis equal off ;
title(sprintf('%s (%d), score %.3f',...
              net.meta.classes.description{best}, best, bestScore), ...
      'Interpreter', 'none') ;
%surprise this code is used to recognise all faces

