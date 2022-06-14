% plot figures of regularized square wave

close all
T_cyc=5; % 5 s
N_cyc=4; % numero di cicli
tspan=0:0.01:T_cyc*N_cyc;
[F, dF]=force(tspan,tspan);
figure;plot(tspan,F*1e-3,'LineWidth',2);
ylabel('Force [pN]')
ylim([-3, 3])
yyaxis right
hold on;plot(tspan,dF)
set(gca,'YTick',[0])
ylabel('(d/dt) Force')
xlabel('Time [s]')
exportgraphics(figure(1),strcat('figs/','square_regularized','.pdf'),'BackgroundColor','none','ContentType','vector');