%Q5
%a i

clear all

%setup initial values
MSETrainTable100=zeros(200,10);
MSETestTable100=zeros(200,10);

MSETrainTable10=zeros(200,10);
MSETestTable10=zeros(200,10);

MSEValidationTable100=zeros(200,10);
MSEValidationTable10=zeros(200,10);

%store best gamma for 100 and 10 traininf set for each loop
GammaTable=zeros(200,2);

%start looping 200 times
for j=1:200    
    %generate dataset
    w=randn(1,10);
    x=randn(600,10);
    n=randn(600,1);
    y=x*w'+n;
    %separate 100 and 10 training sets and validation sets
    x_training=x(1:100,1:10);
    x_training_10=x(1:10,1:10);
    T100=x_training(1:80,1:10);
    V100=x_training(81:100,1:10);
    T10=x_training(1:8,1:10);
    V10=x_training(9:10,1:10);
    x_test=x(101:600,1:10);
    
    y_training=y(1:100,1);
    y_training_10=x(1:10,1);
    yT100=y_training(1:80,1);
    yV100=y_training(81:100,1);
    yT10=y_training(1:8,1);
    yV10=y_training(9:10,1);
    y_test=y(101:600,1);
    %loop through each gamma
    for i=-6:3
        gamma=10^(i);
        
        [mse_training, mse_test]=linearregressiontraining(x_training,y_training,x_test,y_test,gamma);

        [mse_training_10, mse_test_10]=linearregressiontraining(x_training_10,y_training_10,x_test,y_test,gamma);
        
        [mse_train_v, mse_test_v]=linearregressiontraining(T100,yT100,V100,yV100,gamma);
        
        [mse_train_v10, mse_test_v10]=linearregressiontraining(T10,yT10,V10,yV10,gamma);
        %store mse errors
        MSETrainTable100(j,i+7)=mse_training;
        MSETrainTable10(j,i+7)=mse_training_10;
        MSETestTable100(j,i+7)=mse_test;
        MSETestTable10(j,i+7)=mse_test_10;

        MSEValidationTable100(j,i+7)=mse_test_v;
        MSEValidationTable10(j,i+7)=mse_test_v10;
        
    end
    
    %find best gamma 
    lineGamma100=MSEValidationTable100(j,:);
    lineGamma10=MSEValidationTable10(j,:);
    %find position of best gamma based on index of where there is the
    %smallest validation error
    [r,c]=find(lineGamma100==min(min(lineGamma100)));
    %derive gamma based on index of minimum MSE validation
    gamma100=10^(c-7);
    [r,c]=find(lineGamma10==min(min(lineGamma10)));
    gamma10=10^(c-7);
    GammaTable(j,1)=gamma100;
    GammaTable(j,2)=gamma10;


end

meanTrain100=mean(MSETrainTable100);
meanTrain10=mean(MSETrainTable10);

meanTest100=mean(MSETestTable100);
meanTest10=mean(MSETestTable10);

meanValidation100=mean(MSEValidationTable100);
meanValidation10=mean(MSEValidationTable10);

meanGamma=mean(GammaTable);

figure(5)
plot([-6:3],meanTrain100,[-6:3],meanTest100,[-6:3],meanValidation100)
title('Q5  -Average MSE with Ridge Regression for 200 loops (100 Training points)')
ylabel('MSE')
xlabel('Log10(gamma)')
legend('MSE Training','MSE Test', 'MSE Training Validation')
grid on



figure(6)
plot([-6:3],meanTrain10,[-6:3],meanTest10,[-6:3],meanValidation10)
title('Q5  -Average MSE with Ridge Regression for 200 loops (10 Training points)')
ylabel('MSE')
xlabel('Log10(gamma)')
legend('MSE Training','MSE Test', 'MSE Training Validation')
grid on

meanGamma100=meanGamma(1);
meanGamma10=meanGamma(2);
fprintf('mean gamma for 100 = %d mean gamma for 10= %d\n\n',[meanGamma100,meanGamma10])


%find best MSE error based on average of optimized gamma for 100 and 10
%training sets
[bestmse100train, bestmse100test]=linearregressiontraining(x_training,y_training,x_test,y_test,meanGamma100);
[bestmse10train, bestmse10test]=linearregressiontraining(x_training_10,y_training_10,x_test,y_test,meanGamma10);

fprintf('100 points using average gamma - MSE Train = %d MSE Test= %d\n\n',[bestmse100train,bestmse100test])
fprintf('10 points using average gamma - MSE Train = %d MSE Test= %d\n\n',[bestmse10train,bestmse10test])
