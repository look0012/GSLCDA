function P = forward_softmax(X, which_dim)
% P = softmax(Y, which_dim)

%max(A,[],dim)：返回A中有dim指定的维数范围中的最大值。dim取1时返回每列最大值，dim取2时返回每行最大值
%expX = exp(X - max(X,[],which_dim)); % Use shifts to ensure numerical stability
%------------自己加的，满足./条件---
TempMax=max(X,[],which_dim);
[r,h]=size(X);
TempA=ones(1,h);
TempMax=TempMax*TempA;
%---------
expX = exp(X - TempMax); % Use shifts to ensure numerical stability

%P = expX ./ sum(expX, which_dim);
%------------自己加的，满足./条件---
TempSum=sum(expX, which_dim);
[r,h]=size(expX);
TempA=ones(1,h);
TempSum=TempSum*TempA;
%---------
P = expX ./ TempSum;
P = P + eps; % Avoid explicit zero 返回某一个数N的最小浮点数精度,一般用在分母上，防止分母等于0

