
%function for the online perceptron
    function [mistakes error_rate] = perceptron_training(X,y)

    correct = 0;

    [n, dimension] = size(X);

    idx = 1;
    weight = zeros(dimension,1);
    mistakes = 0;
    is_first_iter = 1;
    iter = 1;

    conv = 1;
    t1=1;
    t=1;

    %run convergence while loop until there are no more mistakes, and no
    %updates are required

    while (conv) & (iter <= n)

      xt = X(idx,:)';
      yt = y(idx);

      a = sign(yt*(weight'*xt));
    
      %if miscorrect classification 
      if (is_first_iter==1 | a < 0)
        correct = 0;
        %updating the weights
        weight = weight + (yt*xt);
        mistakes = mistakes + 1;
        t1 = t1+1;
        is_first_iter = 0;
      else
        correct = correct + 1;
      end

      idx = 1 + idx;
      if (idx > n)
        idx = 1;
      end


      conv =abs(t-t1);
      iter = iter + 1;

    end

    error_rate = mistakes/n * 100;