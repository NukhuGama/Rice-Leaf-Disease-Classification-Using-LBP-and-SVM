  function [c_mat,c_matrix,Result]= confMatrix(actual,predict)             
	actual=actual(:);
	predict=predict(:);
	if length(actual) ~= length(predict)
		error('Input have different lengths')
	end
	un_actual=unique(actual);
	un_predict=unique(predict);
	condition=length(un_actual)==length(un_predict);
	
	if ~condition
		error('Class List is not same in given inputs')                    
	end
	condition=(sum(un_actual==un_predict)==length(un_actual));                     
	if ~condition
		error('Class List in given inputs are different')
    end
    %%
	%Start process
	%Build Confusion matrix
	%Set variables
	class_list=un_actual;
	disp('Class List in given sample')
	disp(class_list)
	fprintf('\nTotal Instance = %d\n',length(actual));
	n_class=length(un_actual);
	c_matrix=zeros(n_class);
	predict_class=cell(1,n_class);
	class_ref=cell(n_class,1);
	row_name=cell(1,n_class);
	%Calculate conufsion for all classes
	for i=1:n_class
		class_ref{i,1}=strcat('class',num2str(i),'==>',num2str(class_list(i)));
		for j=1:n_class
			val=(actual==class_list(i)) & (predict==class_list(j));
           
			c_matrix(i,j)=sum(val);
			predict_class{i,j}=sum(val);
		end
		row_name{i}=strcat('Actual_class',num2str(i));
		disp(class_ref{i})
	end
	header = {'Bacterial Leaf Blight','Brown Spot','Leaf Smut'};
    c_mat = [header; num2cell(c_matrix)];
	%%
	%Finding
	%1.TP-True Positive
	%2.FP-False Positive
	%3.FN-False Negative
	%4.TN-True Negative
	
	
	[row,col]=size(c_matrix);
	if row~=col
		error('Confusion matrix dimention is wrong')
	end
	n_class=row;
	switch n_class
		case 2
			TP=c_matrix(1,1);
			FN=c_matrix(1,2);
			FP=c_matrix(2,1);
			TN=c_matrix(2,2);
			
		otherwise
			TP=zeros(1,n_class);
			FN=zeros(1,n_class);
			FP=zeros(1,n_class);
			TN=zeros(1,n_class);
			for i=1:n_class
				TP(i)=c_matrix(i,i);
				FN(i)=sum(c_matrix(i,:))-c_matrix(i,i);
				FP(i)=sum(c_matrix(:,i))-c_matrix(i,i);
				TN(i)=sum(c_matrix(:))-TP(i)-FP(i)-FN(i);
			end
			
	end
	

	P=TP+FN;
	N=FP+TN;
	switch n_class
	
		case 2
			accuracy=(TP+TN)/(P+N);
			Error=1-accuracy;
			Result.Accuracy=(accuracy)*100;  
			Result.Error=(Error)*100;
		otherwise
			accuracy=(TP)./(P+N);
			Error=(FP)./(P+N);
			Result.Accuracy=sum(accuracy)*100;                             
			Result.Error=sum(Error)*100; 
    end
    Result.TP = TP;
    Result.TN = TN;
    Result.FP = FP;
    Result.FN = FN;