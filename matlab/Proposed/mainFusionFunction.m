function [imgf,Result] = mainFusionFunction(img1,img2,x_cols,Omega)

overlap = 1;
lambda = 0.1;

[m, n, l] = size(img1);
imgf = zeros([m,n,l]);
cntMat = zeros([m,n,l]);
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
        w = w1;
        mean_f = mean1;
        patch_f = patch1;
        if sum(abs(w1))<sum(abs(w2))
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

O_size = 49;
O_number = 10;
Omega_patch = imresize(Omega,[O_size,O_size]);
Big_Omega = zeros([O_size * O_number,O_size * O_number]);
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
imgf = Fusion(imgf_O,Big_Omega,lambda); 
toc;

img1 = imresize(img1,size(Big_Omega));
img2 = imresize(img2,size(Big_Omega));
img1 = uint8(img1);
img2 = uint8(img2);
imgf = uint8(imgf);

Result = Evaluation(img1,img2,imgf,256)

