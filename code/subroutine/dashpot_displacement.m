function dydt=dashpot_displacement(t,y,parameters,tspan,flag)
% dahspot function to describe displacement
% switch for different input do vary the force waveform
gamma_0=parameters(3);
gamma_1=parameters(4);
F_bar=parameters(5);
switch flag
    case 'square'
        % call force() subroutine to comput square wave and differentiation
        [F, dF]=force(t,tspan);
        dydt=F/gamma_0;
    case 'step'
        dydt=F_bar/gamma_0;
    case 'harmonic'
        omega=parameters(7);
        F=F_bar*(1+sin(omega.*t));
        dF=F_bar*omega*cos(omega*t);
        dydt=F/gamma_0;
end
end