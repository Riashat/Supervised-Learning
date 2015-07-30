%Q6
clear all
%generate dataset
w=randn(1,10);
x=randn(600,10);
n=randn(600,1);
y=x*w'+n;
x_training=x(1:100,:);
x_test=x(101:600,:);
y_training=y(1:100,1);
y_test=y(101:600,1);


scoreMatrix=zeros(5,10);
MSETraintable=zeros(5,10);
MSETesttable=zeros(5,10);

for i=1:5
    %divide validation set from training set based on loop
    validation_range=[i*20-19:i*20];
    %get training set usinf setdiff to differentiate between validation set
    %and original training set
    test_range=setdiff([1:100],validation_range);
    x_validation_set=x_training(validation_range,:);
    x_test_set=x_training(test_range,:);
    y_validation_set=y_training(validation_range,1);
    y_test_set=y_training(test_range,1);
    %loop through each gamma
    for j=-6:3
        gamma=10^(j);
        w_predicted=calculateW(x_test_set,y_test_set,gamma);
        scoreMatrix(i,j+7)= calculateMSERidge(x_validation_set,y_validation_set,w_predicted,gamma);
        [MSETrain, MSETest]=linearregressiontraining(x_training, y_training,x_test,y_test,gamma);
        MSETesttable(i,j+7)=MSETest;
        MSETraintable(i,j+7)=MSETrain;
    end
    
end
figure(7)
plot([-6:3],scoreMatrix(1,:),[-6:3],scoreMatrix(2,:),[-6:3],scoreMatrix(3,:),[-6:3],scoreMatrix(4,:),[-6:3],scoreMatrix(5,:))

title('Q6 - MSE for 5 validation sets (100 points)')
ylabel('MSE')
xlabel('Log10(gamma)')
legend('k-fold #1','k-fold #2','k-fold #3','k-fold #4','k-fold #5')
grid on

meanScore=mean(scoreMatrix);
meanTrain=mean(MSETraintable);
meanTest=mean(MSETesttable);

figure(10)
plot([-6:3],meanTrain,[-6:3],meanTest,[-6:3],meanScore)

title('Q6 - MSE for 5 validation sets (100 points)')
ylabel('MSE')
xlabel('Log10(gamma)')
legend('MSE Train','MSE Test','Mean cross validation')
grid on
%%
clear all
%generate dataset
w=randn(1,10);
x=randn(600,10);
n=randn(600,1);
y=x*w'+n;
x_training=x(1:10,:);
x_test=x(11:510,:);
y_training=y(1:10,1);
y_test=y(11:510,1);
scoreMatrix=zeros(5,10);
MSETraintable=zeros(5,10);
MSETesttable=zeros(5,10);

for i=1:5
    %divide validation set from training set based on loop
    validation_range=[i*2-1:i*2];
    %get training set usinf setdiff to differentiate between validation set
    %and original training set
    test_range=setdiff([1:10],validation_range);
    x_validation_set=x_training(validation_range,:);
    x_test_set=x_training(test_range,:);
    y_validation_set=y_training(validation_range,1);
    y_test_set=y_training(test_range,1);
    for j=-6:3
        %loop through each gamma
        gamma=10^(j);
        w_predicted=calculateW(x_test_set,y_test_set,gamma);
        scoreMatrix(i,j+7)= calculateMSERidge(x_validation_set,y_validation_set,w_predicted,gamma);
        [MSETrain, MSETest]=linearregressiontraining(x_training, y_training,x_test,y_test,gamma);
        MSETesttable(i,j+7)=MSETest;
        MSETraintable(i,j+7)=MSETrain;
    end
    
end
figure(8)
plot([-6:3],scoreMatrix(1,:),[-6:3],scoreMatrix(2,:),[-6:3],scoreMatrix(3,:),[-6:3],scoreMatrix(4,:),[-6:3],scoreMatrix(5,:))

title('Q6 - MSE for 5 validation sets (10 points)')
ylabel('MSE')
xlabel('Log10(gamma)')
legend('k-fold #1','k-fold #2','k-fold #3','k-fold #4','k-fold #5')

grid on


meanScore=mean(scoreMatrix);
meanTrain=mean(MSETraintable);
meanTest=mean(MSETesttable);

figure(11)
plot([-6:3],meanTrain,[-6:3],meanTest,[-6:3],meanScore)

title('Q6 - MSE for 5 validation sets (10 points)')
ylabel('MSE')
xlabel('Log10(gamma)')
legend('MSE Train','MSE Test','Mean cross validation')
grid on