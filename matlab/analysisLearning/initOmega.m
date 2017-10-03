function O_out = initO_out(X,rows)
O_out = zeros(rows,size(X,1));
d = size(X,1)-2;
for i=1:rows
    sel = randperm(length(X));
    O_out(i,:) = null([X(:,sel(1:d))';ones(1,size(X,1))])';
end