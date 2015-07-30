    % LEAST SQUARES

    clear all
    clc

    l = 10;
    no_examples = [1:2:200];
    dimension = [1:2:100];
    for i = 1:length(no_examples)          %for examples (n)
        for j = 1:length(dimension)       % for dimension (m)        
            for k = 1:l

    %for averaring for each number of example            
    no_examples2 = repmat(no_examples, [l,1]);

    a=1; b=-1; data{i,j} = round((b-a).*rand(no_examples2(k,i), dimension(j)) + a);
    data{i,j}(data{i,j}(:,:)==0) = 1;

    [row{i,j} col{i,j}] = size(data{i,j});
    k_train = round(2/3 * row{i,j});

    y_train{i,j} = data{i,j}(1:k_train,1);
    x_train{i,j} = data{i,j}(1:k_train,:);
    y_test{i,j} = data{i,j}(k_train+1:end, 1);
    x_test{i,j} = data{i,j}(k_train+1:end, :);

    z{i,j} = transpose(x_train{i,j})*x_train{i,j};

    %estimating w based on the training set
    w{i,j} = pinv(z{i,j}) * transpose(x_train{i,j}) * y_train{i,j};

    %calculating the mean squared error on training set
    mean_error_training{i,j}{k} = ((w{i,j}'*x_train{i,j}'*x_train{i,j}*w{i,j} - 2*y_train{i,j}'*x_train{i,j}*w{i,j} + y_train{i,j}'*y_train{i,j}))/size(x_train{i,j},1) * 100;

    %calculating the mean squared error on test set
    mean_error_testing{i,j}{k} = ((w{i,j}'*x_test{i,j}'*x_test{i,j}*w{i,j} - 2*y_test{i,j}'*x_test{i,j}*w{i,j} + y_test{i,j}'*y_test{i,j}))/size(x_test{i,j},1) * 100;


      end

    averaged_error(i,j) = mean (cell2mat(mean_error_testing{i,j}));

        end

    end


    clear a
    for it = 1:length(dimension)
    a = find(averaged_error(:,it) < 10);
    idx(it) = a(1);
    end


    figure(1)
    scatter(dimension,no_examples(idx), 'b')
    lsline
    title('Estimated Sample Complexity for Least Squares')
    xlabel('Dimension')
    ylabel('Number of Examples')
    grid on

