function O_out = svdDec(Omega)
[U,S,L] = svd(Omega);
O_out = U * eye(size(S))* L';
