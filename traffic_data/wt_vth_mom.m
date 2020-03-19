% Plotting all moments from all cities


vth = 2.5:2.5:20;

load('waiting_times_bomb_bang_del_5_to_40_2013_fullyear_half.mat','x1a','x2a','x3a','x4a','y1a','y2a','y3a','y4a','z1a','z2a','z3a','z4a');
load('Waiting_time_taxis_half_avg_2_5_to_37_5_bombay_bang_delhi_fullyear2013.mat','fx1a','fx2a','fx3a','fx4a','fy1a','fy2a','fy3a','fy4a','fz1a','fz2a','fz3a','fz4a');

x1a = x1a(x1a~=0);
x2a = x2a(x2a~=0);
x3a = x3a(x3a~=0);
x4a = x4a(x4a~=0);
y1a = y1a(y1a~=0);
y2a = y2a(y2a~=0);
y3a = y3a(y3a~=0);
y4a = y4a(y4a~=0);
z1a = z1a(z1a~=0);
z2a = z2a(z2a~=0);
z3a = z3a(z3a~=0);
z4a = z4a(z4a~=0);

fx1a = fx1a(fx1a~=0);
fx2a = fx2a(fx2a~=0);
fx3a = fx3a(fx3a~=0);
fx4a = fx4a(fx4a~=0);
fy1a = fy1a(fy1a~=0);
fy2a = fy2a(fy2a~=0);
fy3a = fy3a(fy3a~=0);
fy4a = fy4a(fy4a~=0);
fz1a = fz1a(fz1a~=0);
fz2a = fz2a(fz2a~=0);
fz3a = fz3a(fz3a~=0);
fz4a = fz4a(fz4a~=0);

avgx = zeros(2,8);
mom2x = zeros(2,8);
mom3x = zeros(2,8);
mom4x = zeros(2,8);
kurtx = zeros(2,8);
covx = zeros(2,8);

avgy = zeros(2,8);
mom2y = zeros(2,8);
mom3y = zeros(2,8);
mom4y = zeros(2,8);
kurty = zeros(2,8);
covy = zeros(2,8);

avgz = zeros(2,8);
mom2z = zeros(2,8);
mom3z = zeros(2,8);
mom4z = zeros(2,8);
kurtz = zeros(2,8);
covz = zeros(2,8);

avgx(1,1:end) = vth;
mom2x(1,1:end) = vth;
mom3x(1,1:end) = vth;
mom4x(1,1:end) = vth;
kurtx(1,1:end) = vth;
covx(1,1:end) = vth;

avgy(1,1:end) = vth;
mom2y(1,1:end) = vth;
mom3y(1,1:end) = vth;
mom4y(1,1:end) = vth;
kurty(1,1:end) = vth;
covy(1,1:end) = vth;

avgz(1,1:end) = vth;
mom2z(1,1:end) = vth;
mom3z(1,1:end) = vth;
mom4z(1,1:end) = vth;
kurtz(1,1:end) = vth;
covz(1,1:end) = vth;

avgx(2,1) = mean(fx1a);
avgx(2,2) = mean(x1a);
avgx(2,3) = mean(fx2a);
avgx(2,4) = mean(x2a);
avgx(2,5) = mean(fx3a);
avgx(2,6) = mean(x3a);
avgx(2,7) = mean(fx4a);
avgx(2,8) = mean(x4a);


mom2x(2,1) = moment(fx1a,2);
mom2x(2,2) = moment(x1a,2);
mom2x(2,3) = moment(fx2a,2);
mom2x(2,4) = moment(x2a,2);
mom2x(2,5) = moment(fx3a,2);
mom2x(2,6) = moment(x3a,2);
mom2x(2,7) = moment(fx4a,2);
mom2x(2,8) = moment(x4a,2);

