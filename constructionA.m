
for i=1:100
   disease{i,1}=strtrim(disease{i,1}); 
end
for i=1:661
   circRNA{i,1}=strtrim(circRNA{i,1}); 
end
for i=1:739
   CircR2Disease_P{i,1}=strtrim(CircR2Disease_P{i,1}); 
   CircR2Disease_P{i,2}=strtrim(CircR2Disease_P{i,2}); 
end


A=zeros(100,661); 

for i=1:739
    i
   strRNA= CircR2Disease_P{i,1};
   strDisease= CircR2Disease_P{i,2};
   strRNA_num=0;
   strDisease_num=0;

   for j=1:100
      if strcmpi(strDisease,disease(j,1))
         strDisease_num=j;
         break; 
      end
   end

    for k=1:661 
      if strcmp(strRNA,circRNA(k,1)) 
          strRNA_num=k;
         break; 
      end
    end
   A(strDisease_num,strRNA_num)=1;
end