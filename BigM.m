clc
clear all
format rat
%% phase1:INPUT PARAMETERS
variables = {'x1','x2','s2','s3','A1','A2','sol'};
M=1000;
Cost = [-2 -1 0 0 -M -M 0];
A=[3 1 0 0 1 0 3;
4 3 -1 0 0 1 6;
 1 2 0 1 0 0 3];
s=eye(size(A,1));
%% Phase2:First table
bv=[];
for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i)==s(:,j)
            bv=[bv i];
        end
    end
end
zjcj=Cost(bv)*A-Cost;
disp(bv);
RUN=true;
while RUN
    zc=zjcj(1:size(A,2)-1);
    %% Phase3:First Iteration
    if any(zc<0)
        [minvalzjcj,piv_col_ind]=min(zc); %found the entering variable
        fprintf('--------------------\n');
        fprintf('Entering var is %d\n',piv_col_ind);
        fprintf('--------------------\n');
        pivot_Col=A(:,piv_col_ind);
        %pivot_col_ind=piv_col_ind; %%in case all the column entries are negative when we calculate ratio
        if all(pivot_Col<=0)
            print('LPP is unbounded')
            RUN=false;
        else
            for i=1:size(pivot_Col,1)
                if pivot_Col(i)>0
                    ratio(i)=A(i,size(A,2))./pivot_Col(i);
                else
                    ratio(i)=inf;
                end
            end
            [minratio,piv_row_ind]=min(ratio);
            pivot_row=A(piv_row_ind,:);
            fprintf('--------------------\n');
            fprintf('Leaving var is %d\n',piv_row_ind);
            fprintf('--------------------\n');
        end
        bv(piv_row_ind)=piv_col_ind;
        fprintf('Basic var are\n');
        disp(bv);
        pivot_key=A(piv_row_ind,piv_col_ind);
        %% Phase3:changed table for second iteration
%         B=A(:,bv);
%         A= B\A;    % how is this thing working 
        pivot_key=A(piv_row_ind,piv_col_ind);
            A(piv_row_ind,:)=A(piv_row_ind,:)./pivot_key;
            for j=1:size(A,1)
                if j~=piv_row_ind
                    A(j,:)=A(j,:)-(pivot_Col(j).*A(piv_row_ind,:));
                end
            end
        table=array2table(A);
        table.Properties.VariableNames(1:size(A,2))=variables
        zjcj=Cost(bv)*A-Cost;
    else
        disp('Optimal solution obtained')
        RUN=false;
    end
end