function w = calculateW( x, y, lambda)
%calculateW 
%   INPUT
%       x - training set
%       y - result training set
%       lambda - used for ridge regression, othersiwe lambda=0
%   OUTPUT
%       w - weight
    if nargin < 3
        lambda=0;
    end
    w=(x'*x+size(x,2).*lambda.*eye(size(x,2)))\x'*y;

end

