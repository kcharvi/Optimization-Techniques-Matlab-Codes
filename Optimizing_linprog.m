%% 
% 1) The standard weight of special purpose brick is 5kg. and it contains two 
% basic ingredients B1 and B2. B1 costs Rs. 5 per kg. and B2 costs 8 per kg. Strength 
% consideration state that the brick contains not more than 4 kg of B1 and minimum 
% of 2 kg. of B2. Since the demand for the product is likely to be related to 
% the price of the brick, find the minimum cost of the brick satisfying the above 
% conditions.

clear all
prob = optimproblem('ObjectiveSense','min');

x = optimvar('x','LowerBound',0);
y = optimvar('y','LowerBound',0);

prob.Objective = 5*x+8*y;

cons1 = x-4<=0;
cons2 = y-2>=0;
cons3 = x+y ==5;
prob.Constraints.cons1 = cons1;
prob.Constraints.cons2 = cons2;
prob.Constraints.cons3 = cons3;
p=prob2struct(prob);
[~,fval]=linprog(p);
show(prob)

sol = solve(prob);
sol

fprintf("Minimum cost is %f",fval);



%% 
% 2)A cooperative society of farmers has 50 hectare of land to grow two crops 
% X and Y. The profit from crops X and Y per hectare are estimated as Rs 10,500 
% and Rs 9,000 respectively. To control weeds, a liquid herbicide has to be used 
% for crops X and Y at rates of 20 litres and 10 litres per hectare. Further, 
% no more than 800 litres of herbicide should be used in order to protect fish 
% and wild life using a pond which collects drainage from this land. How much 
% land should be allocated to each crop so as to maximise the total profit of 
% the society?

clear all
prob = optimproblem('ObjectiveSense','max');

x = optimvar('x','LowerBound',0);
y = optimvar('y','LowerBound',0);

prob.Objective = 10500*x+9000*y;

cons1 = 2*x+y-80<=0;
cons2 = x+y-50<=0;
cons3 = y>=0;
cons4 = x>=0;
prob.Constraints.cons1 = cons1;
prob.Constraints.cons2 = cons2;
prob.Constraints.cons3 = cons3;
prob.Constraints.cons4 = cons4;
p=prob2struct(prob);
[~,fval]=linprog(p);
show(prob)

sol = solve(prob);
sol

fprintf("Maximum Z is %f",-fval);