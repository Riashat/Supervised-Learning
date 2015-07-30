function mse = dualcost( K, y, a )
%dualcost
%   calculates MSE using the dual weigth vector
%Input
%K- kernel matrix (Kernel test matrix)
%y - test of y
%a - dual weigth vector
%Output
%mse - MSE test
    mse=(1/length(K)).*(K*a - y)'*(K*a - y);

end

