function [Xout] = ADMM(Y,X,Omega,lambda,iter)

gamma = lambda; 
D = zeros(size(Omega,1),size(X,2));   
V = Omega*X; % Parameter Splitting
fast_sthresh = @(x,th) sign(x).*max(abs(x) - th,0);
t = 1;
fast_sthresh = @(x,th) sign(x).*max(abs(x) - th,0);
while (t <= 5) || (norm(V-Omega*X,'fro') >= .001) && (t <= iter)
    X = (lambda*Y + gamma*Omega'*(V-D))/(lambda+gamma);
    Z = fast_sthresh(Omega*X+D,1/gamma);
    D = D - (V-Omega*X); % Updating the Lagrange parameter of ADMM
    t = t + 1;
end
Xout = X;