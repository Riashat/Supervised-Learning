%Q8
clear all
load('boston.mat');

%%
%Q9
%a

average_w=0;
average_mse_training=0;
average_mse_test=0;
for i=1:20
    randIndex=randperm(506);
 
    training=boston(randIndex(1:337),1:14);
    test=boston(randIndex(338:506),1:14);
    
    trainingOnes=ones(length(training),1);
    testOnes=ones(length(test),1);
    
    w=calculateW(trainingOnes,training(:,14),0);
    
    average_w = average_w + w;
    average_mse_training=average_mse_training + calculateMSERidge(trainingOnes,training(:,14),w,0);
    average_mse_test=average_mse_test + calculateMSERidge(testOnes,test(:,14),w,0);

end

average_w=average_w/20
average_mse_training=average_mse_training/20
average_mse_test=average_mse_test/20



%%
%b


average_w=zeros(2,13);
average_mse_training=zeros(1,13);
average_mse_test=zeros(1,13);

for i=1:20
    randIndex=randperm(506);
    training=boston(randIndex(1:337),1:14);
    test=boston(randIndex(338:506),1:14);
    trainingOnes=ones(length(training),1);
    testOnes=ones(length(test),1);
    
    for dimension=1:13
        tmp_training=[training(:,dimension) trainingOnes];
        tmp_test=[test(:,dimension) testOnes];
        w=calculateW(tmp_training ,training(:,14),0);
        average_w(:, dimension) = average_w(:, dimension) + w;
        average_mse_training(1, dimension)=average_mse_training(1, dimension) + calculateMSERidge(tmp_training,training(:,14),w,0);
        average_mse_test(1, dimension)=average_mse_test(1, dimension) + calculateMSERidge(tmp_test,test(:,14),w,0);      
    end

end

average_w=average_w./20
average_mse_training=average_mse_training'./20;
average_mse_test=average_mse_test'./20;
training_test_mse=[average_mse_training, average_mse_test]

%%
%c ?
average_w=0;
average_mse_training=0;
average_mse_test=0;
for i=1:20
    randIndex=randperm(506);
    training=boston(randIndex(1:337),1:14);
    test=boston(randIndex(338:506),1:14);
    trainingOnes=ones(length(training),1);
    testOnes=ones(length(test),1);
    
    trainingX=[training(:,1:13) trainingOnes];
    testX=[test(:,1:13) testOnes];
    
    w=calculateW(trainingX,training(:,14),0);
    average_w = average_w + w;
    average_mse_training=average_mse_training + calculateMSERidge(trainingX,training(:,14),w,0);
    average_mse_test=average_mse_test + calculateMSERidge(testX,test(:,14),w,0);

end

average_w=average_w/20
average_mse_training=average_mse_training/20
average_mse_test=average_mse_test/20
