% ONE NEAREST NEIGHBOUR

function [error_1NN] = OneNearestNeighbour(x_train, y_train, x_test, y_test)

[rows, ~] = size(y_train);

y_predicted = zeros(rows,1);

xTrain = sum(x_train,2);
xTest = sum(x_test,2);

distance = bsxfun(@plus, xTest(:,:), xTrain') -  2* x_test(:,:)* x_train';

[~, closest_x] = min(distance, [], 2);

y_predicted = y_train(closest_x);

error_1NN = mean(y_predicted ~= y_test);

error_1NN = error_1NN * 100;



end