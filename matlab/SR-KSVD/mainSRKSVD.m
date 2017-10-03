function [imgf,Result] = mainSRKSVD(img1,img2,Dksvd)

overlap = 1;                    
epsilon = 0.1;

tic;
imgf = sparse_fusion(img1,img2,Dksvd,overlap,epsilon); %Dksvd
toc;

img1 = uint8(img1);
img2 = uint8(img2);
imgf = uint8(imgf);

Result = Evaluation (img1,img2,imgf,256)

