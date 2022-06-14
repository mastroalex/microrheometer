clear all
close all
clc

addpath('subroutine/');

properties_parameters

% flag='harmonic';
% flag='square';
flag='step';


switch flag
    case 'square'
        T_cyc=5; % 5 s
        N_cyc=4; % numero di cicli
        tspan=0:0.01:T_cyc*N_cyc;
    case 'step'
        tspan=0:0.01:2;
    case 'harmonic'
        tspan=0:0.01:20;
end

[t,yz] = ode15s(@(t,y) zener_displacement(t,y,parameters,tspan,flag),tspan,y0);
[t,yd] = ode15s(@(t,y) dashpot_displacement(t,y,parameters,tspan,flag),tspan,0);

create_graphs(flag,t,tspan,yz,yd,parameters);

exportgraphics(figure(1),strcat('figs/',flag,'.pdf'),'BackgroundColor','none','ContentType','vector');