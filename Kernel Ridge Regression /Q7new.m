%Q7

%initialize table for gamma and MSE train and test
gammaTable=zeros(200,3);

MSETrainTable=zeros(200,3);
MSETestTable=zeros(200,3);

for i=1:200
    
    w=randn(1,10);
    x=randn(600,10);
    n=randn(600,1);
    y=x*w'+n;
    x_training=x(1:100,:);
    x_test=x(101:600,:);
    y_training=y(1:100,:);
    y_test=y(101:600,:);
    
    %set value of temporary varibles to find minimum error over gamma
    minMSETrainingError=99999;
    minMSEValidationError=99999;
    minMSEKFoldError=99999;
    
    minMSETrainingErrorT=99999;
    minMSEValidationErrorT=99999;
    minMSEKFoldErrorT=99999;
    
    minGammaTraining=10000;
    minGammaValidation=10000;
    minGammaKFold=10000;
    
    for j=-6:3
        gamma=10^(j);
        %optimizing for training set
        w_predicted=calculateW(x_training,y_training,gamma);
        MSETraining=calculateMSERidge(x_training,y_training,w_predicted);
        if MSETraining<minMSETrainingError
            minMSETrainingError=MSETraining;
            minGammaTraining=gamma;
            minMSETrainingErrorT=calculateMSERidge(x_test,y_test,w_predicted);
            
        end
        %optmizing for 80% training set
        x_training_80=x_training(1:80,:);
        x_training_20=x_training(81:100,:);
        y_training_80=y_training(1:80,:);
        y_training_20=y_training(81:100,:);
        w_predicted=calculateW(x_training_80,y_training_80,gamma);
        MSEValidation=calculateMSERidge(x_training_80,y_training_80,w_predicted);
        if MSEValidation<minMSEValidationError
            minMSEValidationError=MSEValidation;
            minGammaValidation=gamma;
            minMSEValidationErrorT=calculateMSERidge(x_test,y_test,w_predicted);
        end
        
        %optimizing for cross-validation
        limit=20;

        averageMSEKFoldError=0;
        
        for k=1:5
            indexV=[k*limit-limit+1:k*limit];
            indexT=setdiff([1:100],indexV);
            V=x_training(indexV,:);
            T=x_training(indexT,:);

            yT=y_training(indexT);
            yV=y_training(indexV);
            w_predicted=calculateW(T,yT,gamma);
            
            averageMSEKFoldError=+calculateMSERidge(V,yV,w_predicted);
    
            
        end
        if averageMSEKFoldError/5 < minMSEKFoldError
            minMSEKFoldError=averageMSEKFoldError/5;
            minGammaKFold=gamma;
            minMSEKFoldErrorT=calculateMSERidge(x_test,y_test,w_predicted);
        end
        
        
    end
    
    %update tables based on minimum mse errors found and optmized gamma
    %used to find it
    gammaTable(i,1)=minGammaTraining;
    gammaTable(i,2)=minGammaValidation;
    gammaTable(i,3)=minGammaKFold;
    
    
    MSETrainTable(i,1)=minMSETrainingError;
    MSETrainTable(i,2)=minMSEValidationError;
    MSETrainTable(i,3)=minMSEKFoldError;

    MSETestTable(i,1)=minMSETrainingErrorT;
    MSETestTable(i,2)=minMSEValidationErrorT;
    MSETestTable(i,3)=minMSEKFoldErrorT;
    
end

mean(gammaTable);
MSETrain=mean(MSETrainTable);
stdtrain=std(MSETrainTable);
MSETest=mean(MSETestTable);
stdtest=std(MSETestTable);
fprintf('MSE Train Errors for 100 points\n')
fprintf('Training= %d  Validation= %d Cross-Validation= %d\n\n',[MSETrain(1),MSETrain(2),MSETrain(3)])
fprintf('Standard Deviation MSE Train Errors for 100 points\n')
fprintf('Training= %d  Validation= %d Cross-Validation= %d\n\n',[stdtrain(1),stdtrain(2),stdtrain(3)])
fprintf('MSE Test Errors for 100 points\n')
fprintf('Training= %d  Validation= %d Cross-Validation= %d\n\n',[MSETest(1),MSETest(2),MSETest(3)])
fprintf('Standard Deviation MSE Test Errors for 100 points\n')
fprintf('Training= %d  Validation= %d Cross-Validation= %d\n\n',[stdtest(1),stdtest(2),stdtest(3)])

