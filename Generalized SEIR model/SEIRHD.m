function y = SEIRHD(x,A)
beta=10^x(1);alpha=10^x(2);delta=1/x(3);I0=10^x(4);E0=I0*x(5);E(1)=E0;I(1)=I0;%%parameters
S(1)=14000000;N=S(1);R(1) = A(1,2);H(1) = A(1,3);D(1) = A(1,4);%%Wuhan
gamma=1/2;lambda=A(:,length(A(1,:))-1);kappa=A(:,length(A(1,:)));

%Discrete form  of SEIR model
for i=1:1:length(A(:,1))-1
    S(i+1)=S(i)-beta*S(i)*I(i)/N-alpha*S(i);
    E(i+1)=E(i)+beta*S(i)*I(i)/N-gamma*E(i);
    I(i+1)=I(i)+gamma*E(i)-delta*I(i);
    R(i+1)=R(i)+delta*I(i)-lambda(i)*R(i)-kappa(i)*R(i);
    H(i+1)=H(i)+lambda(i)*R(i);
    D(i+1)=D(i)+kappa(i)*R(i);
end

y=((R+H+D)'-A(:,2))'*((R+H+D)'-A(:,2));%Squared Errors
%you can choose other loss function
%y=((R+H+D)'-A(:,2))'*((R+H+D)'-A(:,2))/100+(H'-A(:,3))'*(H'-A(:,3))+(D'-A(:,4))'*(D'-A(:,4))*20;
%y=abs(abs(R+H+D)'-A(:,2))'*(2./(abs(R+H+D)'+A(:,2)));
%y=abs(abs(R+H+D)'-A(:,2))'*(2./(abs(R+H+D)'+A(:,2)))+abs(abs(H)'-A(:,3))'*(2./(abs(H)'+A(:,3)+1))+abs(abs(D)'-A(:,4))'*(2./(abs(D)'+A(:,4)+1));