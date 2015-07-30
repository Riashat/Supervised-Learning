% Q4
clear all
%initialize tables to store errors
MSETrainTable100=zeros(10,1);
MSETestTable100=zeros(10,1);

MSETrainTable10=zeros(10,1);
MSETestTable10=zeros(10,1);

%generate dataset
    w=randn(1,10);
    x=randn(600,10);
    n=randn(600,1);
    y=x*w'+n;
    x_training=x(1:100,:);
    y_training=y(1:100,:);
    
    x_training_10=x(1:10,:);
    y_training_10=y(1:10,:);
    
    x_test=x(101:600,:);
    y_test=y(101:600,:);

    %loop for each gamma
    for i=-6:3
        gamma=10^(i);
        %calculate error with specific gamma
        [mse_training, mse_test]=linearregressiontraining(x_training,y_training,x_test,y_test,gamma);

        [mse_training_10, mse_test_10]=linearregressiontraining(x_training_10,y_training_10,x_test,y_test,gamma);
        %store training and test error 
        MSETrainTable100(i+7)=mse_training;
        MSETrainTable10(i+7)=mse_training_10;
        MSETestTable100(i+7)=mse_test;
        MSETestTable10(i+7)=mse_test_10;
        
    end

figure(1)
plot([-6:3],MSETrainTable100,[-6:3],MSETestTable100)
title('Q4a - MSE with Ridge Regression (100 Training points)')
ylabel('MSE')
xlabel('Log10(gamma)')
legend('MSE Training','MSE Test')
grid on

figure(2)
plot([-6:3],MSETrainTable10,[-6:3],MSETestTable10)
title('Q4a - MSE with Ridge Regression (10 Training points)')
ylabel('MSE')
xlabel('Log10(gamma)')
legend('MSE Training','MSE Test')
grid on

[[-6:3]' MSETrainTable100 MSETestTable100]

[[-6:3]' MSETrainTable100 MSETestTable100]
%%
clear all
%b

%initialize tables to store errors

MSETrainTable100=zeros(200,10);
MSETestTable100=zeros(200,10);

MSETrainTable10=zeros(200,10);
MSETestTable10=zeros(200,10);
%loop for 200 times
for j=1:200
    %generate dataset
    w=randn(1,10);
    x=randn(600,10);
    n=randn(600,1);
    y=x*w'+n;
    x_training=x(1:100,:);
    y_training=y(1:100,:);
    
    x_training_10=x(1:10,:);
    y_training_10=y(1:10,:);
    
    x_test=x(101:600,:);
    y_test=y(101:600,:);
    %loop for each gamma
    for i=-6:3
        gamma=10^(i);
        [mse_training, mse_test]=linearregressiontraining(x_training,y_training,x_test,y_test,gamma);

        [mse_training_10, mse_test_10]=linearregressiontraining(x_training_10,y_training_10,x_test,y_test,gamma);
        %store value of the error    
        MSETrainTable100(j,i+7)=mse_training;
        MSETrainTable10(j,i+7)=mse_training_10;
        MSETestTable100(j,i+7)=mse_test;
        MSETestTable10(j,i+7)=mse_test_10;
        
    end

end

%find the mean
meanTrain100=mean(MSETrainTable100);
meanTrain10=mean(MSETrainTable10);

meanTest100=mean(MSETestTable100);
meanTest10=mean(MSETestTable10);

figure(3)
plot([-6:3],meanTrain100,[-6:3],meanTest100)
title('Q4b - MSE with Ridge Regression (100 Training points)')
ylabel('Average MSE')
xlabel('Log10(gamma)')
legend('MSE Training','MSE Test')
grid on

figure(4)
plot([-6:3],meanTrain10,[-6:3],meanTest10)
title('Q4b - MSE with Ridge Regression (10 Training points)')
ylabel('Average MSE')
xlabel('Log10(gamma)')
legend('MSE Training','MSE Test')
grid on

figure(5)
plot([-6:3],log10(meanTrain10),[-6:3],log10(meanTest10))
title('Q4b - MSE with Ridge Regression (10 Training points)')
ylabel('Average Log10(MSE)')
xlabel('Log10(gamma)')
legend('MSE Training','MSE Test')
grid on

[[-6:3]' MSETrainTable100 MSETestTable100]

[[-6:3]' MSETrainTable100 MSETestTable100]
