k_sum=0.01; %[Pa m]
k_0=k_sum/2;
k_1=k_sum/2;
gamma_0=0.031;
F_bar=2000; %[pN]
tau=0.09; %[s]
gamma_1= tau*(k_0*k_1)/(k_0+k_1);

y0=F_bar/(k_0+k_1);
f=0.15;
omega=2*pi*f;
parameters=[k_0,k_1,gamma_0,gamma_1,F_bar,tau,omega];