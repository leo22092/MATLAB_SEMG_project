% Sample code
% no_of_features=4
% electrode1=[]
% electrode_no=1
% a=[9 10 11 12 17 18 19 20]
% b=ones(20)
% b(:,a)=[]
% pass in feature matrix
columns_to_be_removed=[9 10 11 12 17 18 19 20]
feature_matrix(:,columns_to_be_removed)=[]
four_ele_feature_matrix=feature_matrix