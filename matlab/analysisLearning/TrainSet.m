function Z = TrainSet(Img, n_pt, Pat_size)
Z = [];
Imglist = dir(Img{1});
Imgnames = {};
k = 0;
for i=1:numel(Imglist)
    if ~Imglist(i).isdir && ~strcmp(Imglist(i).name,'Thumbs.db') && ~strcmp(Imglist(i).name, Img{2})
        k = k + 1;
        Imgnames{k} = [Img{1},Imglist(i).name];
    end
end
n_pt = ceil(n_pt/k);
for i = 1:k
    Im = imread(Imgnames{i});
    if ndims(Im) == 3
        Im = rgb2gray(Im);
    end
    Im = double(Im);
    [Sc] = extract_training_set(Im, n_pt, Pat_size);
    Z = [Z,Sc];
end
end