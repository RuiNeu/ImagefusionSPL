%close all;clear all;clc;
addpath(genpath('Evaluation'));
%% input two multi-focus images
[imagename1, imagepath1] = uigetfile('Focus\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
image_input1=imread(strcat(imagepath1,imagename1));
gray_image_input1 = rgb2gray(image_input1); %change rgb to gray,
[imagename2, imagepath2]=uigetfile('Focus\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
image_input2 = imread(strcat(imagepath2,imagename2));
gray_image_input2 = rgb2gray(image_input2); %change rgb to gray,

%% setting para
load(['LearnedOmega_adm64X49']) ;
x_cols = 7;

sigma = 0;
noise_gray_image_input1=double(gray_image_input1);
noise_gray_image_input2=double(gray_image_input2);
[imgf1,Result1] = mainFusionFunction(noise_gray_image_input1,noise_gray_image_input2,x_cols,Omega);
clear sigma;

sigma = 5;
v = sigma/(255*255);
noise_gray_image_input1 = imnoise(gray_image_input1,'gaussian',0, v );
noise_gray_image_input2 = imnoise(gray_image_input2,'gaussian',0, v );
noise_gray_image_input1 = double(noise_gray_image_input1);
noise_gray_image_input2 = double(noise_gray_image_input2);
[imgf2,Result2] = mainFusionFunction(noise_gray_image_input1,noise_gray_image_input2,x_cols,Omega);

clear sigma;

sigma = 10;
v = sigma/(255*255);
noise_gray_image_input1 = imnoise(gray_image_input1,'gaussian',0, v );
noise_gray_image_input2 = imnoise(gray_image_input2,'gaussian',0, v );
noise_gray_image_input1 = double(noise_gray_image_input1);
noise_gray_image_input2 = double(noise_gray_image_input2);
[imgf3,Result3] = mainFusionFunction(noise_gray_image_input1,noise_gray_image_input2,x_cols,Omega);

clear sigma;

sigma = 15;
v = sigma/(255*255);
noise_gray_image_input1 = imnoise(gray_image_input1,'gaussian',0, v );
noise_gray_image_input2 = imnoise(gray_image_input2,'gaussian',0, v );
noise_gray_image_input1 = double(noise_gray_image_input1);
noise_gray_image_input2 = double(noise_gray_image_input2);
[imgf4,Result4] = mainFusionFunction(noise_gray_image_input1,noise_gray_image_input2,x_cols,Omega);


sigma = 20;
v = sigma/(255*255);
noise_gray_image_input1 = imnoise(gray_image_input1,'gaussian',0, v );
noise_gray_image_input2 = imnoise(gray_image_input2,'gaussian',0, v );
noise_gray_image_input1 = double(noise_gray_image_input1);
noise_gray_image_input2 = double(noise_gray_image_input2);
[imgf5,Result5] = mainFusionFunction(noise_gray_image_input1,noise_gray_image_input2,x_cols,Omega);
clear sigma;



