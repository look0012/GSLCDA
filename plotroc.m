[X1,Y1,THRE,AUC1,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(Yeast_f1_test_label,dec_values1(:,1),'1');
[X2,Y2,THRE,AUC2,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(Yeast_f2_test_label,dec_values2(:,1),'1');
[X3,Y3,THRE,AUC3,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(Yeast_f3_test_label,dec_values3(:,1),'1');
[X4,Y4,THRE,AUC4,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(Yeast_f4_test_label,dec_values4(:,1),'1');
[X5,Y5,THRE,AUC5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(Yeast_f5_test_label,dec_values5(:,1),'1');

% [X1,Y1,THRE,AUC1,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(human_f1_test_label,dec_values1(:,1),'1');
% [X2,Y2,THRE,AUC2,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(human_f2_test_label,dec_values2(:,1),'1');
% [X3,Y3,THRE,AUC3,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(human_f3_test_label,dec_values3(:,1),'1');
% [X4,Y4,THRE,AUC4,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(human_f4_test_label,dec_values4(:,1),'1');
% [X5,Y5,THRE,AUC5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(human_f5_test_label,dec_values5(:,1),'1');
% 
% 
% [X1,Y1,THRE,AUC1,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(Matine_f1_test_label,dec_values1(:,1),'1');
% [X2,Y2,THRE,AUC2,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(Matine_f2_test_label,dec_values2(:,1),'1');
% [X3,Y3,THRE,AUC3,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(Matine_f3_test_label,dec_values3(:,1),'1');
% [X4,Y4,THRE,AUC4,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(Matine_f4_test_label,dec_values4(:,1),'1');
% [X5,Y5,THRE,AUC5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(Matine_f5_test_label,dec_values5(:,1),'1');
% % 
% [X1,Y1,THRE,AUC1,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(yeast_f1_test_label,src_scores1(:,2),'-1');
% [X2,Y2,THRE,AUC2,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(yeast_f2_test_label,src_scores2(:,2),'-1');
% [X3,Y3,THRE,AUC3,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(yeast_f3_test_label,src_scores3(:,2),'-1');
% [X4,Y4,THRE,AUC4,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(yeast_f4_test_label,src_scores4(:,2),'-1');
% [X5,Y5,THRE,AUC5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(yeast_f5_test_label,src_scores5(:,2),'-1');
% % 
% [X1,Y1,THRE,AUC1,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(human_f1_test_label,src_scores1(:,2),'-1');
% [X2,Y2,THRE,AUC2,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(human_f2_test_label,src_scores2(:,2),'-1');
% [X3,Y3,THRE,AUC3,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(human_f3_test_label,src_scores3(:,2),'-1');
% [X4,Y4,THRE,AUC4,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(human_f4_test_label,src_scores4(:,2),'-1');
% [X5,Y5,THRE,AUC5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(human_f5_test_label,src_scores5(:,2),'-1');
% 
% [X1,Y1,THRE,AUC1,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(Matine_f1_test_label,src_scores1(:,2),'-1');
% [X2,Y2,THRE,AUC2,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(Matine_f2_test_label,src_scores2(:,2),'-1');
% [X3,Y3,THRE,AUC3,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(Matine_f3_test_label,src_scores3(:,2),'-1');
% [X4,Y4,THRE,AUC4,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(Matine_f4_test_label,src_scores4(:,2),'-1');
% [X5,Y5,THRE,AUC5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(Matine_f5_test_label,src_scores5(:,2),'-1');


hold on
    plot(X1,Y1,'g','LineWidth',1.5);
    plot(X2,Y2,'y','LineWidth',1.5);
    plot(X3,Y3,'b','LineWidth',1.5);    
    plot(X4,Y4,'r','LineWidth',1.5);    
    plot(X5,Y5,'k','LineWidth',1.5);grid on;ll=legend('1th fold','2th fold','3th fold','4th fold','5th fold');
    xlabel('1-Specificity');ylabel('Sensitivity');
    box on;
   meanAUC=mean([AUC1,AUC2,AUC3,AUC4,AUC5]);
    grid off;

 text(0.3,0.05,num2str(meanAUC,'Average AUC =%.4f'),'Fontsize',18)
 
set(get(gca,'XLabel'),'FontSize',18);
set(get(gca,'YLabel'),'FontSize',18);
set(gca,'FontSize',10);
set(ll,'FontSize',10);

% A_meanAUC=mean([AUC1,AUC2,AUC3,AUC4,AUC5]);
% A_stdAUC=std([AUC1,AUC2,AUC3,AUC4,AUC5]);

