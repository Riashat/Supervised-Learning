%%
fprintf('Question 2\n\n')
%a

%random data generation
w=randn(1,10);
fprintf('Random w= %d\n\n',w)
x=randn(600,10);
n=randn(600,1);
y=x*w'+n;

x_training=x(1:100,:);
y_test=y(101:600,:);

x_training_10=x(1:10,:);
y_training_10=y(1:10,:);

x_test=x(101:600,:);
y_training=y(1:100,:);


%%
%b

[mse_training, mse_test]=linearregressiontraining(x_training,y_training,x_test,y_test);
fprintf('MSE Train= %d MSE Test= %d for 100 train points\n\n',[mse_training, mse_test])
%%
%c


[mse_training, mse_test]=linearregressiontraining(x_training_10,y_training_10,x_test,y_test);
fprintf('MSE Train= %d MSE Test= %d for 100 train points\n\n',[mse_training, mse_test])

%%
%d
clear all
MSETable=zeros(200,4);

for i=1:200
    w=randn(1,10);
    x=randn(600,10);
    n=randn(600,1);
    y=x*w'+n;
    x_training=x(1:100,:);
    x_test=x(101:600,:);
    y_training=y(1:100,:);
    y_test=y(101:600,:);
    
    x_training_10=x(1:10,:);

    y_training_10=y(1:10,:);

    
    [mse_training, mse_test]=linearregressiontraining(x_training,y_training,x_test,y_test);

    [mse_training_10, mse_test_10]=linearregressiontraining(x_training_10,y_training_10,x_test,y_test);
 
    MSETable(i,1)=mse_training;
    MSETable(i,2)=mse_test;
    MSETable(i,3)=mse_training_10;
    MSETable(i,4)=mse_test_10;
end

fprintf('           MSE Train     MSE Test\n100 Points %d %d\n10 Points  %d %d\n',...
    mean(MSETable))




