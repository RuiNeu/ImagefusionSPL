function imf = sparse_fusion(im1,im2,DKsvd,overlap,e)

norm_D = sqrt(sum(DKsvd.^2, 1)); % normalize the dictionary

DKsvd = DKsvd./repmat(norm_D, size(DKsvd, 1), 1);

pz = sqrt(size(DKsvd, 1));
[h,w]=size(im1);
imf=zeros(h,w);
cntMat=zeros(h,w);

gridx = 1:pz - overlap : w-pz+1;
gridy = 1:pz - overlap : h-pz+1;

DD = DKsvd'*DKsvd;
for ii = 1:length(gridx)
    for jj = 1:length(gridy)
        xx = gridx(ii);
        yy = gridy(jj);
        imsub_1 = im1(yy:yy+pz-1, xx:xx+pz-1);
        mean1 = mean(imsub_1(:));
        imsub1 = imsub_1(:) - mean1;
        imsub_2 = im2(yy:yy+pz-1, xx:xx+pz-1);
        mean2 = mean(imsub_2(:));
        imsub2 = imsub_2(:) - mean2;
        w1 = omp2(DKsvd,imsub1,DD,e);
        w2 = omp2(DKsvd,imsub2,DD,e);
        w = w1;
        if sum(abs(w1))<sum(abs(w2)) %fusion
            w = w2;
        end
        mean_f = (mean1+mean2)/2;
        patch_f = DKsvd * w;
        Patch_f = reshape(patch_f, [pz, pz]);
        Patch_f = Patch_f + mean_f;
        imf(yy:yy+pz-1, xx:xx+pz-1) = imf(yy:yy+pz-1, xx:xx+pz-1) + Patch_f;
        cntMat(yy:yy+pz-1, xx:xx+pz-1) = cntMat(yy:yy+pz-1, xx:xx+pz-1) + 1;
    end
end
idx = (cntMat < 1);
imf(idx) = (im1(idx)+im2(idx))./2;
cntMat(idx) = 1;
imf = imf./cntMat;


