function [F, dF]=force(t_curr,t)
% setup time 
T_cyc=5; % 5 s
% number of cycle
N_cyc=4; 
%t=0:0.01:T_cyc*N_cyc;
% amplitude
F=2000;
freq=1/T_cyc;
% make square wave
squareWave=F/2*(square(2*pi*freq*t,50)+1);
squareWave(end)=0;
% smooth square wave with gaussian filter
squareWave_smooth=smoothdata(squareWave,'gaussian',(size(t)/N_cyc)*0.05);
% compute differenziation by adding 1 sample (= zero) to obtain same length
% for F and dF
derivate=[0 diff(squareWave_smooth)];

% compute interpolation for read value in every time
F=interp1(t,squareWave_smooth,t_curr);
dF=interp1(t,derivate,t_curr);
end



