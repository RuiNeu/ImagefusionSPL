close all;clear all;clc;

addpath Evaluation;
addpath Focus;

%% setting parameters
x_cols = 7; %patch size
load(['LearnedOmega_adm64X49']) ; %different Omega with different patch size.
sigma = 0;  % noise setting

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

figure;imshow(noise_gray_image_input1);
figure;imshow(noise_gray_image_input2);

img1 = double(noise_gray_image_input1);
img2 = double(noise_gray_image_input2);

overlap = 1;
epsilon = 0.1;

lambda = 0.01;
%% patch sampling
[m, n] = size(img1);
imgf = zeros([m,n]);
cntMat = zeros([m,n]);

gridx = 1:x_cols - overlap : m - x_cols+1;
gridy = 1:x_cols - overlap : n - x_cols+1;

tic;
for ii = 1:length(gridx)
    for jj = 1:length(gridy)
        xx = gridx(ii);
        yy = gridy(jj);      
        patch_1 = img1(yy:yy+x_cols-1, xx:xx+x_cols-1);
        mean1 = mean(patch_1(:));
        patch1 = patch_1(:) - mean1;
        patch_2 = img2(yy:yy+x_cols-1, xx:xx+x_cols-1);
        mean2 = mean(patch_2(:));
        patch2 = patch_2(:) - mean2;
        w1 =  Omega * patch1; 
        w2 =  Omega * patch2;
        mean_f = mean1;
        patch_f = patch1;
        if sum(abs(w1))<sum(abs(w2)) % patch fusion
            w = w2;
            mean_f = mean2;
            patch_f = patch2;
        end
        Patch_f = reshape(patch_f, [x_cols, x_cols]);
        Patch_f = Patch_f + mean_f;   
        imgf(yy:yy+x_cols-1, xx:xx+x_cols-1) = imgf(yy:yy+x_cols-1, xx:xx+x_cols-1) + Patch_f;
        cntMat(yy:yy+x_cols-1, xx:xx+x_cols-1) = cntMat(yy:yy+x_cols-1, xx:xx+x_cols-1) + 1;
    end
end

idx = (cntMat < 1);
imgf(idx) = (img1(idx) + img2(idx))./2;
cntMat(idx) = 1;

imgf = imgf./cntMat;
toc;

%% global optimization
O_size = 49; %expand the size of Omega
O_number = 10;
Omega_patch = imresize(Omega,[O_size,O_size]); 
Big_Omega = zeros([O_size * O_number,O_size * O_number]); %global analysis operator
[om,on] = size(Big_Omega);
imgf = imresize(imgf,size(Big_Omega)); 
for i = 1:O_number
    for j = 1:O_number
        O_start=1+(i-1)*fix(om/O_number);
        O_end=i*fix(om/O_number);
        O_start=1+(j-1)*fix(on/O_number);
        O_end=j*fix(on/O_number);
        Big_Omega(O_start:O_end,O_start:O_end,:) = Omega_patch;
    end
end

imgf_O = imgf; 
imgf = Fusion(imgf_O,Big_Omega,lambda); %global Reconstruction by ADMM
toc;

img1 = imresize(img1,size(imgf)); 
img2 = imresize(img2,size(imgf));
img1 = uint8(img1);
img2 = uint8(img2);
imgf = uint8(imgf);

figure;imshow(imgf,[]);
Result = Evaluation(img1,img2,imgf,255);
%imwrite(imgf,'./FusionResult/dog.tif'); 
