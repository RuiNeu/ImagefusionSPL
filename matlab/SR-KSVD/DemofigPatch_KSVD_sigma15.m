%close all;clear all;clc;
addpath Evaluation;
addpath Focus;

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

if size(im1) ~= size(im2)	% Check if the input images are of the same size
    error('Size of the source images must be the same!');
end

%% setting noise cases
sigma = 15;

if sigma > 0
    v = sigma/(255*255);
    im1 =imnoise(im1,'gaussian',0, v );
    im2 =imnoise(im2,'gaussian',0, v );
end

im1=double(im1);
im2=double(im2);


pz = 5; %patch size
load(['LearnedD25X256']);
[imgf1,Result_K1_sigma] = mainSRKSVD(im1,im2,Dksvd);
clear Dksvd;

pz = 6;
load(['LearnedD36X256']);
[imgf2,Result_K2_sigma] = mainSRKSVD(im1,im2,Dksvd);
clear Dksvd;

pz = 7;
load(['LearnedD49X256']);
[imgf3,Result_K3_sigma] = mainSRKSVD(im1,im2,Dksvd);
clear Dksvd;

pz = 8;
load(['LearnedD64X256']);
[imgf4,Result_K4_sigma] = mainSRKSVD(im1,im2,Dksvd);
clear Dksvd;

pz = 9;
load(['LearnedD81X256']);
[imgf5,Result_K5_sigma] = mainSRKSVD(im1,im2,Dksvd);
clear Dksvd;

