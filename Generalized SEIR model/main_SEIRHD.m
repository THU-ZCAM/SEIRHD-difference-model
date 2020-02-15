clear all;clc;
%%
%Description:This program is about parameter identification of SEIRHD model by using
%simulated annealing method and fit incubated population,healed population and death number.


%Please select the TXT file.
%But note that you shoule load data in the form of date,identified number,healed number,death number
[filename filepath] = uigetfile;
B = load(filename);
jumpstep = 1;
k = 0;
for i = 1:jumpstep:length(B(:,1))
    for j = 1:1:length(B(1,:))
        A(k+1,j) = B(k*jumpstep+1,j);
    end
k=k+1;
end

ObjectiveFunction = @(x) SEIRHD(x,A);%return errors to optimize parameters
X0 = [  0 -1  10   3   1];   % Starting point
LB = [ -1 -2   1   0  0.7];   % Lower bound  
UB = [  0  0  10   4   2];  % Upper bound
options = saoptimset('PlotInterval',10, ...
                     'PlotFcns',{@saplotbestf,@saplottemperature,@saplotf,@saplotstopping});
options = saoptimset(options,'InitialTemperature',100);
options = saoptimset(options,'ReannealInterval',50);
options = saoptimset(options,'TolFun',1e-100);
[x,fval,exitFlag,output] = simulannealbnd(ObjectiveFunction,X0,LB,UB,options);%simulated annealing method


beta = 10^x(1);alpha = 10^x(2);delta = 1/x(3);I0 = 10^x(4);E0 = I0*x(5);E(1) = E0;I(1) = I0;%Parameters
S(1) = 14000000;N = S(1);R(1) = A(1,2);H(1) = A(1,3);D(1) = A(1,4);%%Initial value
gamma=1/2;E(1)=E0;I(1)=I0;lambda=A(:,length(A(1,:))-1);kappa=A(:,length(A(1,:)));
% alpha =0.0852*0.95;beta =1;delta =0.1347;E0 =317.8512;I0 =389.0727;%Optimal parameters of Wuhan-the best fit 

%Discrete form  of SEIRHD model
for i=1:1:length(A(:,1))-1
    S(i+1)=S(i)-beta*S(i)*I(i)/N-alpha*S(i);
    E(i+1)=E(i)+beta*S(i)*I(i)/N-gamma*E(i);
    I(i+1)=I(i)+gamma*E(i)-delta*I(i);
    R(i+1)=R(i)+delta*I(i)-lambda(i)*R(i)-kappa(i)*R(i);
    H(i+1)=H(i)+lambda(i)*R(i);
    D(i+1)=D(i)+kappa(i)*R(i);
end

%fit and predition incubated population,healed population and death number
fit(alpha, beta, gamma, delta, A, B, S, E, I, R, H, D, N)
