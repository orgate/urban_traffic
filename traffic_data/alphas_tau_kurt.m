
% taus = zeros(4,34);
% alphas = zeros(4,34);
kurt = zeros(4,34);

kurt(1,:) = [ 0.0250    0.0500    0.0750    0.1000    0.1250    0.1500 0.1750    0.2000    0.2250    0.2500    0.5000    0.7500 1.0000    1.2500    1.5000    1.7500    2.0000    2.2500 2.5000    5.0000    7.5000   10.0000   12.5000   15.0000 17.5000   20.0000   22.5000   25.0000   27.5000   30.0000 32.5000   35.0000   37.5000   40.0000];
% kurt(1,:) = taus(1,:);
% alphas(1,:) = taus(1,:);


load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x1');
x1 = x1(x1~=0);
kurt(2,1) = kurtosis(x1)
% taus(2,1) = mean(x1);
% [alphas(2,1),xmin,l] = plfit(x1)
clear x1;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x2');
x2 = x2(x2~=0);
kurt(2,2) = kurtosis(x2)
% taus(2,2) = mean(x2);
% [alphas(2,2),xmin,l] = plfit(x2)
clear x2;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x3');
x3 = x3(x3~=0);
kurt(2,3) = kurtosis(x3)
% taus(2,3) = mean(x3);
% [alphas(2,3),xmin,l] = plfit(x3)
clear x3;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x4');
x4 = x4(x4~=0);
kurt(2,4) = kurtosis(x4)
% taus(2,4) = mean(x4);
% [alphas(2,4),xmin,l] = plfit(x4)
clear x4;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x5');
x5 = x5(x5~=0);
kurt(2,5) = kurtosis(x5)
% taus(2,5) = mean(x5);
% [alphas(2,5),xmin,l] = plfit(x5)
clear x5;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x6');
x6 = x6(x6~=0);
kurt(2,6) = kurtosis(x6)
% taus(2,6) = mean(x6);
% [alphas(2,6),xmin,l] = plfit(x6)
clear x6;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x7');
x7 = x7(x7~=0);
kurt(2,7) = kurtosis(x7)
% taus(2,7) = mean(x7);
% [alphas(2,7),xmin,l] = plfit(x7)
clear x7;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x8');
x8 = x8(x8~=0);
kurt(2,8) = kurtosis(x8)
% taus(2,8) = mean(x8);
% [alphas(2,8),xmin,l] = plfit(x8)
clear x8;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x9');
x9 = x9(x9~=0);
kurt(2,9) = kurtosis(x9)
% taus(2,9) = mean(x9);
% [alphas(2,9),xmin,l] = plfit(x9)
clear x9;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x10');
x10 = x10(x10~=0);
kurt(2,10) = kurtosis(x10)
% taus(2,10) = mean(x10);
% [alphas(2,10),xmin,l] = plfit(x10)
clear x10;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x11');
x11 = x11(x11~=0);
kurt(2,11) = kurtosis(x11)
% taus(2,11) = mean(x11);
% [alphas(2,11),xmin,l] = plfit(x11)
clear x11;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x12');
x12 = x12(x12~=0);
kurt(2,12) = kurtosis(x12)
% taus(2,12) = mean(x12);
% [alphas(2,12),xmin,l] = plfit(x12)
clear x12;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x13');
x13 = x13(x13~=0);
kurt(2,13) = kurtosis(x13)
% taus(2,13) = mean(x13);
% [alphas(2,13),xmin,l] = plfit(x13)
clear x13;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x14');
x14 = x14(x14~=0);
kurt(2,14) = kurtosis(x14)
% taus(2,14) = mean(x14);
% [alphas(2,14),xmin,l] = plfit(x14)
clear x14;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x15');
x15 = x15(x15~=0);
kurt(2,15) = kurtosis(x15)
% taus(2,15) = mean(x15);
% [alphas(2,15),xmin,l] = plfit(x15)
clear x15;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x16');
x16 = x16(x16~=0);
kurt(2,16) = kurtosis(x16)
% taus(2,16) = mean(x16);
% [alphas(2,16),xmin,l] = plfit(x16)
clear x16;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x17');
x17 = x17(x17~=0);
kurt(2,17) = kurtosis(x17)
% taus(2,17) = mean(x17);
% [alphas(2,17),xmin,l] = plfit(x17)
clear x17;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x18');
x18 = x18(x18~=0);
kurt(2,18) = kurtosis(x18)
% taus(2,18) = mean(x18);
% [alphas(2,18),xmin,l] = plfit(x18)
clear x18;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x19');
x19 = x19(x19~=0);
kurt(2,19) = kurtosis(x19)
% taus(2,19) = mean(x19);
% [alphas(2,19),xmin,l] = plfit(x19)
clear x19;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x20');
x20 = x20(x20~=0);
kurt(2,20) = kurtosis(x20)
% taus(2,20) = mean(x20);
% [alphas(2,20),xmin,l] = plfit(x20)
clear x20;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x21');
x21 = x21(x21~=0);
kurt(2,21) = kurtosis(x21)
% taus(2,21) = mean(x21);
% [alphas(2,21),xmin,l] = plfit(x21)
clear x21;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x22');
x22 = x22(x22~=0);
kurt(2,22) = kurtosis(x22)
% taus(2,22) = mean(x22);
% [alphas(2,22),xmin,l] = plfit(x22)
clear x22;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x23');
x23 = x23(x23~=0);
kurt(2,23) = kurtosis(x23)
% taus(2,23) = mean(x23);
% [alphas(2,23),xmin,l] = plfit(x23)
clear x23;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x24');
x24 = x24(x24~=0);
kurt(2,24) = kurtosis(x24)
% taus(2,24) = mean(x24);
% [alphas(2,24),xmin,l] = plfit(x24)
clear x24;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x25');
x25 = x25(x25~=0);
kurt(2,25) = kurtosis(x25)
% taus(2,25) = mean(x25);
% [alphas(2,25),xmin,l] = plfit(x25)
clear x25;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x26');
x26 = x26(x26~=0);
kurt(2,26) = kurtosis(x26)
% taus(2,26) = mean(x26);
% [alphas(2,26),xmin,l] = plfit(x26)
clear x26;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x27');
x27 = x27(x27~=0);
kurt(2,27) = kurtosis(x27)
% taus(2,27) = mean(x27);
% [alphas(2,27),xmin,l] = plfit(x27)
clear x27;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x28');
x28 = x28(x28~=0);
kurt(2,28) = kurtosis(x28)
% taus(2,28) = mean(x28);
% [alphas(2,28),xmin,l] = plfit(x28)
clear x28;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x29');
x29 = x29(x29~=0);
kurt(2,29) = kurtosis(x29)
% taus(2,29) = mean(x29);
% [alphas(2,29),xmin,l] = plfit(x29)
clear x29;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x30');
x30 = x30(x30~=0);
kurt(2,30) = kurtosis(x30)
% taus(2,30) = mean(x30);
% [alphas(2,30),xmin,l] = plfit(x30)
clear x30;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x31');
x31 = x31(x31~=0);
kurt(2,31) = kurtosis(x31)
% taus(2,31) = mean(x31);
% [alphas(2,31),xmin,l] = plfit(x31)
clear x31;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x32');
x32 = x32(x32~=0);
kurt(2,32) = kurtosis(x32)
% taus(2,32) = mean(x32);
% [alphas(2,32),xmin,l] = plfit(x32)
clear x32;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x33');
x33 = x33(x33~=0);
kurt(2,33) = kurtosis(x33)
% taus(2,33) = mean(x33);
% [alphas(2,33),xmin,l] = plfit(x33)
clear x33;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','x34');
x34 = x34(x34~=0);
kurt(2,34) = kurtosis(x34)
% taus(2,34) = mean(x34);
% [alphas(2,34),xmin,l] = plfit(x34)
clear x34;







