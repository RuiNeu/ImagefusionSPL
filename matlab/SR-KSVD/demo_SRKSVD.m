clear all;close all;clc;

addpath(genpath('ksvdbox'));
addpath Evaluation;
addpath Focus;

[imagename1 imagepath1]=uigetfile('Focus\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
image_input1=imread(strcat(imagepath1,imagename1));  
gray_image_input1 = rgb2gray(image_input1); %change rgb to gray,
[imagename2 imagepath2]=uigetfile('Focus\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
image_input2=imread(strcat(imagepath2,imagename2));  
gray_image_input2 = rgb2gray(image_input2); %change rgb to gray,

%% setting parameters
sigma=0;
overlap = 1;                    
epsilon = 0.1;
load('LearnedD49X256.mat');

if sigma>0
    v = sigma/(255*255);
    gray_image_input1 = imnoise(gray_image_input1,'gaussian',0, v );
    gray_image_input2 = imnoise(gray_image_input2,'gaussian',0, v );
end

figure;imshow(gray_image_input1);
figure;imshow(gray_image_input2);

img1=double(gray_image_input1);
img2=double(gray_image_input2);

tic;
imgf = sparse_fusion(img1,img2,Dksvd,overlap,epsilon); %dictionary-ksvd
toc;

img1 = imresize(img1,size(imgf));
img2 = imresize(img2,size(imgf));
img1 = uint8(img1);
img2 = uint8(img2);
imgf = uint8(imgf);

Result_R1 = Evaluation(img1,img2,imgf,256);
figure;imshow(imgf,[]);


