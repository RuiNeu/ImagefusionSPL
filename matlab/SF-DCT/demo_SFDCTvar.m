%clear all; clc;

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
pz = 9; 
sigma = 20;
if sigma > 0
    v = sigma /(255*255);
    im1 = imnoise(im1,'gaussian',0, v );
    im2 = imnoise(im2,'gaussian',0, v );
end

% Get input image size
[m,n] = size(im1);
fusedDct = zeros(m,n);

% Level shifting
im1 = double(im1)-128;
im2 = double(im2)-128;
cntMat = zeros(m,n);
imgf = zeros(m,n);

for i = 1:floor(m/pz)
    for j = 1:floor(n/pz)
        patch1 = im1(pz*i-(pz-1):pz*i,pz*j-(pz-1):pz*j);
        patch2 = im2(pz*i-(pz-1):pz*i,pz*j-(pz-1):pz*j);
        patch_1 = dct2(patch1);
        patch_2 = dct2(patch2);
        im1Norm = patch_1 ./ pz; %normalized
        im2Norm = patch_2 ./ pz;
        im1Var = sum(sum(im1Norm.^2));
        im2Var = sum(sum(im2Norm.^2));
        if im1Var > im2Var         % Fusion
            SFVar = patch_1;
        else
            SFVar = 0.5*(patch_1+patch_2);
        end
        %reconstruct fused image
        imgf(pz*i-(pz-1):pz*i,pz*j-(pz-1):pz*j) = idct2(SFVar);	
        cntMat(pz*i-(pz-1):pz*i,pz*j-(pz-1):pz*j)  = cntMat(pz*i-(pz-1):pz*i,pz*j-(pz-1):pz*j)  + 1;
    end
end
idx = (cntMat < 1);
imgf(idx) = (im1(idx)+im1(idx))./2;
cntMat(idx) = 1;
imgf = imgf./cntMat;

im1 = uint8(double(im1)+128);
im2 = uint8(double(im2)+128);
imgf = uint8(double(imgf)+128);
Result = Evaluation(im1,im2,imgf,256)
figure;imshow(imgf);
