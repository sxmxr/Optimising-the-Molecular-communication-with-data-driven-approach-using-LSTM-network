clc
close all
clear all

Lambda = 100; %Lambda
Radius = 45e-9; %Receiver Radius
d = 500e-9; %Distance Between the Transmitter and Receiver
D = 4.265e-10; %Diffusion Constant
Delta_T = 9e-6; %Discrete Time length
T = 30*Delta_T; %Slot length
L = 5; %Channel Length
global Sum_Cj;
sum=0;
sum1=0;
X = 0:1:140;
Sum_Cj=0;

Data = rand(1,L)>0.5;

for ii=1:1:5
sum = sum + Cj_fun(ii);
sum1 = sum1 + Data(ii)*Cj_fun(ii);
end

Avg = sum + Lambda*T;
Avg1 = Avg + 20;
Final_term = 100000;

for jj=1:1:length(X)
Factor = Avg.^(X(jj));
Fact = factorial(X(jj));
Final(jj) = (exp(-Avg)*(Factor))/Fact;
Factor1 = Avg1.^(X(jj));
Final1(jj) = (exp(-Avg1)*(Factor1))/Fact;
Lam1 = Lambda*T + sum1;
Lam2 = Lam1 + 20;
    First_term = Q_fun(Lam1, X(jj));
    Last_term = 1 - Q_fun(Lam2, X(jj));
    Final_term_next = 0.5*(First_term + Last_term);
    
    if(Final_term_next < Final_term)
        Final_term = Final_term_next;
        Final_tau = X(jj);
    end
end

t3 = 20/Avg;
t2 = log(1+t3); 
t1 = 20/t2;

figure;
plot(X,Final,'-.ro');
hold on
plot(X,Final1,'-.b*');
stem(t1, 0.08, 'Marker','none');
stem(Final_tau, 0.08, 'Marker', 'none');
xlabel('Recieved Particles(r_i)')
ylabel('Probability')
h= legend('Approximated distribution when s_i=0', 'Approximated distribution when s_i=1', 'Threshold from Equiprobability', 'Optimal Threshold');
h.FontSize = 7;
rect = [0.65, 0.70, 0.25, 0.2];
set(h, 'Position', rect);

%---- functions ------

function Sum_Cj = Cj_fun(j)
    Ntx = 10^2;
    global Sum_Cj;
    Sum_Cj = Sum_Cj + Ntx*prob_j(j);
    %Ntx*prob_j(j)
end

function y = prob_j(j)
    Lambda = 100;
    Radius = 45e-9;
    d = 500e-9;
    D = 4.265e-10;
    Delta_T = 9e-6;
    T = 30*Delta_T;
    L = 5;
X = Radius/d;
t1 = ((d-Radius)/(sqrt(4*D*(j+1)*T)));
t2 = ((d-Radius)/(sqrt(4*D*(j)*T)));
y = X*(erfc(t1) - erfc(t2));
end

function Ans = Q_fun(Lambda, n)
u1 = factorial(n);
u3 = Lambda.^n
u2 = exp(-Lambda)*u3;
Ans = u2/u1;
end