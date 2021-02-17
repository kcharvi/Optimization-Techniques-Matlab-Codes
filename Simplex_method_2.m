%Simplex Method implementation 2
X = 2;
C = [4 10];
Coeff = [2 1; 2 5; 2 3];
b = [50 ; 100 ; 90];
s = eye(size(Coeff,1));
A = [Coeff s b];
Cost = zeros(1,size(A,2));
Cost(1:X) = C;
BV = X+1:1:size(A,2)-1;
ZC = Cost(BV)*A - Cost;
Xj = [ZC ; A];
Simplex = array2table(Xj)
Simplex.Properties.VariableNames(1:size(Xj,2))={'x1','x2','s1','s2','s3','B'}

m = true;
while m
if any(ZC<0)
   disp('Not optimal! Next Iteration: ')
   disp(BV);
   zc = ZC(1:end-1);
   [entercol , pcol] = min(zc);
   if all(A(:,pcol)<=0)
     error('UNBOUNDED %d' , pcol);
   else
     sol = A(:,end);
     column = A(:,pcol);
    for i=1:size(A,1)
       if column(i)>0
          ratio(i) = sol(i)./column(i);
       else
          ratio(i) = inf;
       end
    end
    [minratio , prow] = min(ratio);
   end
   BV(prow) = pcol;
   disp(BV);
   pvtkey = A(prow,pcol);
   A(prow,:) = A(prow,:)./pvtkey;
   for i = 1:size(A,1)
       if i ~= prow
            A(i,:) = A(i,:)-A(i,pcol).*A(prow,:);
       end
   end
   ZC = ZC - ZC(pcol).*A(prow,:);
   Xj = [ZC ; A];
   Simplex = array2table(Xj)
   BasicFeasible = zeros(1,size(A,2));
   BasicFeasible(BV) = A(:,end);
   BasicFeasible(end) = sum(BasicFeasible.*Cost);
   currentBFS = array2table(BasicFeasible);
   currentBFS.Properties.VariableNames(1:size(currentBFS,2))={'x1','x2','s1','s2','s3','B'}

 else
      m = false;
      disp('Optimal Solution!!')
 end
end
