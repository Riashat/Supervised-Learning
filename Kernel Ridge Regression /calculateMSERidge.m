function mse = calculateMSERidge( x,y, w, lambda )
%calculateMSERidge 
%   INPUT
%   x - training/test set
%   y - training/test set
%   w - predicted w using training set
%   lambda - used for ridge regression, 0 otherwise
%   OUTPUT
%   mse - mean squared error
    if nargin < 5
        lambda=0;
    end
    mse=(1/length(x)).*(w'*x'*x*w-2.*y'*x*w+y'*y)+lambda.*w'*w;


end

