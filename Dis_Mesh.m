for i=1:675
   for j=1:4594
      if  strcmp(disease(i,1),disease_Str(j,1))
          disease(i,2)=num2cell(j);
      end
   end
end