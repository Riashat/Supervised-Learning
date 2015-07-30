function a = kridgereg( K, y, gamma )
%kridgereg 
%Input
%K - kernel (gaussina kernel in this case)
%y - y set
%gamma - ridge regression parameter
%Output
%a - dual weight vector
    a=(K + gamma.*length(K).*eye(length(K)))\y;

end




