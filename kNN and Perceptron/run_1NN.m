    clear all
    clc

    l = 5;
    no_examples = [1:2:500];
    dimension = [1:1:60];

    for i = 1:length(no_examples)          %for examples (n)
        for j = 1:length(dimension)       % for dimension (m)        
            for k = 1:l

    no_examples2 = repmat(no_examples, [l,1]);

    a=1; b=-1; data{i,j} = round((b-a).*rand(no_examples2(k,i), dimension(j)) + a);
    data{i,j}(data{i,j}(:,:)==0) = 1;

    [row{i,j} col{i,j}] = size(data{i,j});

    k_train = round(2/3 * row{i,j});

    y_train{i,j} = data{i,j}(1:k_train,1);
    x_train{i,j} = data{i,j}(1:k_train,:);
    y_test{i,j} = data{i,j}(k_train+1:end, 1);
    x_test{i,j} = data{i,j}(k_train+1:end, :);


    error_rate{i,j}{k} = OneNearestNeighbour(x_train{i,j}, y_train{i,j}, x_test{i,j}, y_test{i,j});

    end

    averaged_error(i,j) = mean (cell2mat(error_rate{i,j}));


        end
    end


    clear a
    for it = 1:length(dimension)
    a = find(averaged_error(:,it) < 10);
    idx(it) = a(1);
    end

    dim = dimension(1:length(idx));

    figure(1)
    pfit = fit(dim' ,no_examples(idx)', 'poly2');
    plot(pfit,dim, no_examples(idx))
    grid on
    title('Estimated Sample Complexity for 1-NN Classifier')
    xlabel('Dimension')
    ylabel('Number of Examples')

