function P=SMR(PR,Ma)
%function P=SUBSmatrixEstrazione(PR,Ma)
%PR: protein
%Ma substitution matrix

alfabeto=['A' 'R' 'N' 'D' 'C' 'Q' 'E' 'G' 'H' 'I' 'L' 'K' 'M' 'F' 'P' 'S' 'T' 'W' 'Y' 'V'];

for j=1:length(PR)
    if find(PR(j)==alfabeto)
        P(j,:)=Ma(find(PR(j)==alfabeto),:);
    else
        P(j,1:20)=0;
    end
end









