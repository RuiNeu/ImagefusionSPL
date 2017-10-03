%close all;clear all;clc;
addpath Evaluation;
addpath Focus;
%% input two multi-focus images
[imagename1, imagepath1] = uigetfile('Focus\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
im1_o=imread(strcat(imagepath1,imagename1));
[imagename2, imagepath2]=uigetfile('Focus\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
im2_o = imread(strcat(imagepath2,imagename2));

if size(im1_o,3) == 3
    im1_o = rgb2gray(im1_o);
end
if size(im2_o,3) == 3
    im2_o = rgb2gray(im2_o);
end

pz = 7;

sigma = 0;
im1=double(im1_o);
im2=double(im2_o);
[imgf1,~] = mainSFDCTvar(im1,im2,pz);
Result_R1 = Evaluation (im1_o,im2_o,imgf1,256);

sigma = 5;
v = sigma/(255*255);
im1 =imnoise(im1_o,'gaussian',0, v );
im2 =imnoise(im2_o,'gaussian',0, v );
im1=double(im1);
im2=double(im2);
[imgf2,~] = mainSFDCTvar(im1,im2,pz);
Result_R2 = Evaluation (im1_o,im2_o,imgf2,256);
clear sigma;

sigma = 10;
v = sigma/(255*255);
im1 =imnoise(im1_o,'gaussian',0, v );
im2 =imnoise(im2_o,'gaussian',0, v );
im1=double(im1);
im2=double(im2);
[imgf3,~] = mainSFDCTvar(im1,im2,pz);
Result_R3 = Evaluation (im1_o,im2_o,imgf3,256);
clear sigma;

sigma = 15;
v = sigma/(255*255);
im1 =imnoise(im1_o,'gaussian',0, v );
im2 =imnoise(im2_o,'gaussian',0, v );
im1=double(im1);
im2=double(im2);
[imgf4,~] = mainSFDCTvar(im1,im2,pz);
Result_R4 = Evaluation (im1_o,im2_o,imgf4,256);
clear sigma;

sigma = 20;
v = sigma/(255*255);
im1 =imnoise(im1_o,'gaussian',0, v );
im2 =imnoise(im2_o,'gaussian',0, v );
im1 = double(im1);
im2 = double(im2);
[imgf5,~] = mainSFDCTvar(im1,im2,pz);
Result_R5 = Evaluation (im1_o,im2_o,imgf5,256);
clear sigma;
