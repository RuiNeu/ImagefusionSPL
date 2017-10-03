clear;clc;close all;

addpath training;

%% setting parameters
Pat_wd = 7; % patches of size n-by-n
Dim = 64; % target subspace dimension
iter = 100; 
Max_iter = 500; %set small number for testing
Patch_hei = 8;
lambda =0.01; 
n_patches= 10000; % the number of training patches
%%
x_rws = Pat_wd; %traning patch size
x_cls = Patch_hei;
clear Images;
ImageN = 't4_gray.png';
Strain{1} = '.\training\'; %training set
Strain{2} = ImageN;

%% sampling for natural images
Y = TrainSet(Strain, n_patches, x_rws);
Y = (eye(x_rws^2)-1/x_rws^2*ones(x_rws^2))*Y;
Y = bsxfun(@times,Y,1./(sqrt(sum(Y.^2))));
Y (:,isnan(1./sum(Y))) = [];
Y = unique(Y','rows')';

disp(['Number of examples: ',num2str(size(Y,2))]);

Omega = [];
Init_O = initOmega(Y, Dim);
Omega = [Omega;Init_O];
Omega = bsxfun(@times,Omega,1./sqrt(sum(Omega.^2,2)));

X = Y;  %Initialization
st = 0.01; %Step Size 

%% learning
for t = 1 : Max_iter 
    Omega = OmegaUpdate(X, Omega, st);     % Omega-analysis operator update
    SX = ADMM(Y, X, Omega, lambda, iter);  %cosparse signal updating
end

%% display
h1 = figure;
OmegaDisp=DisplayOmega(Omega,h1); %reference function

