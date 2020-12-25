SNR_dB =1:1:60; %Signal to Noise Ratio in DB
SNR = 10.^(SNR_dB/10); %Converting SNR in linear value

Lambda = 100; 
Radius = 45e-9; %Radius of the receiver
d = 500e-9; %Distance between the transmitter and receiver
D = 4.265e-10; %Diffusion coefficient
Delta_T = 9e-6; %Discrete time length
T = 30*Delta_T; %Slot length
L = 5; %Channel Length
global sum_Cj;
sum=0;
sum1=0;
X = 0:1:60;
sum_Cj=0;
Co = zeros(1,length(SNR_dB));

data = rand(1,L)>0.5;

for ii=1:1:5
    sum = sum + Cj_fun(ii);
    sum1 = sum1 + data(ii)*Cj_fun(ii);
end
Avg = sum + Lambda*T;
Avg1 = avg + 20;
Final_term = 100000;

for ii=1:1:length(SNR_dB)
    Co(ii) = SNR(ii)*2*Lambda*T;
    A = sec_term(Co(ii), Avg);
Pe(ii)= 0.5 - 0.5*(A); % PLOT FOR SUB OPTIMAL APPROACH
for jj=1:1:length(X) % finding min tao for the optimal approach for a given Co
Lam1 = Lambda*T + sum1;
Lam2 = Lam1 + Co(ii);
First_term = Q_fun(Lam1, X(jj));
Last_term = 1 - Q_fun(Lam2, X(jj));
Final_term_next = 0.5*(First_term + Last_term);

if(Final_term_next < Final_term)
Final_term = Final_term_next;
Final_tau = X(jj);
end
end
B = sec_term1(Co(ii), Avg, Final_tau);
Pe1(ii) = 0.5 - 0.5*(B);
end
close all;
figure;
plot(SNR_dB, Pe, '-.ro');
hold on
plot(SNR_dB, Pe1, '-.b*');
legend('Optimal zero bit mem. Rx. BER', 'Equiprobability zer bit mem. Rx. BER');
xlabel('SNR(dB)')
ylabel('BER')
%---- functions ------
%%
function ans1 = sec_term(Co1, avg1)
t3 = Co1/avg1;
t2 = log(1+t3);
t1 = Co1/t2; % tao
ans1 = 0;
lg0 = avg1;
lg1 = avg1 + Co1;
for jj=0:1:t1
d1 = lg0^(jj) * exp(-lg0);
d2 = lg1^(jj) * exp(-lg1);
ans1 = ans1 + (d1-d2)/factorial(jj);
end
end
function ans2 = sec_term1(Co1, avg1, final_tao)
ans2 = 0;
lg0 = avg1;
lg1 = avg1 + Co1;
for jj=0:1:final_tao
d1 = lg0^(jj) * exp(-lg0);
d2 = lg1^(jj) * exp(-lg1);
ans2 = ans2 + (d1-d2)/factorial(jj);
end
end
function sum_Cj = Cj_fun(j)
Ntx = 10^2;
global sum_Cj;
sum_Cj = sum_Cj + Ntx*prob_j(j);
%Ntx*prob_j(j)
end
function y = prob_j(j)
lambda = 100;
r = 45e-9;
d = 500e-9;
D = 4.265e-10;
delta_T = 9e-6;
T = 30*delta_T;
L = 5;
x = r/d;
t1 = ((d-r)/(sqrt(4*D*(j+1)*T)));
t2 = ((d-r)/(sqrt(4*D*(j)*T)));
y = x*(erfc(t1) - erfc(t2));
end
function ans = Q_fun(lambda, n)
u1 = factorial(n);
u3 = lambda.^n;
u2 = exp(-lambda)*u3;
ans = u2/u1;
end