function x_anal=solution(flag,t,parameters)
k_0=parameters(1);
k_1=parameters(2);
gamma_0=parameters(3);
gamma_1=parameters(4);
F_bar=parameters(5);
tau=parameters(6);
omega=parameters(7);
if isequal(flag,'step')
    x_anal=(F_bar/gamma_0)*t+(F_bar/k_0)*(1-(k_1/(k_0+k_1))*exp(-t./tau) );
end

if isequal(flag,'harmonic')
       x_anal_z=(F_bar/k_0 )*(1 - ((k_0/(k_0+k_1))*exp(-t./tau))+ ...
            (tau*omega*(1-(gamma_1/(k_1*tau)))*(exp(-t./tau)-cos(omega*t))+(1+(gamma_1*tau*omega^2/k_1))*sin(omega*t))/(1+(tau*omega)^2) );
        x_anal_d=(F_bar/gamma_0).*(t+1/omega-cos(omega*t)/omega);
        x_anal=x_anal_z+x_anal_d;
end