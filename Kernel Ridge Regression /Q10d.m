%10 d
clear all
load('boston.mat');

loops=20;

limit=round(length(boston)/3);
MSETrainTable=zeros(16,loops);
MSETestTable=zeros(16,loops);

for i=1:loops
    %select random indexes from boston dataset
    randIndex=randperm(506);
    mixBoston=boston(randIndex,:);
    test=mixBoston(1:limit,:);
    train=mixBoston(limit+1:end,:);
    %call linear regression function to obtain array of MSE train and test
    %for naive regression, regression for each column and regression for 13
    %dimensions
    [MSEtrain, MSEtest]=linearregression(train,test);
    %store arrays
    MSETrainTable(1:15,i)=MSEtrain;
    MSETestTable(1:15,i)=MSEtest;
     %call kernel ridge regression function 
    [MSEtrain, MSEtestKernel,a,b,c]=kernelridgeregression(train,test);
    
    MSETrainTable(16,i)=MSEtrain;
    MSETestTable(16,i)=MSEtestKernel;
    
    
    
    
end
%display final table containing mean and standard deviation of MSE train
%and MSE test
[mean(MSETrainTable')' std(MSETrainTable')' mean(MSETestTable')' std(MSETestTable')']

