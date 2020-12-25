close all;
clear all;
clc;

%Assigning parameters from simulation table
SNR_dB = 30:1:75; %Signal to Ratio in DB
%snrlin = 10.^(snrdb./10);
Radius = 45*10^(-9); %Radius of the Receiver
d = 500*10^(-9); %Distance between the transmitter and Receiver
D = 4.265*10^(-10); %Diffusion coefficient
L =10; %Channel Length
Lambda0 = 100;
T = 30*9*10^(-6); %Slot Length
C0 = 2*Lambda0*T*10.^(SNR_dB./10); 
P0 = p(Radius,d,D,T,0);
NTx = 2*Lambda0*T*10.^(SNR_dB./10)./P0;
%NTx = 100.* ones(1,length(snrdb))
%Vector of P for 1 to L=10 time slots
P = [p(Radius,d,D,T,1) p(Radius,d,D,T,2) p(Radius,d,D,T,3) p(Radius,d,D,T,4) p(Radius,d,D,T,5) p(Radius,d,D,T,6) p(Radius,d,D,T,7) p(Radius,d,D,T,8) p(Radius,d,D,T,9) p(Radius,d,D,T,10)];
 
%For each value of snr first finding op_tou and then using op_tou finding
%BER

tau = (0:60);
%Finding Tou minimum for particular SNR
for kk=1:length(SNR_dB)
for i= 1:length(tau)
    Ber(i) = 0;
     c = NTx(kk)*P;   %For given snr finding C for i=1 to L=5 time slots
     s_t = (0:1023);    %permutations of 10 bits slot
     s = de2bi(s_t);  %Permutation vector
     ISI = s*c';      %ISI for given SNR 32x1 vector
 
     %Equation number 14 for each tou
     for k=1:length(ISI)
      Pe(k) =(0.5*(gammainc(Lambda0*T + ISI(k),ceil(tau(i)))) + 1 - gammainc(Lambda0*T + C0(kk) + ISI(k) ,ceil(tau(i))));
      Ber(i) = Ber(i) + Pe(k);   %Adding BER of each permutation 
    end
  Ber(i) = (1/2^L)*Ber(i);
end
[tm,min_in] = min(Ber); %Tou with minimum BER
op_tau(kk) = tau(min_in); %Tou
end



index=1;
for j=1:length(SNR_dB)
Si = rand(1,100)>0.5;
C0 = 2*Lambda0*T*10.^(SNR_dB(j)./10);
tmp = poissrnd(Lambda0*T + Si*C0);

for i=1:length(tmp)
ri(index) = tmp(i);
if(tmp(i)>op_tau(j))
bit_detect(index) = 1;
else
bit_detect(index) =0;
end
index = index +1;
end
end
bit_detect = bit_detect';
ri = ri';

function p = p(Radius,d,D,T,i)
p = (Radius/d).*(erfc((d-Radius)./sqrt(4*D*(i+1)*T)) - erfc((d-Radius)./sqrt(4*D*i*T)));

end