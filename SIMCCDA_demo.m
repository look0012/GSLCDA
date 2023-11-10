% SIMCCDA: Prediction of CircRNA-disease associations based on inductive matrix completion
%  
%%
%   interMatrix: an n*m association matrix between circRNAs and diseases, n is 
%the number of circRNAs, and m is the number of diseases
%   circSim: an n*n similarity matrix of circRNAs
%   disSim: an m*m similarity matrix of disease

%% configuration
addpath('SIMC');
 
%% load data
%可把几个矩阵融合
%interMatrix=importdata('./data/CircR2Disease/CD.mat');
% circSim=importdata('./data/CircR2Disease/CFS-Do.mat');    
% disSim=importdata('./data/CircR2Disease/DoSemanticSimilarity.mat');
interMatrix = CD;
circSim = Feature_circ;
disSim = Feature_dis;
% circSim=circ1;
% disSim=dis1;
% %% complete interaction information for a new circRNA 没有新的用不到
% [nc, nd]=size(interMatrix);
% for i=1:nc
%     if length(find(interMatrix(i,:)))==0
%         rowVec=circSim(i,:); 
%         rowVec(i)=0;
%         simNeighbors=find(rowVec>=mean(mean(circSim))); 
%         if length(simNeighbors)
%             new_row=zeros(1,nd);
%                 for l=1:length(simNeighbors)
%                    new_row=new_row+interMatrix(simNeighbors(l),:);       
%                 end
%             new_row=new_row/length(simNeighbors);      
%             interMatrix(i,:)=new_row;     
%         end
%     end
% end
% 

%% using inductive matrix completion to complete the association matrix of lncRNA-disease
Omega=find(interMatrix==1);    
M_recover=SIMC(interMatrix,Omega,circSim,disSim,0.0001);   %%%%%%%% 最后一位为lambda参数 %%%
% M_recover=SIMC(interMatrix,Omega,circ1,dis1);   %%%%%%%%%%%
% %归一化
% M_recover = mapminmax(M_recover, 0, 1);
