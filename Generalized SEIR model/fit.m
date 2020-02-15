function fit(alpha, beta, gamma, delta, A, B, S, E, I, R, H, D, N)
for i=21:1:70
    S(i+1)=S(i)-beta*S(i)*I(i)/N-alpha*S(i);
    E(i+1)=E(i)+beta*S(i)*I(i)/N-gamma*E(i);
    I(i+1)=I(i)+gamma*E(i)-delta*I(i);
    R(i+1)=R(i)+delta*I(i);
end

%%
%Undo notes if you want predict the trend of next 20 days.
%%

% figure(3)
% hold on
% plot(B(:,1),B(:,2),'or');%% incubated population
% plot(1:1:71,E','-r');
% plot(1:1:71,I','-b');
% plot(1:1:71,R','-g');
% xlabel('date')
% ylabel('population');

%%
%Fit of the incubated/healed/death population from 01/20 to 02/09
%%
figure(2)
hold on
plot(B(:,1),B(:,2),'or','LineWidth',2);%% incubated population
plot(B(:,1),B(:,3),'*b','LineWidth',2);%% healed population
plot(B(:,1),B(:,4),'^g','LineWidth',2);%% death number
plot(B(:,1),(R(:,1:21)+H+D)','-r','LineWidth',2);
plot(B(:,1),H','-b','LineWidth',2);
plot(B(:,1),D','-g','LineWidth',2);
xlabel('date')
ylabel('population');
end