mom3x(2,1) = moment(fx1a,3);
mom3x(2,2) = moment(x1a,3);
mom3x(2,3) = moment(fx2a,3);
mom3x(2,4) = moment(x2a,3);
mom3x(2,5) = moment(fx3a,3);
mom3x(2,6) = moment(x3a,3);
mom3x(2,7) = moment(fx4a,3);
mom3x(2,8) = moment(x4a,3);

mom4x(2,1) = moment(fx1a,4);
mom4x(2,2) = moment(x1a,4);
mom4x(2,3) = moment(fx2a,4);
mom4x(2,4) = moment(x2a,4);
mom4x(2,5) = moment(fx3a,4);
mom4x(2,6) = moment(x3a,4);
mom4x(2,7) = moment(fx4a,4);
mom4x(2,8) = moment(x4a,4);

kurtx(2,1) = kurtosis(fx1a);
kurtx(2,2) = kurtosis(x1a);
kurtx(2,3) = kurtosis(fx2a);
kurtx(2,4) = kurtosis(x2a);
kurtx(2,5) = kurtosis(fx3a);
kurtx(2,6) = kurtosis(x3a);
kurtx(2,7) = kurtosis(fx4a);
kurtx(2,8) = kurtosis(x4a);

covx(2,1) = std(fx1a)./mean(fx1a);
covx(2,2) = std(x1a)./mean(x1a);
covx(2,3) = std(fx2a)./mean(fx2a);
covx(2,4) = std(x2a)./mean(x2a);
covx(2,5) = std(fx3a)./mean(fx3a);
covx(2,6) = std(x3a)./mean(x3a);
covx(2,7) = std(fx4a)./mean(fx4a);
covx(2,8) = std(x4a)./mean(x4a);

avgy(2,1) = mean(fy1a);
avgy(2,2) = mean(y1a);
avgy(2,3) = mean(fy2a);
avgy(2,4) = mean(y2a);
avgy(2,5) = mean(fy3a);
avgy(2,6) = mean(y3a);
avgy(2,7) = mean(fy4a);
avgy(2,8) = mean(y4a);


mom2y(2,1) = moment(fy1a,2);
mom2y(2,2) = moment(y1a,2);
mom2y(2,3) = moment(fy2a,2);
mom2y(2,4) = moment(y2a,2);
mom2y(2,5) = moment(fy3a,2);
mom2y(2,6) = moment(y3a,2);
mom2y(2,7) = moment(fy4a,2);
mom2y(2,8) = moment(y4a,2);

mom3y(2,1) = moment(fy1a,3);
mom3y(2,2) = moment(y1a,3);
mom3y(2,3) = moment(fy2a,3);
mom3y(2,4) = moment(y2a,3);
mom3y(2,5) = moment(fy3a,3);
mom3y(2,6) = moment(y3a,3);
mom3y(2,7) = moment(fy4a,3);
mom3y(2,8) = moment(y4a,3);

mom4y(2,1) = moment(fy1a,4);
mom4y(2,2) = moment(y1a,4);
mom4y(2,3) = moment(fy2a,4);
mom4y(2,4) = moment(y2a,4);
mom4y(2,5) = moment(fy3a,4);
mom4y(2,6) = moment(y3a,4);
mom4y(2,7) = moment(fy4a,4);
mom4y(2,8) = moment(y4a,4);

kurty(2,1) = kurtosis(fy1a);
kurty(2,2) = kurtosis(y1a);
kurty(2,3) = kurtosis(fy2a);
kurty(2,4) = kurtosis(y2a);
kurty(2,5) = kurtosis(fy3a);
kurty(2,6) = kurtosis(y3a);
kurty(2,7) = kurtosis(fy4a);
kurty(2,8) = kurtosis(y4a);

covy(2,1) = std(fy1a)./mean(fy1a);
covy(2,2) = std(y1a)./mean(y1a);
covy(2,3) = std(fy2a)./mean(fy2a);
covy(2,4) = std(y2a)./mean(y2a);
covy(2,5) = std(fy3a)./mean(fy3a);
covy(2,6) = std(y3a)./mean(y3a);
covy(2,7) = std(fy4a)./mean(fy4a);
covy(2,8) = std(y4a)./mean(y4a);