load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y1');
y1 = y1(y1~=0);
kurt(3,1) = kurtosis(y1)
% taus(3,1) = mean(y1);
% [alphas(3,1),xmin,l] = plfit(y1)
clear y1;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y2');
y2 = y2(y2~=0);
kurt(3,2) = kurtosis(y2)
% taus(3,2) = mean(y2);
% [alphas(3,2),xmin,l] = plfit(y2)
clear y2;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y3');
y3 = y3(y3~=0);
kurt(3,3) = kurtosis(y3)
% taus(3,3) = mean(y3);
% [alphas(3,3),xmin,l] = plfit(y3)
clear y3;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y4');
y4 = y4(y4~=0);
kurt(3,4) = kurtosis(y4)
% taus(3,4) = mean(y4);
% [alphas(3,4),xmin,l] = plfit(y4)
clear y4;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y5');
y5 = y5(y5~=0);
kurt(3,5) = kurtosis(y5)
% taus(3,5) = mean(y5);
% [alphas(3,5),xmin,l] = plfit(y5)
clear y5;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y6');
y6 = y6(y6~=0);
kurt(3,6) = kurtosis(y6)
% taus(3,6) = mean(y6);
% [alphas(3,6),xmin,l] = plfit(y6)
clear y6;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y7');
y7 = y7(y7~=0);
kurt(3,7) = kurtosis(y7)
% taus(3,7) = mean(y7);
% [alphas(3,7),xmin,l] = plfit(y7)
clear y7;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y8');
y8 = y8(y8~=0);
kurt(3,8) = kurtosis(y8)
% taus(3,8) = mean(y8);
% [alphas(3,8),xmin,l] = plfit(y8)
clear y8;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y9');
y9 = y9(y9~=0);
kurt(3,9) = kurtosis(y9)
% taus(3,9) = mean(y9);
% [alphas(3,9),xmin,l] = plfit(y9)
clear y9;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y10');
y10 = y10(y10~=0);
kurt(3,10) = kurtosis(y10)
% taus(3,10) = mean(y10);
% [alphas(3,10),xmin,l] = plfit(y10)
clear y10;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y11');
y11 = y11(y11~=0);
kurt(3,11) = kurtosis(y11)
% taus(3,11) = mean(y11);
% [alphas(3,11),xmin,l] = plfit(y11)
clear y11;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y12');
y12 = y12(y12~=0);
kurt(3,12) = kurtosis(y12)
% taus(3,12) = mean(y12);
% [alphas(3,12),xmin,l] = plfit(y12)
clear y12;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y13');
y13 = y13(y13~=0);
kurt(3,13) = kurtosis(y13)
% taus(3,13) = mean(y13);
% [alphas(3,13),xmin,l] = plfit(y13)
clear y13;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y14');
y14 = y14(y14~=0);
kurt(3,14) = kurtosis(y14)
% taus(3,14) = mean(y14);
% [alphas(3,14),xmin,l] = plfit(y14)
clear y14;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y15');
y15 = y15(y15~=0);
kurt(3,15) = kurtosis(y15)
% taus(3,15) = mean(y15);
% [alphas(3,15),xmin,l] = plfit(y15)
clear y15;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y16');
y16 = y16(y16~=0);
kurt(3,16) = kurtosis(y16)
% taus(3,16) = mean(y16);
% [alphas(3,16),xmin,l] = plfit(y16)
clear y16;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y17');
y17 = y17(y17~=0);
kurt(3,17) = kurtosis(y17)
% taus(3,17) = mean(y17);
% [alphas(3,17),xmin,l] = plfit(y17)
clear y17;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y18');
y18 = y18(y18~=0);
kurt(3,18) = kurtosis(y18)
% taus(3,18) = mean(y18);
% [alphas(3,18),xmin,l] = plfit(y18)
clear y18;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y19');
y19 = y19(y19~=0);
kurt(3,19) = kurtosis(y19)
% taus(3,19) = mean(y19);
% [alphas(3,19),xmin,l] = plfit(y19)
clear y19;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y20');
y20 = y20(y20~=0);
kurt(3,20) = kurtosis(y20)
% taus(3,20) = mean(y20);
% [alphas(3,20),xmin,l] = plfit(y20)
clear y20;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y21');
y21 = y21(y21~=0);
kurt(3,21) = kurtosis(y21)
% taus(3,21) = mean(y21);
% [alphas(3,21),xmin,l] = plfit(y21)
clear y21;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y22');
y22 = y22(y22~=0);
kurt(3,22) = kurtosis(y22)
% taus(3,22) = mean(y22);
% [alphas(3,22),xmin,l] = plfit(y22)
clear y22;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y23');
y23 = y23(y23~=0);
kurt(3,23) = kurtosis(y23)
% taus(3,23) = mean(y23);
% [alphas(3,23),xmin,l] = plfit(y23)
clear y23;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y24');
y24 = y24(y24~=0);
kurt(3,24) = kurtosis(y24)
% taus(3,24) = mean(y24);
% [alphas(3,24),xmin,l] = plfit(y24)
clear y24;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y25');
y25 = y25(y25~=0);
kurt(3,25) = kurtosis(y25)
% taus(3,25) = mean(y25);
% [alphas(3,25),xmin,l] = plfit(y25)
clear y25;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y26');
y26 = y26(y26~=0);
kurt(3,26) = kurtosis(y26)
% taus(3,26) = mean(y26);
% [alphas(3,26),xmin,l] = plfit(y26)
clear y26;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y27');
y27 = y27(y27~=0);
kurt(3,27) = kurtosis(y27)
% taus(3,27) = mean(y27);
% [alphas(3,27),xmin,l] = plfit(y27)
clear y27;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y28');
y28 = y28(y28~=0);
kurt(3,28) = kurtosis(y28)
% taus(3,28) = mean(y28);
% [alphas(3,28),xmin,l] = plfit(y28)
clear y28;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y29');
y29 = y29(y29~=0);
kurt(3,29) = kurtosis(y29)
% taus(3,29) = mean(y29);
% [alphas(3,29),xmin,l] = plfit(y29)
clear y29;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y30');
y30 = y30(y30~=0);
kurt(3,30) = kurtosis(y30)
% taus(3,30) = mean(y30);
% [alphas(3,30),xmin,l] = plfit(y30)
clear y30;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y31');
y31 = y31(y31~=0);
kurt(3,31) = kurtosis(y31)
% taus(3,31) = mean(y31);
% [alphas(3,31),xmin,l] = plfit(y31)
clear y31;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y32');
y32 = y32(y32~=0);
kurt(3,32) = kurtosis(y32)
% taus(3,32) = mean(y32);
% [alphas(3,32),xmin,l] = plfit(y32)
clear y32;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y33');
y33 = y33(y33~=0);
kurt(3,33) = kurtosis(y33)
% taus(3,33) = mean(y33);
% [alphas(3,33),xmin,l] = plfit(y33)
clear y33;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','y34');
y34 = y34(y34~=0);
kurt(3,34) = kurtosis(y34)
% taus(3,34) = mean(y34);
% [alphas(3,34),xmin,l] = plfit(y34)
clear y34;







