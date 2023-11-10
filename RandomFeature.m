Yeast_data=data_DCT;
R=round(1*rand(11188,1)); 
for i=1:11188
   if R(i)==0
       R(i)=-1;
   end
end
data_DCT(:,1)=R(:);
