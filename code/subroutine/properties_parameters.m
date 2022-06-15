% load propeterties and parameters

k_sum=0.01; %[Pa m]
k_0=k_sum/2; %[Pa m]
k_1=k_sum/2; %[Pa m]
gamma_0=0.031; %[Pa ms]
F_bar=2000; %[pN]
tau=0.09; %[s] 
gamma_1= tau*(k_0*k_1)/(k_0+k_1); %[Pa ms]
y0=F_bar/(k_0+k_1); % initial condition
f=0.15; % frequency 
omega=2*pi*f;
% join all parameters inside an array
parameters=[k_0,k_1,gamma_0,gamma_1,F_bar,tau,omega];