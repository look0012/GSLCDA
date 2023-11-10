
for i = 1:size(data_DCT,1)
    i
    data(i,1:784)=mapminmax(data_DCT(i,2:785),0,1);
end

opt = statset('Maxiter', 600, 'TolFun ', 1e-7);   
[W,H] = nnmf(data',200,'options',opt);    
data_DCT = H';

 aa= zeros(1478,1);
 data_DCT=[aa,data_DCT];
 
 data_DCT(1:739,1)=1;
 data_DCT(740:1478,1)=-1;
