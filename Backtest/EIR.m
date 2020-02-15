function y = EIR(x)
E(1)=10^x(1);I(1)=10^x(2);R(1)=10^x(3);total=round(x(4));
alpha =0.085;beta =1;delta =0.1010;E0 =664.2312;I0 =554.8484;gamma = 1/3;%%parameters
R0=258;


%Discrete form  of EIR model
for i=1:1:total-1
    E(i+1)=E(i)+beta*I(i)-gamma*E(i);
    I(i+1)=I(i)+gamma*E(i)-delta*I(i);
    R(i+1)=R(i)+delta*I(i);
end


y=abs(abs(E(total))+abs(I(total))+abs(R(total))-E0-I0-R0)+abs(abs(E(1))+abs(I(1))+abs(R(1))-1);%Squared Errors
%you can try other loss function
%%y=abs(abs(E(total))-E0)/(abs(E(total))+E0)+abs(abs(I(total))-I0)/(abs(I(total))+I0)+abs(abs(R(total))-R0)/(abs(R(total))+R0);
%%y=abs(abs(E(total))+abs(I(total))+abs(R(total))-E0-I0-R0)/(abs(E(total))+abs(I(total))+abs(R(total))+E0+I0+R0);
%%y=abs(abs(E(total))+abs(I(total))+abs(R(total))-E0-I0-R0)+abs(abs(E(1))+abs(I(1))+abs(R(1))-1)+abs(abs(R(total))-R0);