% Lezione 22 - 24/05/2022
clear all
%% square wave
close all

T_cyc=5; % 5 s
N_cyc=4; % numero di cicli
t=0:0.01:T_cyc*N_cyc;
F=2000;
freq=1/T_cyc;
squareWave=F/2*(square(2*pi*freq*t,50)+1);
squareWave(end)=0;
figure;
plot(t,squareWave)
ylim([0,2500])
xlabel('time [s]')
ylabel(' [pN]')
xticks(1:1:T_cyc*N_cyc)

squareWave_smooth=smoothdata(squareWave,'gaussian',(size(t)/N_cyc)*0.05);

figure;
plot(t,squareWave)
ylim([0,2500])
xlabel('time [s]')
ylabel(' [pN]')
xticks(1:1:T_cyc*N_cyc)

derivate=[0 diff(squareWave_smooth)];
figure;
plot(t,derivate)

figure;
plot(t,squareWave_smooth)
hold on
scale=2*max(squareWave_smooth)/max(derivate);
plot(t,scale*derivate)
plot(t,squareWave)
legend({'smoothed', 'derivate with scale factor ','ideal square'},'Location','southwest')