load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z1');
z1 = z1(z1~=0);
kurt(4,1) = kurtosis(z1)
% taus(4,1) = mean(z1);
% [alphas(4,1),xmin,l] = plfit(z1)
clear z1;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z2');
z2 = z2(z2~=0);
kurt(4,2) = kurtosis(z2)
% taus(4,2) = mean(z2);
% [alphas(4,2),xmin,l] = plfit(z2)
clear z2;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z3');
z3 = z3(z3~=0);
kurt(4,3) = kurtosis(z3)
% taus(4,3) = mean(z3);
% [alphas(4,3),xmin,l] = plfit(z3)
clear z3;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z4');
z4 = z4(z4~=0);
kurt(4,4) = kurtosis(z4)
% taus(4,4) = mean(z4);
% [alphas(4,4),xmin,l] = plfit(z4)
clear z4;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z5');
z5 = z5(z5~=0);
kurt(4,5) = kurtosis(z5)
% taus(4,5) = mean(z5);
% [alphas(4,5),xmin,l] = plfit(z5)
clear z5;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z6');
z6 = z6(z6~=0);
kurt(4,6) = kurtosis(z6)
% taus(4,6) = mean(z6);
% [alphas(4,6),xmin,l] = plfit(z6)
clear z6;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z7');
z7 = z7(z7~=0);
kurt(4,7) = kurtosis(z7)
% taus(4,7) = mean(z7);
% [alphas(4,7),xmin,l] = plfit(z7)
clear z7;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z8');
z8 = z8(z8~=0);
kurt(4,8) = kurtosis(z8)
% taus(4,8) = mean(z8);
% [alphas(4,8),xmin,l] = plfit(z8)
clear z8;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z9');
z9 = z9(z9~=0);
kurt(4,9) = kurtosis(z9)
% taus(4,9) = mean(z9);
% [alphas(4,9),xmin,l] = plfit(z9)
clear z9;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z10');
z10 = z10(z10~=0);
kurt(4,10) = kurtosis(z10)
% taus(4,10) = mean(z10);
% [alphas(4,10),xmin,l] = plfit(z10)
clear z10;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z11');
z11 = z11(z11~=0);
kurt(4,11) = kurtosis(z11)
% taus(4,11) = mean(z11);
% [alphas(4,11),xmin,l] = plfit(z11)
clear z11;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z12');
z12 = z12(z12~=0);
kurt(4,12) = kurtosis(z12)
% taus(4,12) = mean(z12);
% [alphas(4,12),xmin,l] = plfit(z12)
clear z12;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z13');
z13 = z13(z13~=0);
kurt(4,13) = kurtosis(z13)
% taus(4,13) = mean(z13);
% [alphas(4,13),xmin,l] = plfit(z13)
clear z13;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z14');
z14 = z14(z14~=0);
kurt(4,14) = kurtosis(z14)
% taus(4,14) = mean(z14);
% [alphas(4,14),xmin,l] = plfit(z14)
clear z14;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z15');
z15 = z15(z15~=0);
kurt(4,15) = kurtosis(z15)
% taus(4,15) = mean(z15);
% [alphas(4,15),xmin,l] = plfit(z15)
clear z15;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z16');
z16 = z16(z16~=0);
kurt(4,16) = kurtosis(z16)
% taus(4,16) = mean(z16);
% [alphas(4,16),xmin,l] = plfit(z16)
clear z16;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z17');
z17 = z17(z17~=0);
kurt(4,17) = kurtosis(z17)
% taus(4,17) = mean(z17);
% [alphas(4,17),xmin,l] = plfit(z17)
clear z17;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z18');
z18 = z18(z18~=0);
kurt(4,18) = kurtosis(z18)
% taus(4,18) = mean(z18);
% [alphas(4,18),xmin,l] = plfit(z18)
clear z18;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z19');
z19 = z19(z19~=0);
kurt(4,19) = kurtosis(z19)
% taus(4,19) = mean(z19);
% [alphas(4,19),xmin,l] = plfit(z19)
clear z19;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z20');
z20 = z20(z20~=0);
kurt(4,20) = kurtosis(z20)
% taus(4,20) = mean(z20);
% [alphas(4,20),xmin,l] = plfit(z20)
clear z20;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z21');
z21 = z21(z21~=0);
kurt(4,21) = kurtosis(z21)
% taus(4,21) = mean(z21);
% [alphas(4,21),xmin,l] = plfit(z21)
clear z21;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z22');
z22 = z22(z22~=0);
kurt(4,22) = kurtosis(z22)
% taus(4,22) = mean(z22);
% [alphas(4,22),xmin,l] = plfit(z22)
clear z22;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z23');
z23 = z23(z23~=0);
kurt(4,23) = kurtosis(z23)
% taus(4,23) = mean(z23);
% [alphas(4,23),xmin,l] = plfit(z23)
clear z23;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z24');
z24 = z24(z24~=0);
kurt(4,24) = kurtosis(z24)
% taus(4,24) = mean(z24);
% [alphas(4,24),xmin,l] = plfit(z24)
clear z24;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z25');
z25 = z25(z25~=0);
kurt(4,25) = kurtosis(z25)
% taus(4,25) = mean(z25);
% [alphas(4,25),xmin,l] = plfit(z25)
clear z25;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z26');
z26 = z26(z26~=0);
kurt(4,26) = kurtosis(z26)
% taus(4,26) = mean(z26);
% [alphas(4,26),xmin,l] = plfit(z26)
clear z26;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z27');
z27 = z27(z27~=0);
kurt(4,27) = kurtosis(z27)
% taus(4,27) = mean(z27);
% [alphas(4,27),xmin,l] = plfit(z27)
clear z27;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z28');
z28 = z28(z28~=0);
kurt(4,28) = kurtosis(z28)
% taus(4,28) = mean(z28);
% [alphas(4,28),xmin,l] = plfit(z28)
clear z28;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z29');
z29 = z29(z29~=0);
kurt(4,29) = kurtosis(z29)
% taus(4,29) = mean(z29);
% [alphas(4,29),xmin,l] = plfit(z29)
clear z29;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z30');
z30 = z30(z30~=0);
kurt(4,30) = kurtosis(z30)
% taus(4,30) = mean(z30);
% [alphas(4,30),xmin,l] = plfit(z30)
clear z30;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z31');
z31 = z31(z31~=0);
kurt(4,31) = kurtosis(z31)
% taus(4,31) = mean(z31);
% [alphas(4,31),xmin,l] = plfit(z31)
clear z31;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z32');
z32 = z32(z32~=0);
kurt(4,32) = kurtosis(z32)
% taus(4,32) = mean(z32);
% [alphas(4,32),xmin,l] = plfit(z32)
clear z32;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z33');
z33 = z33(z33~=0);
kurt(4,33) = kurtosis(z33)
% taus(4,33) = mean(z33);
% [alphas(4,33),xmin,l] = plfit(z33)
clear z33;

load('Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_fullyear2013.mat','z34');
z34 = z34(z34~=0);
kurt(4,34) = kurtosis(z34)
% taus(4,34) = mean(z34);
% [alphas(4,34),xmin,l] = plfit(z34)
clear z34;

