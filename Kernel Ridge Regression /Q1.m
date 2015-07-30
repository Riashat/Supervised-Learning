%%
fprintf('Question 1\n\n')
%a

%random data generation
w=randn(1,1);
fprintf('Random w= %d\n\n',w)
x=randn(600,1);
n=randn(600,1);
y=x*w+n;
x_training=x(1:100,1);
y_training=y(1:100,1);

x_training_10=x(1:10,1);
y_training_10=y(1:10,1);

x_test=x(101:600,1);
y_test=y(101:600,1);
%%
%b
%calculate w for 100 training points
w=calculateW(x_training, y_training);
fprintf('Calculated w= %d for 100 train points\n',w)

%calculate corresponding MSE train and test
mse_training=calculateMSERidge(x_training, y_training, w);
mse_test=calculateMSERidge(x_test, y_test, w);

fprintf('MSE Train= %d MSE Test= %d for 100 train points\n\n',[mse_training, mse_test])
%%
%c
%calculate w for 100 training points
w=calculateW(x_training_10, y_training_10);
fprintf('Calculated w= %d for 10 train points\n',w)

%calculate corresponding MSE train and test
mse_training=calculateMSERidge(x_training_10, y_training_10, w);
mse_test=calculateMSERidge(x_test, y_test, w);
fprintf('MSE Train= %d MSE Test= %d for 10 train points\n\n',[mse_training, mse_test])

%%
%d
%setup initial variables
clear all
average_mse_training_500=0;
average_mse_test_100=0;
average_mse_training_10=0;
average_mse_test_500=0;

%start 200 times loop
for i=1:200
    w=randn(1,1);
    x=randn(600,1);
    n=randn(600,1);
    y=x*w+n;
    %split training sets
    x_training_500=x(1:100,1);
    x_test_100=x(101:600,1);
    y_training_500=y(1:100,1);
    y_test_100=y(101:600,1);
    
    x_training_10=x(1:10,1);
    x_test_500=x(11:510,1);
    y_training_10=y(1:10,1);
    y_test_500=y(11:510,1);
    
    %calculate w for 100 training points 
    w_predicted_500=calculateW(x_training_500, y_training_500);
    
    %calculate w for 10 training points     
    w_predicted_10=calculateW(x_training_10, y_training_10);
        
    mse_training_500=calculateMSERidge(x_training_500, y_training_500,w_predicted_500);
    
    mse_test_100=calculateMSERidge(x_test_100, y_test_100,w_predicted_500);

    mse_training_10=calculateMSERidge(x_training_10, y_training_10,w_predicted_10);
    
    mse_test_500=calculateMSERidge(x_test_500, y_test_500,w_predicted_10);
    %add MSE to the varibles for the final average
    average_mse_training_500=average_mse_training_500+mse_training_500;
    average_mse_test_100=average_mse_test_100+mse_test_100;
    average_mse_training_10=average_mse_training_10+mse_training_10;
    average_mse_test_500=average_mse_test_500+mse_test_500;
    
end
fprintf('           MSE Train     MSE Test\n100 Points %d %d\n10 Points  %d %d\n',...
    [average_mse_training_500/200 average_mse_test_100/200 average_mse_training_10/200 average_mse_test_500/200])

[average_mse_training_500/200, average_mse_test_100/200; average_mse_training_10/200, average_mse_test_500/200];



