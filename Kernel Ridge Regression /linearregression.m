function [ MSETrain, MSETest ] = linearregression( Train, Test )
%linearregression
%  designed for exercise 9, it takes a training set and test set and
%  returns two arrays, MSETrain and MSETest containing the MSE errors for
%  naive regression, for each column taken separately and for the whole
%  set.
%Input 
%Train - x and y training set
%Test - x and y test set
%Output
%MSETrain - array containg MSE train error naive regression, from column 2 to 14 regression
%for each dimension and at column 15 for the whole dataset
%MSETest - array containg MSE test error naive regression, from column 2 to 14 regression
%for each dimension and at column 15 for the whole dataset

MSETrain=zeros(15,1);
MSETest=zeros(15,1);

%vectors for the bias term
trainingOnes=ones(length(Train),1);
testOnes=ones(length(Test),1);
  
%naive regression
w=calculateW(trainingOnes,Train(:,14),0);
MSETrain(1)=calculateMSERidge(trainingOnes,Train(:,14),w,0);
MSETest(1)=calculateMSERidge(testOnes,Test(:,14),w,0);

%regression for each dimension (13 in total)
for dimension=1:13
    tmp_training=[Train(:,dimension) trainingOnes];
    tmp_test=[Test(:,dimension) testOnes];
    w=calculateW(tmp_training ,Train(:,14),0);

    MSETrain(dimension+1)=calculateMSERidge(tmp_training,Train(:,14),w,0);
    
    MSETest(dimension+1)=calculateMSERidge(tmp_test,Test(:,14),w,0);

end
%linear regression on all the dimensions
w=calculateW(Train(:,1:13),Train(:,14),0);
MSETrain(15)=calculateMSERidge(Train(:,1:13),Train(:,14),w,0);
MSETest(15)=calculateMSERidge(Test(:,1:13),Test(:,14),w,0);


end