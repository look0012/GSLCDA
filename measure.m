% function [precision,sensitivity,mcc,total,tp,fp,tn,fn]=measure(pred,real)
function [precision,sensitivity,total,tp,fp,tn,fn]=measure(pred,real)
real(find(real==-1))=0;
pred(find(pred==-1))=0;

invreal=1-real;
invpred=1-pred;
tp=sum(real.*pred); %%%%%% true positives
fp=sum(invreal.*pred); %%%%%% false positives
tn=sum(invpred.*invreal); %%%%%% true negatives
fn=sum(real.*invpred); %%%%%% false negatives
% denom=sqrt((tn+fn)*(tn+fp)*(tp+fn)*(tp+fp)); %%%%%% denominator
% mcc=(tp*tn-fn*fp)/denom;
precision=tp/(tp+fp);
sensitivity=tp/(tp+fn);
%  accuracy=length(find(pred==real))/length(pred);
% sn=tp/(tp+fn);  %%%%%% sensitivity for the postive class
% sp=tn/(tn+fp);  %%%%%%  specificity for the postive class
total=(tp+tn)/(tp+tn+fp+fn);