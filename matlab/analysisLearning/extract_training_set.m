function [X] = extract_training_set(S, n, sz)

if isscalar(sz) && min(size(S)) > 1
    sz = [sz,sz];
end

patches = im2col(S,sz,'sliding');

patches_ext = bsxfun(@minus,patches,mean(patches));
patches_ext = bsxfun(@times,patches_ext,1./sqrt(sum(patches_ext.^2)));
patches(:,isnan(1./sum(patches_ext)))=[];
%patches_ext(:,isnan(1./sum(patches_ext)))=[];
p = 1:size(patches,2);
sel = randperm(numel(p));
X = patches(:,p(sel(1:min(end,n))));



