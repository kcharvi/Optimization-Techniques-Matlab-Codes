%SIMPLEX METHOD:
A=[4 1 1 1 0; 2 1 -1 0 1 ];
C=[3 2 0 0 0]
BasicV=[3 4]
ZjCj=C(BasicV)*A-C
Simplex=[A;ZjCj];
SimplexTable=array2table(Simplex);
SimplexTable.Properties.VariableNames(1:size(Simplex,2))={'Xb','x1','x2','s1','s2',}
if any(ZjCj<0)
   ZC=ZjCj(1:end);
   [PivotCol,PivotEle]=min(ZC);
   fprintf('Minimum of Zj-Cj is %d\n',PivotCol);
   fprintf('Pivot Element is %d', PivotEle);
   fprintf('Entering variable %d\n',PivotEle);
else
   disp('Optimal solution')
end
