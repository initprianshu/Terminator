clc
clear all
temp=[2 1;2 3;3 1];
B=[18; 42; 24];
C=[3 2];
s=eye(size(temp,1));
A=[temp s B];
t=zeros(1,size(A,2));
t(1:size(temp,2))=C;

bv=size(temp,2)+1:size(A,2)-1;
zjcj=t(bv)*A-t;
zc=zjcj(1:size(A,2)-1);
run=true;
while run
   if any(zc<0)
      [minzc,pivot_col_ind]=min(zc);
      pivot_col=A(:,pivot_col_ind);
      if all(pivot_col<=0)
          disp('LPP has unbounded sol');
          run=false;
      else
         for i=1:size(A,1)
             if pivot_col(i)>0
                 ratio(i)=A(i,size(A,2))/pivot_col(i);
             else
                 ratio(i)=inf;
             end
         end
         [minratio,pivot_row_ind]=min(ratio);
         pivot_row=A(pivot_row_ind,:);
         fprintf('--------------------\n');
         fprintf('Entering var is %d\n',pivot_col_ind);
         fprintf('--------------------\n');
         fprintf('--------------------\n');
         fprintf('Leaving var is %d\n',pivot_row_ind);
         fprintf('--------------------\n');
         bv(pivot_row_ind)=pivot_col_ind;
         fprintf('Basic var are\n');
         disp(bv);
         pivot_key=A(pivot_row_ind,pivot_col_ind);
         A(pivot_row_ind,:)=A(pivot_row_ind,:)/pivot_key;
         for i=1:size(A,1)
            if i~=pivot_row_ind
               A(i,:)=A(i,:)-(pivot_col(i)*A(pivot_row_ind,:));
            end
         end
        zjcj=t(bv)*A-t;
        zc=zjcj(1:size(A,2)-1);
        table=array2table(A);
        table.Properties.VariableNames={'x1','x2','s1','s2','s3','B'}
      end
   else 
       disp('Optimal sol reached');
       run=false;
   end
end