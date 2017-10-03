function X_out = NorSvdDec(X)
X_out = X;
[h, m] = size(X);
t = sqrt(h/m);
for ind = 1:m 
    X_out(:,ind) = t * X_out(:,ind) / sqrt(X_out(:,ind)'*X_out(:,ind));
end

