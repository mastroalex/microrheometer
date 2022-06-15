function create_graphs(flag,t,tspan,yz,yd,parameters)
% plot displacement 

% load parameters
k_0=parameters(1);
k_1=parameters(2);
gamma_0=parameters(3);
gamma_1=parameters(4);
F_bar=parameters(5);
tau=parameters(6);
omega=parameters(7);
% compute scale factor to scale pN and um 
scale_factor=1e-12*1e6;

% setup color
red='#A2142F';
blue='#0072BD';
green='#77AC30';
% create figure with different color and limit by switching over flag
figure
switch flag

    case 'square'
        colororder({green})
        plot(t,scale_factor*(yd+yz),'-','Color',blue,'LineWidth',2)
        ylim([0,1.2])
        ylabel('Displacement [{\mu}m]')
        [F, dF]=force(t,tspan);
        hold on
        yyaxis right
        ylim([0,20000])
        plot(t,F,'--','Color',green);
        ylabel('Force [pN]','Color',green)
        xlabel('Time [s]')
    case 'step'
        y=yz+yd;
        colororder({green})
        plot(t,scale_factor*y,'o','Color',blue)
        hold on
        x_anal=solution(flag,t,parameters);
        ylabel('Displacement [{\mu}m]')
        plot(t,scale_factor*x_anal,'Color',red,'LineWidth',2)
        hold on
        yyaxis right
        ylabel('Force [pN]','Color',green)
        plot([-0.05,0,0,t(end)],[0,0,2000,2000],'--','Color',green)
        ylim([0,8000])
        xlim([-0.05,t(end)])
        legend({'numerical','analytic','input'},'Location','southeast')
        xlabel('Time [s]')
    case 'harmonic'
        colororder({green})
        y=yd+yz;
        plot(t,scale_factor*(y),'o','Color',blue)
        ylabel('Displacement [{\mu}m]')
        hold on
        F=F_bar*(1+sin(omega*t));
        x_anal=solution(flag,t,parameters);
        plot(t,x_anal*1e-6,'Color',red,'LineWidth',2)
        xlabel('Time [s]')
        yyaxis right
        ylim([0,20000])
        plot(t,F,'--','Color',green);
        ylabel('Force [pN]','Color',green)
        legend({'numerical','analytic','input'},'Location','northwest')


end





end