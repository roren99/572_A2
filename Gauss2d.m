% GAUSS2D 2-D Gaussian pdf
%
% INPUTS:
% x1 - 1xN vector - range of x1 component
% x2 - 1xM vector - range of x2 component
% Mu - 2x1 vector - the mean of the random variable
% Sigma - 2x2 matrix - the variance matrix of
% the random variable
%
% OUTPUT:
% Y - NxM matrix - the pdf for the range of x1, x2
%
% USAGE (Example):
% Y = Gauss2d([-3:0.1:3],[0:0.1:6],[0 3]',[1 1; 1 4])
% This function creates the pdf for a 2D Gaussian
% random variable

function Y = Gauss2d(x1, x2, Mu, Sigma)
    Y = zeros(numel(x1), numel(x2));
    for ii=1:numel(x1)
        for jj=1:numel(x2)
            v = [x1(ii) x2(jj)]';
            Y(ii, jj) = exp(-0.5*(v - Mu)'*inv(Sigma)*(v - Mu))/(2*pi*sqrt(det(Sigma)));
        end
    end
end