avgz(2,1) = mean(fz1a);
avgz(2,2) = mean(z1a);
avgz(2,3) = mean(fz2a);
avgz(2,4) = mean(z2a);
avgz(2,5) = mean(fz3a);
avgz(2,6) = mean(z3a);
avgz(2,7) = mean(fz4a);
avgz(2,8) = mean(z4a);


mom2z(2,1) = moment(fz1a,2);
mom2z(2,2) = moment(z1a,2);
mom2z(2,3) = moment(fz2a,2);
mom2z(2,4) = moment(z2a,2);
mom2z(2,5) = moment(fz3a,2);
mom2z(2,6) = moment(z3a,2);
mom2z(2,7) = moment(fz4a,2);
mom2z(2,8) = moment(z4a,2);

mom3z(2,1) = moment(fz1a,3);
mom3z(2,2) = moment(z1a,3);
mom3z(2,3) = moment(fz2a,3);
mom3z(2,4) = moment(z2a,3);
mom3z(2,5) = moment(fz3a,3);
mom3z(2,6) = moment(z3a,3);
mom3z(2,7) = moment(fz4a,3);
mom3z(2,8) = moment(z4a,3);

mom4z(2,1) = moment(fz1a,4);
mom4z(2,2) = moment(z1a,4);
mom4z(2,3) = moment(fz2a,4);
mom4z(2,4) = moment(z2a,4);
mom4z(2,5) = moment(fz3a,4);
mom4z(2,6) = moment(z3a,4);
mom4z(2,7) = moment(fz4a,4);
mom4z(2,8) = moment(z4a,4);

kurtz(2,1) = kurtosis(fz1a);
kurtz(2,2) = kurtosis(z1a);
kurtz(2,3) = kurtosis(fz2a);
kurtz(2,4) = kurtosis(z2a);
kurtz(2,5) = kurtosis(fz3a);
kurtz(2,6) = kurtosis(z3a);
kurtz(2,7) = kurtosis(fz4a);
kurtz(2,8) = kurtosis(z4a);

covz(2,1) = std(fz1a)./mean(fz1a);
covz(2,2) = std(z1a)./mean(z1a);
covz(2,3) = std(fz2a)./mean(fz2a);
covz(2,4) = std(z2a)./mean(z2a);
covz(2,5) = std(fz3a)./mean(fz3a);
covz(2,6) = std(z3a)./mean(z3a);
covz(2,7) = std(fz4a)./mean(fz4a);
covz(2,8) = std(z4a)./mean(z4a);


figure, plot(avgx(1,1:end),avgx(2,1:end));
hold on, plot(avgy(1,1:end),avgy(2,1:end),'r');
hold on, plot(avgz(1,1:end),avgz(2,1:end),'k');

figure, plot(mom2x(1,1:end),mom2x(2,1:end));
hold on, plot(mom2y(1,1:end),mom2y(2,1:end),'r');
hold on, plot(mom2z(1,1:end),mom2z(2,1:end),'k');

figure, plot(mom3x(1,1:end),mom3x(2,1:end));
hold on, plot(mom3y(1,1:end),mom3y(2,1:end),'r');
hold on, plot(mom3z(1,1:end),mom3z(2,1:end),'k');

figure, plot(mom4x(1,1:end),mom4x(2,1:end));
hold on, plot(mom4y(1,1:end),mom4y(2,1:end),'r');
hold on, plot(mom4z(1,1:end),mom4z(2,1:end),'k');

figure, plot(kurtx(1,1:end),kurtx(2,1:end));
hold on, plot(kurty(1,1:end),kurty(2,1:end),'r');
hold on, plot(kurtz(1,1:end),kurtz(2,1:end),'k');

figure, plot(covx(1,1:end),covx(2,1:end));
hold on, plot(covy(1,1:end),covy(2,1:end),'r');
hold on, plot(covz(1,1:end),covz(2,1:end),'k');


