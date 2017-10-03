function O_out= OmegaUpdate(X,O,t)
% O = analysis operator
% t : Initial stepsize
k = 1;
countStep = 0;
e = 0;
iter = 100; 
e_cost(1) = f(O,X);
while (k <= iter)&& ( e~=1 )
    GradientV = sign(O*X) * X';
    O_t = O - t * GradientV;
    O_t = svdDec(O_t')';
    O_t = NorSvdDec(O_t')';
    obj = f(O_t,X);  % objective fucntion
    if obj < e_cost(k)
        e_cost( k + 1) = obj;
        O = O_t;
        countStep = 0;
        k = k + 1;
    else
        t = t / 1.5; 
        countStep = countStep + 1;
        if countStep >= 8, e = 1; end 
    end
end
O_out = svdDec(O')';

function obj = f(O,X)
obj = sum(sum(abs(O*X)));
