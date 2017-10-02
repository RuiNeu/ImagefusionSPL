function[imgf,Result] = mainSFDCTvar(im1,im2,pz)

[m,n] = size(im1);
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
        im1Norm = patch_1 ./ pz;
        im2Norm = patch_2 ./ pz;
        im1Var = sum(sum(im1Norm.^2)); 
        im2Var = sum(sum(im2Norm.^2));
        if im1Var > im2Var  
            SFVar = patch_1;
        else
            SFVar = 0.5*(patch_1+patch_2);
        end
        imgf(pz*i-(pz-1):pz*i,pz*j-(pz-1):pz*j) = idct2(SFVar);	% DCT+Variance method
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