%%
%Q7

%initialize table for gamma and MSE train and test
gammaTable=zeros(200,3);

MSETrainTable=zeros(200,3);
MSETestTable=zeros(200,3);

for i=1:200
    
    w=randn(1,10);
    x=randn(600,10);
    n=randn(600,1);
    y=x*w'+n;
    x_training=x(1:10,:);
    x_test=x(101:600,:);
    y_training=y(1:10,:);
    y_test=y(101:600,:);
    
    %set value of temporary varibles to find minimum error over gamma
    minMSETrainingError=99999;
    minMSEValidationError=99999;
    minMSEKFoldError=99999;

    minMSETrainingErrorT=99999;
    minMSEValidationErrorT=99999;
    minMSEKFoldErrorT=99999;
    
    minGammaTraining=10000;
    minGammaValidation=10000;
    minGammaKFold=10000;
    
    for j=-6:3
        gamma=10^(j);
        %optimizing for training set
        w_predicted=calculateW(x_training,y_training,gamma);
        MSETraining=calculateMSERidge(x_training,y_training,w_predicted);
        if MSETraining<minMSETrainingError
            minMSETrainingError=MSETraining;
            minGammaTraining=gamma;
            minMSETrainingErrorT=calculateMSERidge(x_test,y_test,w_predicted);
            
        end
        %optmizing for 80% training set
        x_training_80=x_training(1:8,:);
        x_training_20=x_training(9:10,:);
        y_training_80=y_training(1:8,:);
        y_training_20=y_training(9:10,:);
        w_predicted=calculateW(x_training_80,y_training_80,gamma);
        MSEValidation=calculateMSERidge(x_training_80,y_training_80,w_predicted);
        if MSEValidation<minMSEValidationError
            minMSEValidationError=MSEValidation;
            minGammaValidation=gamma;
            minMSEValidationErrorT=calculateMSERidge(x_test,y_test,w_predicted);
        end
        
        %optimizing for cross-validation
        limit=2;

        averageMSEKFoldError=0;
        
        for k=1:5
            indexV=[k*limit-limit+1:k*limit];
            indexT=setdiff([1:10],indexV);
            V=x_training(indexV,:);
            T=x_training(indexT,:);

            yT=y_training(indexT);
            yV=y_training(indexV);
            w_predicted=calculateW(T,yT,gamma);
            
            averageMSEKFoldError=+calculateMSERidge(V,yV,w_predicted);
    
            
        end
        if averageMSEKFoldError/5 < minMSEKFoldError
            minMSEKFoldError=averageMSEKFoldError/5;
            minGammaKFold=gamma;
            minMSEKFoldErrorT=calculateMSERidge(x_test,y_test,w_predicted);

        end
        
        
    end

    %update tables based on minimum mse errors found and optmized gamma
    %used to find it
    gammaTable(i,1)=minGammaTraining;
    gammaTable(i,2)=minGammaValidation;
    gammaTable(i,3)=minGammaKFold;
    
    MSETrainTable(i,1)=minMSETrainingError;
    MSETrainTable(i,2)=minMSEValidationError;
    MSETrainTable(i,3)=minMSEKFoldError;

    MSETestTable(i,1)=minMSETrainingErrorT;
    MSETestTable(i,2)=minMSEValidationErrorT;
    MSETestTable(i,3)=minMSEKFoldErrorT;
end

mean(gammaTable);
MSETrain=mean(MSETrainTable);
stdtrain=std(MSETrainTable);
MSETest=mean(MSETestTable);
stdtest=std(MSETestTable);
fprintf('MSE Train Errors for 10 points\n')
fprintf('Training= %d  Validation= %d Cross-Validation= %d\n\n',[MSETrain(1),MSETrain(2),MSETrain(3)])
fprintf('Standard Deviation MSE Train Errors for 10 points\n')
fprintf('Training= %d  Validation= %d Cross-Validation= %d\n\n',[stdtrain(1),stdtrain(2),stdtrain(3)])
fprintf('MSE Test Errors for 10 points\n')
fprintf('Training= %d  Validation= %d Cross-Validation= %d\n\n',[MSETest(1),MSETest(2),MSETest(3)])
fprintf('Standard Deviation MSE Test Errors for 10 points\n')
fprintf('Training= %d  Validation= %d Cross-Validation= %d\n\n',[stdtest(1),stdtest(2),stdtest(3)])