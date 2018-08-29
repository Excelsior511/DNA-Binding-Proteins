% 
% libsvm-3.18
%
% close all;
% clear;
% clc;
% format compact;


path('./SVM-RFE-CBR-v1.3',path);

data=load('div_ex_1075_1.txt');

nn=size(dat,1);
label=linspace(1,nn,nn);
label=label';

for i=1:1075
    if(i<=525)
    label(i) = 1;
    else 
    label(i) = 0;
    end
end

train_matrix=data;
train_labels=label;

[Train_matrix,PS] = mapminmax(train_matrix');
train_data = Train_matrix';


param.kerType = 2;
param.rfeC = 16;
param.rfeG = 0.0078;
param.useCBR = true;
param.Rth = 0.9;
[bestacc,best_dim,ftRank,ftScore]=optem_Dim(train_data,train_labels,param);
aftRank=ftRank';

X_S=ft_select(train_data, ftRank,best_dim);


cg_str='-c 16 -g 0.0078 -b 1';
[Predict_label,Scores] = JackknifeValidation(X_S,label,cg_str);

