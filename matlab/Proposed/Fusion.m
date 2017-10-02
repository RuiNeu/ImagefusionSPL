function X = Fusion(Y,Omega,lambda)
% Initialization for ADMM

[n,m] = size(Omega);
[m,l] = size(Y);
i = 100;
X = Y;
Z = Omega * X;
mu = lambda;  % ADMM Lagrange multiplier
Theta = zeros(n,l); % ADMM Lagrange multipliers
fast_sthresh = @(x,th) sign(x).*max(abs(x) - th,0);
T = inv(lambda*eye(m)+ mu*(Omega')*Omega);

while (norm(Z-Omega*X,'fro') >= .001)
    i
    X = T *(mu*Y + mu*Omega'*(Z-Theta));
    Z = fast_sthresh(Omega*X+Theta,1/mu);
    Theta = Theta - (Z-Omega*X);
    i = i+1;
end

