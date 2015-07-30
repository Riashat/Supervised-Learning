%10

clear all
load('boston.mat');

%generate random indexes to select from boston dataset for training set and
%test
randIndex=randperm(506);
limit=round(length(boston)/3);
%mix original dataset
mixBoston=boston(randIndex,:);
train=mixBoston(1:337,:);
test=mixBoston(338:end,:);
%initialize arrays for sigma and gamma
gamma=power(2.*ones(1,length([-40:1:-26])), [-40:1:-26]);
sigma=power(2.*ones(1,length([7:0.5:13])), [7:0.5:13]);

%find MSE train, MSE test, table with MSE test error in function of gamma
%and sigma, averaged best sigma for cross validation and averaged best
%gamma for cross validation
[MSETrain, MSETest, crossValidationErrorTable, bestSigma, bestGamma]=kernelridgeregression(train, test);

fprintf('Best gamma= %d Best sigma= %d averaging the best results from cross-validation\n',[bestGamma, bestSigma])
fprintf('MSE Train= %d MSE Test= %d\n',[MSETrain, MSETest])

figure(10)
%loop and plot every series dependent on sigma
for i=1:length(sigma)
    plot(log2(gamma),crossValidationErrorTable(i,:))
    hold on
end
hold off
grid on
title('MSE Test vs gamma')
xlabel('Log2(gamma)')
ylabel('Average MSE')
legend('log2(sigma)=7.0',...
    'log2(sigma)=7.5','log2(sigma)=8.0',...
    'log2(sigma)=8.5','log2(sigma)=9.0','log2(sigma)=9.5',...
    'log2(sigma)=10.0','log2(sigma)=10.5','log2(sigma)=11.0',...
    'log2(sigma)=11.5','log2(sigma)=12.0','log2(sigma)=12.5',...
    'log2(sigma)=13.0')



figure(11)
%loop and plot every series dependent on sigma
for i=1:length(gamma)
    plot(log2(sigma),crossValidationErrorTable(:,i))
    hold on
end
hold off
grid on
title('MSE Test vs sigma')
xlabel('Log2(sigma)')
ylabel('Average MSE')
legend('log2(gamma)=-40',...
    'log2(gamma)=-39','log2(gamma)=-38',...
    'log2(gamma)=-37','log2(gamma)=-36',...
    'log2(gamma)=-35','log2(gamma)=-34',...
    'log2(gamma)=-33','log2(gamma)=-32',...
    'log2(gamma)=-31','log2(gamma)=-30',...
    'log2(gamma)=-29','log2(gamma)=-28',...
    'log2(gamma)=-27','log2(gamma)=-26')

