    clear all
    clc

    l = 5;
    no_examples = [10:2:1000];
    dimension = [1:10:100];
    for i = 1:length(no_examples)          %for examples (n)
        for j = 1:length(dimension)       % for dimension (m)        
            for k = 1:l                   %for averaging results


    no_examples2 = repmat(no_examples, [l,1]);

    a=1; b=-1; data{i,j} = round((b-a).*rand(no_examples2(k,i), dimension(j)) + a);
    data{i,j}(data{i,j}(:,:)==-1) = 0;

    [row{i,j} col{i,j}] = size(data{i,j});

    k_train = round(2/3 * row{i,j});

    y_train{i,j} = data{i,j}(1:k_train,1);
    x_train{i,j} = data{i,j}(1:k_train,:);

    %winnow_training returns the error for the winno classifier
    [ error_rate{i,j}{k} ] = winnow_training(x_train{i,j}, y_train{i,j});


            end        
    averaged_error(i,j) = mean (cell2mat(error_rate{i,j}));
    
        end
    end


    clear a
    for it = 1:length(dimension)
    a = find(averaged_error(:,it) < 10);
    idx(it) = a(1);
    end

    figure(1)
    fitpoly2 = fit(dimension', no_examples(idx)', 'poly2');
    plot(fitpoly2, dimension, no_examples(idx))
    title('Estimated Sample Complexity for Perceptron Classifier')
    xlabel('Dimension')
    ylabel('Number of Examples')
    legend('Number of Examples for Generalisation Error less than 10% - Sample Complexity' )
    grid on




