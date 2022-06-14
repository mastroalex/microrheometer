function [F, dF]=force2(t_curr,t)

T_cyc=5; % 5 s
N_cyc=4; % numero di cicli
%t=0:0.01:T_cyc*N_cyc;
F=2000;
freq=1/T_cyc;
squareWave=F/2*(square(2*pi*freq*t,50)+1);
squareWave(end)=0;
squareWave(1:floor(length(t)*0.05))=0;
squareWave(floor(length(t)*0.05)+1:end)=F;


squareWave_smooth=smoothdata(squareWave,'gaussian',(size(t)/N_cyc)*0.05);
derivate=[0 diff(squareWave_smooth)];

 F=interp1(t,squareWave_smooth,t_curr);
 dF=interp1(t,derivate,t_curr);
end