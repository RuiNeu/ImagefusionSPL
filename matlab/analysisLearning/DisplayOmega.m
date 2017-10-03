function [OmegaDisp] = DisplayOmega(Omega,h)
%DisplayOmega displays the analysis dictionary.
%  [OmegaDisp] = DisplayOmega(Omega,h)
%  ========================================================================
%  Input:
%  Omega - analysis dictionary. 
%
%  Optional input:
%  h - figure handle.
%  ========================================================================
%  Output:
%  OmegaDisp - matrix used for displaying the analysis dictionary.
%  ========================================================================
%  Tomer Peleg
%  Department of Electrical Engineering
%  Technion, Haifa 32000 Israel
%  tomerfa@tx.technion.ac.il
%
%  October 2012
%  ========================================================================
if nargin<2
    h=figure;
end
[p,d]=size(Omega);
n=round(sqrt(d));
N1=n;
N2=ceil(p/n);
count=1; 
a=min(Omega(:));
b=max(Omega(:));
Omega=[Omega;zeros(N1*N2-p,d)];
IMAGE=a*ones(1,1+(n+1)*N1); 
for k=1:N2
    ROW=a*ones(n,1); 
    for j=1:N1
        ROW=[ROW, reshape(Omega(count,:),[n,n]), a*ones(n,1)];
        count=count+1;
    end
    IMAGE=[IMAGE; ROW; a*ones(1,1+(n+1)*N1)];
end
OmegaDisp=(IMAGE-a)/(b-a);
figure(h), clf; 
image(OmegaDisp*255); axis image; axis off; colormap(gray(256));