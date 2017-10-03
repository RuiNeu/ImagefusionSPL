%close all;clear all;clc;
addpath Evaluation;
addpath Focus;
%% input two multi-focus images
[imagename1, imagepath1] = uigetfile('Focus\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
im1=imread(strcat(imagepath1,imagename1));
[imagename2, imagepath2]=uigetfile('Focus\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
im2 = imread(strcat(imagepath2,imagename2));
if size(im1,3) == 3     % Check if the images are grayscale
    im1 = rgb2gray(im1);
end
if size(im2,3) == 3
    im2 = rgb2gray(im2);
end


%% setting parameters
sigma = 15;

if sigma > 0
    v = sigma/(255*255);
    im1 =imnoise(im1,'gaussian',0, v );
    im2 =imnoise(im2,'gaussian',0, v );
end

im1=double(im1);
im2=double(im2);


pz = 5;
[imgf1,Result_R1_sigma] = mainSFDCTvar(im1,im2,pz);

pz = 6;
[imgf2,Result_R2_sigma] = mainSFDCTvar(im1,im2,pz);

pz = 7;
[imgf3,Result_R3_sigma] = mainSFDCTvar(im1,im2,pz);

pz = 8;
[imgf4,Result_R4_sigma] = mainSFDCTvar(im1,im2,pz);

pz = 9;
[imgf5,Result_R5_sigma] = mainSFDCTvar(im1,im2,pz);
