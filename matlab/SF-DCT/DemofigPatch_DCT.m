%close all;clear all;clc;
addpath Evaluation;
addpath Focus;
[imagename1, imagepath1] = uigetfile('Focus\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
im1=imread(strcat(imagepath1,imagename1));
[imagename2, imagepath2]=uigetfile('Focus\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
im2 = imread(strcat(imagepath2,imagename2));

% Check if the images are grayscale
if size(im1,3) == 3     
    im1 = rgb2gray(im1);
end
if size(im2,3) == 3
    im2 = rgb2gray(im2);
end

if size(im1) ~= size(im2)	% Check if the input images are of the same size
    error('Size of the source images must be the same!');
end

%% setting noise cases
sigma = 0;
if sigma > 0
    v = sigma/(255*255);
    im1 =imnoise(im1,'gaussian',0, v );
    im2 =imnoise(im2,'gaussian',0, v );
end

im1=double(im1); im2=double(im2);
i = 0;
while( i < 6)
    i = i+1;
    if(i==1)
        pz = 5;
        [imgf1,Result_R1] = mainSFDCTvar(im1,im2,pz);
    end
     if(i==2)
        pz = 6;
        [imgf2,Result_R2] = mainSFDCTvar(im1,im2,pz);
     end
     if(i==3)
        pz = 7;
        [imgf3,Result_R3] = mainSFDCTvar(im1,im2,pz);
     end
     if(i==4)
        pz = 8;
        [imgf4,Result_R4] = mainSFDCTvar(im1,im2,pz);
     end
     if(i==5)
        pz = 9;
        [imgf5,Result_R5] = mainSFDCTvar(im1,im2,pz);
    end
end
