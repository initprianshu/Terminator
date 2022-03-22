clc
clear all
format short
%% phase1: Input Parameter
A=[1 1 1 0;2 1 0 1];
B=[450;600];
C=[3 4 0 0];
%% phase2: Set of all Basic solutions
m=size(A,1);
n=size(A,2);
if(n>m)
    nCm=nchoosek(n,m);
    pair=nchoosek(1:n,m);
    sol=[];
    for i=1:nCm
        y=zeros(n,1);
        x=inv(A(:,pair(i,:)))*B;
        if(x>=0 & x~=inf & x~=-inf)
            y(pair(i,:))=x;
            sol=[sol, y];
        end
    end
else
    error('nCm does not exist')
end
%% phase3: Basic feasible solution
Z=C*sol;
[Zmax , Zindex]=max(Z);
bfs1=sol(:,Zindex);
optimal_value=[bfs1' Zmax];
optimal_bfs=array2table(optimal_value);
optimal_bfs.Properties.VariableNames(1:size(optimal_bfs,2))={'x_1', 'x_2' , 's_1' , 's_2','Z'}