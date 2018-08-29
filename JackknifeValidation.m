function [Predict_label,Scores] = JackknifeValidation(X,label,cg_str)


loocv_n = size(X,1);
combin = [label,X];
feature_size = size(X,2);

Predict_label = [];
Scores =[];
tt=[];
for k=1:loocv_n
	test_combin=[];temp_combin=[];train_combin=[];
	
    test_combin = combin(k,:);
	
	temp_combin = combin;
	temp_combin(k,:) = [];
	train_combin = temp_combin;
	
	test_x = test_combin(1,2:feature_size+1);
	test_y = test_combin(1,1);
	
	train_x = train_combin(:,2:feature_size+1);
	train_y = train_combin(:,1);
	
	model1=svmtrain(train_y,train_x,cg_str);
	[Predict_label_f1,accuracy1,Scores_f1]=svmpredict(test_y,test_x,model1,'-b 1');k
	Predict_label = [Predict_label;Predict_label_f1];
	Scores = [Scores;Scores_f1];
	tt=[tt;test_y];
	s1=sum(tt==Predict_label)/size(tt,1)
end

end
