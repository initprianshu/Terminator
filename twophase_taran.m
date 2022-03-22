format short
clear all
clc

%%INPUT PHASE
Variables = { 'x1', 'x2', 'x3', 's1', 's2', 'A1', 'A2', 'Sol' };
OVariables = { 'x1', 'x2', 'x3', 's1', 's2', 'Sol' };
OrigC = [ -7.5, 3, 0, 0, 0, -1, -1, 0];
Info = [ 3, -1, -1, -1, 0, 1, 0, 3; 1, -1, 1, 0, -1, 0, 1, 2 ];
bv = [6, 7];

%%PHASE-1
cost = [0, 0, 0, 0, 0, -1, -1, 0];
A = Info;
startbv = find(cost<0)  %%%define the artificial variables

fprintf('      PHASE-1         \n')
[BFS,A] = simp(A,bv,cost,Variables);

%%PHASE-2
fprintf('      PHASE-2         \n');
A(:,startbv) = [];
OrigC(:,startbv) = [];

[OptBFS, OptA] = simp(A,BFS,OrigC,OVariables);

FinalBFS = zeros(1,size(A,2));
FinalBFS(OptBFS) = OptA(:,end);
FinalBFS(end) = sum(FinalBFS.*OrigC);

OptimalBFS = array2table(FinalBFS);
OptimalBFS.Properties.VariableNames(1:size(OptimalBFS,2)) = OVariables;