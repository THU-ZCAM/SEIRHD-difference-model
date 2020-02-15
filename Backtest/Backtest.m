clear all;clc;
%%
%%Description:This program is about backtracking of epidemic situation.
%%According to the initial value(E+I+R)of the 1.20, backtrack how many E,I,R
%%before this.The parameters(alpha,beta,delta etc.) were set accroding to Table 1
%%
ObjectiveFunction = @(x) EIR(x);%return errors to optimize parameters
X0 = [   1   1    1  20];   % Starting point 
LB = [  -1  -1   -1  10];   % Lower bound  
UB = [   3   3    3  30];  % Upper bound
options = saoptimset('PlotInterval',10, ...
                     'PlotFcns',{@saplotbestf,@saplottemperature,@saplotf,@saplotstopping});
options = saoptimset(options,'InitialTemperature',100);
options = saoptimset(options,'ReannealInterval',50);
options = saoptimset(options,'TolFun',1e-100);
[x,fval,exitFlag,output] = simulannealbnd(ObjectiveFunction,X0,LB,UB,options);%simulated annealing method

%%ode solutions
E(1)=10^x(1);I(1)=10^x(2);R(1)=10^x(3);total=round(x(4));
alpha =0.085;beta =1;delta =0.1010;E0 =664.2312;I0 =554.8484;gamma = 1/3;
R0=258;

%Discrete form  of EIR model
for i=1:1:total-1
    E(i+1)=E(i)+beta*I(i)-gamma*E(i);
    I(i+1)=I(i)+gamma*E(i)-delta*I(i);
    R(i+1)=R(i)+delta*I(i);
end

figure
hold on
plot(1:1:total,E,'-r');
plot(1:1:total,I,'-b');
plot(1:1:total,R,'-g');
plot(total,E0,'or');
plot(total,I0,'ob');
plot(total,R0,'og');

