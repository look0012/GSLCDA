%How to use Weka within MATLAB
%This is an example on how to run a model and obtain its evaluation
%by using CLI options for Weka

%Add the path to weka
javaaddpath('/path/to/weka.jar');

%You may need to add the path to external packages
%javaaddpath('C:/users/dakjdh/wekafiles/packages/LibSVM/libSVM.jar')
%javaaddpath('C:/users/dakjdh/wekafiles/packages/LibSVM/lib/libSVM.jar')


%First create the classifier (this is just an example)
classifier = weka.classifiers.functions.Logistic;

%Create the parameters
%In this case I will be working with file 'iris.arff' 
%with logistic ridge 0.01 
%param=java.lang.String('-t ./Data_1f_test.arff -R 0.01').split(' ');
param = regexp('-t ./Data_1f_test.arff -R 0.01', ' ', 'split');

%Run the evaluation
aa = weka.classifiers.Evaluation.evaluateModel(classifier,param)

%ENJOY!

