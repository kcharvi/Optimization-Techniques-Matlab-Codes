%DUAL SIMPLEX METHOD
clc
clear all
V={'x1','x2','s1','s2','Sol'}
C = [100 120 0 0 0];
Coeff = [6 7 ; 8 12];
b=[12;20];
s=eye(size(Coeff,1));
A=[Coeff s b];
BV=[];
for j=1:size(s,2)
for i=1:size(A,2)
if A(:,i)==s(:,j)
BV=[BV i];
end
end
end
fprintf('Basic Variables');
disp(V(BV));
ZjCj=C(BV)*A-C;
ZCj=[ZjCj;A];
Dual= array2table(ZCj);
Dual.Properties.VariableNames(1:size(ZCj,2))=V
m=true;
while m
ZC=ZjCj(:,1:end-1);
if any(ZC<0)
fprintf('The current Basic Feasible solution is not optimal\n');
[Entval,pvt_col]=min(ZC);
fprintf('Entering Column = %d\n',pvt_col);
sol=A(:,end);
Column=A(:,pvt_col);
if all(Column<=0)
fprintf('UNBOUNDED! ');
else
for i=1:size(Column,1)
if Column(i)>0
ratio(i)=sol(i)./Column(i);
else
ratio(i)=inf;
end
end
[minR,pvt_row]=min(ratio);
fprintf('Leaving Row = %d\n', pvt_row);
end
BV(pvt_row)=pvt_col;
B=A(:,BV);
A=inv(B)*A;
ZjCj=C(BV)*A-C;
ZCj=[ZjCj;A];
Dual=array2table(ZCj);
Dual.Properties.VariableNames(1:size(ZCj,2))=V
else
m=false;
fprintf('The Optimal solution is reached ');
Final_BFS = zeros(1,size(A,2));
Final_BFS(BV) =A(:,end);
Final_BFS(end)=sum(Final_BFS.*C);
OptimalBFS=array2table(Final_BFS);
OptimalBFS.Properties.VariableNames(1:size(OptimalBFS,2))=V
end
end