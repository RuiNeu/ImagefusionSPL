function [Xout] = ADMM(Y,X,Omega,gamma,iter)

D = zeros(size(Omega,1),size(X,2));   
V = Omega*X; % Parameter Splitting
fast_sthresh = @(x,th) sign(x).*max(abs(x) - th,0);
t = 1;
fast_sthresh = @(x,th) sign(x).*max(abs(x) - th,0);
while (norm(V-Omega*X,'fro') >= .001) && (t <= iter)
    X = (lambda*Y + gamma*Omega'*(V-D))/(lambda+gamma);  % admm code
    Z = fast_sthresh(Omega*X+D,1/gamma);
    D = D - (V-Omega*X); 
    t = t + 1;
end
Xout = X;
