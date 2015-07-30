function K = kernel( xi, xj, o )
%kernel
%   gaussian kernel
%Input
%xi
%xj
%o - sigma
%Ouput
%K - gaussian kernel
    K=exp((-norm(xi-xj).^2)./(2*o^2));

end

