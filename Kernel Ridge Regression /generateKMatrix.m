function KMatrix = generateKMatrix(test, train, o )
%generateKMatrix
%   it gets the training set and test set (sometimes it can be only train)
%   and calculates a kernel matrix using the gaussian kernel for every
%   pair of x.
%Input
%test - x test set
%train - x training set
%o - sigma used for the gaussian kernel
%Output
%KMatrix - kernel matrix calculated for sets inputted
    for i=1:length(test)
        for j=1:length(train)
            KMatrix(i,j)=kernel(test(i,1:13), train(j,1:13), o);
        end
    end

end

