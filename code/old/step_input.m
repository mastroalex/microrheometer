k_sum=0.01; %[Pa m]
k_0=k_sum/2;
k_1=k_sum/2;
gamma_0=0.031;
F_bar=2000; %[pN]
tau=0.09; %[s]
gamma_1= tau*(k_0*k_1)/(k_0+k_1);
parameters=[k_0,k_1,gamma_0,gamma_1,F_bar];

y0=F_bar/(k_0+k_1);
tspan=0:0.01:2;

[t,yz] = ode15s(@(t,y) odefcn(t,y,parameters),tspan,y0);

%%%%%%%%%%%%% [t,y] = ode15s(@(t,y) odefcn(t,y),[0 10],y0);
yd=(F_bar/gamma_0)*t;
y=yz+yd;
figure;plot(t,y,'o')
hold on
x_anal=(F_bar/gamma_0)*t+(F_bar/k_0)*(1-(k_1/(k_0+k_1))*exp(-t./tau) );
plot(t,x_anal)


%parameters=[k_0,k_1,gamma_0,gamma_1,F_bar];

% [t,yz] = ode15s(@(t,y) zener_displacement(t,y,parameters,tspan),tspan,0);
% [t,yd] = ode15s(@(t,y) dashpot_displacement(t,y,parameters,tspan),tspan,0);


function dydt=odefcn(t,y,parameters)
k_0=parameters(1);
k_1=parameters(2);
gamma_0=parameters(3);
gamma_1=parameters(4);
F_bar=parameters(5);
dydt=(-(k_0/gamma_1)*y+(F_bar/gamma_1))/(1+(k_0/k_1));
end

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


