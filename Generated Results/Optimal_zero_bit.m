clear all;
close all;
Tau = (20:120); %Range of values for Tau between 20 and 120
SNR = 30; % Signal to Noise Ratio
L=5; % Channel Length
Time_slot = (1:5); 
Lambda0 = 100;
T2 = 50*9*(10^-6);
T1 = 30*9*(10^-6);
Radius = 45*(10^-9);  % Receiver Radius
d = 500*(10^-9); %Distance between the transmitter and Receiver
D = 4.265*(10^-10); %Diffusion Constant


for i = 1:length(Time_slot)
    P_i1(i) = (Radius/d)*(erfc((d-Radius)/sqrt(4*D*i*T2))-erfc((d-Radius)/sqrt(4*D*(i-1)*T2)));   
end

NTX = 2*Lambda0*T2*10^(SNR/10)/P_i1(1);

for i = 1:length(Time_slot)
    P_i2(i) = (Radius/d)*(erfc((d-Radius)/sqrt(4*D*i*T1))-erfc((d-Radius)/sqrt(4*D*(i-1)*T1)));
end

NTX2 = 2*Lambda0*T1*10^(SNR/10)/P_i2(1);

for j = 1:length(Time_slot)
    CJ(j) = NTX*P_i1(j);
    CJ2(j) = NTX2*P_i2(j);
    
SJ = randi([0, 1], 1, j);

for i = 1:length(Tau)
    P_e(i) = 0.5*(gammainc((Lambda0*T2 + sum(SJ.*CJ)), Tau(i)) + 1 - gammainc((Lambda0*T2 + sum(SJ.*CJ) + CJ(1)), Tau(i)));
    P_e2(i) = 0.5*(gammainc((Lambda0*T1 + sum(SJ.*CJ2)), Tau(i)) + 1 - gammainc((Lambda0*T1 + sum(SJ.*CJ2) + CJ2(1)), Tau(i)));
end

end
P_eTau = (P_e)/(2^L);
P_eTau2 = (P_e2)/(2^L);
close all;
figure
semilogy(Tau, P_eTau2);
hold on
semilogy(Tau, P_eTau);
axis([20 120 10^-(8) 10^-(1)]) 
legend('slot length 30T','slot length 50T')
xlabel('threshold')
ylabel('BER')