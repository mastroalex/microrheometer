k_sum=0.01; %[Pa m]
k_0=k_sum/2;
k_1=k_sum/2;
gamma_0=0.031;
F_bar=2000; %[pN]
tau=0.09; %[s]
gamma_1= tau*(k_0*k_1)/(k_0+k_1);
parameters=[k_0,k_1,gamma_0,gamma_1,F_bar];

y0=F_bar/(k_0+k_1);

tspan=[1,100];
%[t,y] = ode15s(@(t,y) odefcn(t,y,parameters),tspan,y0);

%%%%%%%%%%%%% [t,y] = ode15s(@(t,y) odefcn(t,y),[0 10],y0);

%figure;plot(t,y)



T_cyc=5; % 5 s
N_cyc=4; % numero di cicli
tspan=0:0.01:T_cyc*N_cyc;
f=0.1;
omega=2*pi*f;
parameters=[k_0,k_1,gamma_0,gamma_1,F_bar,omega];

[t,yz] = ode15s(@(t,y) zener_displacement(t,y,parameters,tspan),tspan,y0);
[t,yd] = ode15s(@(t,y) dashpot_displacement(t,y,parameters,tspan),tspan,0);


% function dydt=odefcn(t,y,parameters)
% k_0=parameters(1);
% k_1=parameters(2);
% gamma_0=parameters(3);
% gamma_1=parameters(4);
% F_bar=parameters(5);
% dydt=(-(k_0/gamma_1)*y+(F_bar/gamma_1))/(1+(k_0/k_1));
% end

% function dydt=odefcn(t,y)
% k_sum=0.01; %[Pa m]
% k_0=k_sum/2;
% k_1=k_sum/2;
% gamma_0=0.031;
% F_bar=2000; %[pN]
% 
% gamma_1=gamma_0;
% dydt=(-(k_0/k_1)*y+(F_bar/gamma_1))/(1+(k_0/k_1));
% end

figure;
yyaxis left
plot(t,1e-12*(yd+yz)*1e6,'o')
%figure;plot(t,yd)
hold on
F=F_bar*(1+sin(omega*t));
x_anal_z=(F_bar/k_0 )*(1 - ((k_0/(k_0+k_1))*exp(-t./tau))+ ...
    (tau*omega*(1-(gamma_1/(k_1*tau)))*(exp(-t./tau)-cos(omega*t))+(1+(gamma_1*tau*omega^2/k_1))*sin(omega*t))/(1+(tau*omega)^2) );
x_anal_d=(F_bar/gamma_0).*(t-cos(omega*t)/omega);
x_anal=x_anal_z+x_anal_d;
plot(t,x_anal*1e-6,'-r','LineWidth',2)

hold on
yyaxis right
ylim([0,10000])
plot(t,F);
hold on






function dydt=zener_displacement(t,y,parameters,tspan)
k_0=parameters(1);
k_1=parameters(2);
gamma_0=parameters(3);
gamma_1=parameters(4);
F_bar=parameters(5);
omega=parameters(6);

F=F_bar*(1+sin(omega*t));
dF=F_bar*omega*cos(omega*t);

dydt=((F-k_0*y)/gamma_1 + (dF/k_1))*(1+k_0/k_1);
end

function dydt=dashpot_displacement(t,y,parameters,tspan)
gamma_0=parameters(3);
gamma_1=parameters(4);
F_bar=parameters(5);
omega=parameters(6);
F=F_bar*(1+sin(omega.*t));
dF=F_bar*omega*cos(omega*t);
dydt=F/gamma_0;
end