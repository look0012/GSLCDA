function dLdX = backward_softmax(P, which_dim, dLdP)
% P = softmax(Y, which_dim)

P = P - eps; % Account for +eps in forward_softmax

%dLdX = ( dLdP - sum(dLdP .* P, which_dim) ) .* P;
%------------自己加的，满足./条件---
TempSum=sum(dLdP .* P, which_dim);
[r,h]=size(dLdP);
TempA=ones(1,h);
TempSum=TempSum*TempA;
%---------
dLdX = ( dLdP - TempSum ) .* P;
