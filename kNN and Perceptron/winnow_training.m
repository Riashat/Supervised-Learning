    %WINNOW ALGORITHM

    function [error] = winnow_training(X,y)

    [n, dimension] = size(X);
    weight = ones(1, dimension); %initializing w to 1
    mistakes = 0;

    for i = 1: n    

        if (X(i,:)*weight') < dimension
            y_pred = 0;
        else
            y_pred = 1;
        end

        if y_pred ~= y(i) 
        mistakes = mistakes +1;
            for j=1:dimension
                %multiplicating updates of the weights
                weight(j)=weight(j)*2^((y(i)-y_pred)*X(i,j));
            end

        end       

    end

    error = mistakes / size(X,1) * 100;

    end
