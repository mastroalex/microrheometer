% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Mastrofini Alessandro
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Medical Engineering - University of Rome Tor Vergata
% Physiological Systems Modeling and Simulation
% F. Caselli, MSSF A.Y. 2021/2022
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Microrheometer and mechanical model of cells
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

clear all
close all
clc
% add path for subroutines in subfolder
addpath('subroutine/');

% load material parameters
properties_parameters

% select the input waveform by uncomment the flag
flag='harmonic';
% flag='square';
% flag='step';

% use this part to change frequency loaded by properties_parameters
% f=0.8;
% omega=2*pi*f;
% parameters=[k_0,k_1,gamma_0,gamma_1,F_bar,tau,omega];

% set time span
switch flag
    case 'square'
        T_cyc=5; % 5 s
        N_cyc=4; % numero di cicli
        tspan=0:0.01:T_cyc*N_cyc;
    case 'step'
        tspan=0:0.01:2;
    case 'harmonic'
        tspan=0:0.1:20;
end

% solve the model
[t,yz] = ode15s(@(t,y) zener_displacement(t,y,parameters,tspan,flag),tspan,y0);
[t,yd] = ode15s(@(t,y) dashpot_displacement(t,y,parameters,tspan,flag),tspan,0);

% plot 
create_graphs(flag,t,tspan,yz,yd,parameters);

%exportgraphics(figure(1),strcat('figs/',flag,'.pdf'),'BackgroundColor','none','ContentType','vector');

% plot separate displacements
scale_factor=1e-12*1e6;
figure; plot(t,scale_factor*yz,'-','LineWidth',2,'Color','#D95319')
ylabel('Displacement  [{\mu}m]')
xlabel('Time  [s]')
title('Zener body')
grid on
figure; plot(t,scale_factor*yd,'-','LineWidth',2,'Color','#D95319')
ylabel('Displacement  [{\mu}m]')
xlabel('Time  [s]')
title('Dashpot')
grid on

exportgraphics(figure(2),strcat('figs/',flag,'_zener_','.pdf'),'BackgroundColor','none','ContentType','vector');
exportgraphics(figure(3),strcat('figs/',flag,'_dashpot_','.pdf'),'BackgroundColor','none','ContentType','vector');
