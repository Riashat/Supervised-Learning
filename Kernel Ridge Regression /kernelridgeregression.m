function [MSEtrain, MSEtest, crossValidationErrorTable, averageBestSigma, averageBestGamma]= kernelridgeregression( Train, Test )
%kernelridgeregression - uses gaussian kernel for ridge regression
%   INPUT
%      Train - training set including y
%      Test - test set including y
%OUTPUT
% MSETrain - MSE train found with the averages of best sigma and gamma
% MSETest - MSE test found with averages of best sigma and gamma
%crossValidationError -  average cross validation error for fix sigma and
%variable gamma
%averageBestSigma - averaged best sigma for smallest MSE test using cross
%validation
%averageBestGamma - averaged best gamma for smallest MSE test using cross
%validation

%initialize gamma and sigma
gamma=power(2.*ones(1,length([-40:1:-26])), [-40:1:-26]);
sigma=power(2.*ones(1,length([7:0.5:13])), [7:0.5:13]);

%generate matrices
smallestErrorPair=zeros(5,3);
crossValidationErrorTable=zeros(length(sigma),length(gamma));

%split dataset into x and y
yTrain=Train(:,14);

Train=Train(:,1:13);
yTest=Test(:,14);
Test=Test(:,1:13);

limit=round(length(Train)/5);
%loop k-fold times (5)
for kfold=1:5
    fprintf('Calculating for k %i\n',kfold)

    %select validation set
    indexV=[kfold*limit-limit+1:kfold*limit];
    %use setdiff to set train set for cross validation
    indexT=setdiff([1:length(Train)],indexV);
    V=Train(indexV,:);
    T=Train(indexT,:);

    yT=yTrain(indexT);
    yV=yTrain(indexV);
    %set value for temporary variables to find optimum value for gamma and
    %sigma
    tmpMinMSE=10^3;
    minSigma=0;
    minGamma=0;
    %loop through the sigma array
    for i=1:length(sigma)
        %generate Kernel Matrix for test set, KTest=K(test, train)
        KTest=generateKMatrix(V,T,sigma(i));
        %generate Kernel Matrix for train set
        gramMatrix=generateKMatrix(T,T,sigma(i));
        %loop through the gamma array
        for j=1:length(gamma)
            %find a
            a=kridgereg(gramMatrix, yT, gamma(j));
            %find MSE test
            tmpMSE=dualcost(KTest, yV, a);
            if tmpMSE<tmpMinMSE
                tmpMinMSE=tmpMSE;
                minSigma=sigma(i);
                minGamma=gamma(j);
            end
            crossValidationErrorTable(i,j)=crossValidationErrorTable(i,j)+tmpMSE;
        end
        
    end
    smallestErrorPair(kfold,1)=tmpMinMSE;
    smallestErrorPair(kfold,2)=minSigma;
    smallestErrorPair(kfold,3)=minGamma;
    
    fprintf('Minimum MSE obtained was %d with gamma equals to %d and sigma equals to %d\n\n',[tmpMinMSE,minGamma,minSigma])
end

crossValidationErrorTable=crossValidationErrorTable./5;


averageBestGamma=mean(smallestErrorPair(:,3));
averageBestSigma=mean(smallestErrorPair(:,2));


%recalculate Kernel Matrices with averaged best sigma
KTrain=generateKMatrix(Train,Train,averageBestSigma);
KTest=generateKMatrix(Test,Train,averageBestSigma);
%calculate a using optimized gamma
a=kridgereg(KTrain, yTrain, averageBestGamma);
MSEtrain=dualcost(KTrain, yTrain, a);
MSEtest=dualcost(KTest, yTest, a);

end

