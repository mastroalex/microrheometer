function dydt=zener_displacement(t,y,parameters,tspan,flag)
% zener body function to describe displacement
% switch for different input do vary the force waveform
k_0=parameters(1);
k_1=parameters(2);
gamma_0=parameters(3);
gamma_1=parameters(4);
F_bar=parameters(5);
switch flag
    case 'square'
        % call force() subroutine to compute displacement
        [F, dF]=force(t,tspan);
        dydt=((F-k_0*y)/gamma_1 + (dF/k_1))*(1+k_0/k_1);
    case 'step'
        dydt=(-(k_0/gamma_1)*y+(F_bar/gamma_1))/(1+(k_0/k_1));
    case 'harmonic'
        omega=parameters(7);
        F=F_bar*(1+sin(omega*t));
        dF=F_bar*omega*cos(omega*t);
        dydt=((F-k_0*y)/gamma_1 + (dF/k_1))*(1+k_0/k_1);
end
end