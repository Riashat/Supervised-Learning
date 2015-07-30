function [ MSETrain, MSETest ] = linearregressiontraining( xtrain,ytrain, xtest,ytest, gamma )
%linearregressiontraining 
%   calculate MSE train and test avoiding to repeat frequent calculations
%Input 
%xtrain - x training set
%ytrain - y training set
%xtest - x test set
%ytest - y test set
%gamma - ridge regression parameter ( default value equals to zero)
%Output
%MSETrain - MSE for the training set
%MSETest - MSE for the test set
    if nargin < 5
        gamma=0;
    end
    w=calculateW(xtrain, ytrain, gamma);
    MSETrain=calculateMSERidge(xtrain,ytrain,w);
    MSETest=calculateMSERidge(xtest,ytest,w);

end

