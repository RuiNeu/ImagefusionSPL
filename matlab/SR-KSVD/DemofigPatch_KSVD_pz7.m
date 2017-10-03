%close all;clear all;clc;
addpath Evaluation;
addpath(genpath('ksvdbox'));
addpath Focus

[imagename1, imagepath1] = uigetfile('Focus\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
im1_o=imread(strcat(imagepath1,imagename1));
[imagename2, imagepath2]=uigetfile('Focus\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
im2_o = imread(strcat(imagepath2,imagename2));

if size(im1_o,3) == 3     % Check if the images are grayscale
    im1_o = rgb2gray(im1_o);
end
if size(im2_o,3) == 3
    im2_o = rgb2gray(im2_o);
end

%% setting parameters

load(['LearnedD49X256']);

sigma = 0;
im1=double(im1_o);
im2=double(im2_o);
[imgf1,~] = mainSRKSVD(im1,im2,Dksvd);
Result_K1 = Evaluation (im1_o,im2_o,imgf1,256);
clear sigma;

sigma = 5;
v = sigma/(255*255);
im1 =imnoise(im1_o,'gaussian',0, v );
im2 =imnoise(im2_o,'gaussian',0, v );
im1=double(im1);
im2=double(im2);
[imgf2,~] = mainSRKSVD(im1,im2,Dksvd);
Result_K2 = Evaluation (im1_o,im2_o,imgf2,256);
clear sigma;

sigma = 10;
v = sigma/(255*255);
im1 =imnoise(im1_o,'gaussian',0, v );
im2 =imnoise(im2_o,'gaussian',0, v );
im1=double(im1);
im2=double(im2);
[imgf3,~] = mainSRKSVD(im1,im2,Dksvd);
Result_K3 = Evaluation (im1_o,im2_o,imgf3,256);
clear sigma;

sigma = 15;
v = sigma/(255*255);
im1 =imnoise(im1_o,'gaussian',0, v );
im2 =imnoise(im2_o,'gaussian',0, v );
im1=double(im1);
im2=double(im2);
[imgf4,~] = mainSRKSVD(im1,im2,Dksvd);
Result_K4 = Evaluation (im1_o,im2_o,imgf4,256);
clear sigma;

sigma = 20;
v = sigma/(255*255);
im1 =imnoise(im1_o,'gaussian',0, v );
im2 =imnoise(im2_o,'gaussian',0, v );
im1=double(im1);
im2=double(im2);
[imgf5,~] = mainSRKSVD(im1,im2,Dksvd);
Result_K5 = Evaluation (im1_o,im2_o,imgf5,256);
clear sigma;
