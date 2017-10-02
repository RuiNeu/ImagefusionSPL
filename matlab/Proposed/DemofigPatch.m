%close all;clear all;clc;

addpath(genpath('Evaluation'));
addpath Focus


%% setting
sigma = 0;

%% input two multi-focus images
[imagename1, imagepath1] = uigetfile('Focus\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
image_input1=imread(strcat(imagepath1,imagename1));
gray_image_input1 = rgb2gray(image_input1); %change rgb to gray,
[imagename2, imagepath2]=uigetfile('Focus\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
image_input2 = imread(strcat(imagepath2,imagename2));
gray_image_input2 = rgb2gray(image_input2); %change rgb to gray,

if size(gray_image_input1)~=size(gray_image_input2)
    error('two images are not the same size.');
end

if sigma>0
    v = sigma/(255*255);
    noise_gray_image_input1 = imnoise(gray_image_input1,'gaussian',0, v );
    noise_gray_image_input2 = imnoise(gray_image_input2,'gaussian',0, v );
else
    noise_gray_image_input1 = gray_image_input1;
    noise_gray_image_input2 = gray_image_input2;
end

noise_gray_image_input1=double(noise_gray_image_input1);
noise_gray_image_input2=double(noise_gray_image_input2);

i = 0;
while(i < 6)
    i = i+1;
    if (i == 1)
        x_cols = 5; %patch size
        load(['LearnedOmega_adm64X25']) ; %load Omega
        [imgf1,Result1] = mainFusionFunction(noise_gray_image_input1,noise_gray_image_input2,x_cols,Omega);
        clear Omega;
    end
    if (i == 2)
        clf;
        x_cols = 6;
        load(['LearnedOmega_adm64X36']) ;
        [imgf2,Result2] = mainFusionFunction(noise_gray_image_input1,noise_gray_image_input2,x_cols,Omega);
        clear Omega;
    end
    if (i == 3)
        x_cols = 7;
        load(['LearnedOmega_adm64X49']) ;
        [imgf3,Result3] = mainFusionFunction(noise_gray_image_input1,noise_gray_image_input2,x_cols,Omega);
        clear Omega;
    end
    if (i == 4)
        x_cols = 8;
        load(['LearnedOmega_adm64X64']) ;
        [imgf4,Result4] = mainFusionFunction(noise_gray_image_input1,noise_gray_image_input2,x_cols,Omega);
        clear Omega;
    end
    if (i == 5)
        x_cols = 9;
        load(['LearnedOmega_adm64X81']) ;
        [imgf5,Result5] = mainFusionFunction(noise_gray_image_input1,noise_gray_image_input2,x_cols,Omega);
        clear Omega;
    end
end


