# Terminator
clc
clear all
NoOfVar=3;
c=[3 2 5];
info=[1 2 1;1 4 0;3 0 2];
b=[430;460;420];
s=eye(size(info,1));
mat=[info s b];
cost=zeros(1,size(mat,2));
cost(1:NoOfVar)=c;

%% For BV

BV=NoOfVar+1:size(mat,2)-1;
%% Calculating ZJCJ
zjcj=cost(BV)*mat-cost;

%% To display the table
zcj=[mat;zjcj];
SimpleTable=array2table(zcj);
SimpleTable.Properties.VariableNames(1:size(zcj,2))={'X1','X2','X3','S1','S2','S3','Sol'}

%% Simplex Method Start
 run=true
 while run
     if any(zjcj<0)
         disp("This is not the optimal Solution\n");
         fprintf("The resulits for next iteration are\n");
         zc=zjcj(1:size(mat,2)-1);
         [enteringCol piv_col ]=min(zc);

         %% For Min Ratio and Leaving Var
         sol=mat(:,end);
         column=mat(:,piv_col);
         if all(mat(:,piv_col)<0)
             disp("LPP IS UNBOUNDED");
         else
             for i=1:size(column,1)
                 if column(i)>0
                     ratio(i)=sol(i)./column(i);
                 else
                     ratio(i)=inf;
                 end
             end
             [minRatio,piv_row]=min(ratio);
             fprintf("The minimum ratio is %d",minRatio);
             fprintf("The leaving variable is %d",BV(piv_col));
         end

         %% Swapping Leaving Variable and Entering Variable
         BV(piv_row)=piv_col;
         fprintf("New Basic Variable is %d",BV);
         piv_key=mat(piv_row,piv_col);
         mat(:,piv_row)=mat(:,piv_row)./piv_key;

         for i=1:size(mat,1)
             if i~=piv_row
                 mat(i,:)=mat(i,:)-mat(i,piv_col).*mat(piv_row,:);
             end
             zjcj=zjcj-zjcj(:,piv_col).*mat(piv_row,:);
         end
        
         %% Printing Section
         zcj=[mat;zjcj];
         SimpleTable=array2table(zcj);
         SimpleTable.Properties.VariableNames(1:size(zcj,2))={'X1','X2','X3','S1','S2','S3','Sol'}
     else
         run=false;
         disp("Optimal Solution Reached");
     end
 end

