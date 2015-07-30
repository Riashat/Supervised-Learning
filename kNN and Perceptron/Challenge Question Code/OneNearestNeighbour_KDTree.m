% ONE NEAREST NEIGHBOUR

function [error_1NN] = OneNearestNeighbour_KDTree(x_train, y_train, x_test, y_test)

[rows, ~] = size(y_train);

y_predicted = zeros(rows,1);

xTrain = sum(x_train,2);
xTest = sum(x_test,2);


KDTreeMdl = KDTreeSearcher(x_train,'Distance','minkowski','P',5);

[IdxMk,DMk] = knnsearch(KDTreeMdl,x_test,'k',1);


y_predicted = y_train(IdxMk);

error_1NN = mean(y_predicted ~= y_test);

error_1NN = error_1NN * 100;



end