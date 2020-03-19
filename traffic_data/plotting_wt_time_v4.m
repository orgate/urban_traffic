%Plotting waiting time or active time distributions
load Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_12.mat % data of 2013
% x1=[];y1=[];z1=[];
% x2=[];y2=[];z2=[];
% x3=[];y3=[];z3=[];
% x4=[];y4=[];z4=[];
% clear('x1a','x1b','x2a','x2b','x3a','x3b','x4a','x4b','x5a','x5b','x6a','x6b','x7a','x7b','x8a','x8b','y1a','y1b','y2a','y2b','y3a','y3b','y4a','y4b','y5a','y5b','y6a','y6b','y7a','y7b','y8a','y8b','z1a','z1b','z2a','z2b','z3a','z3b','z4a','z4b','z5a','z5b','z6a','z6b','z7a','z7b','z8a','z8b');

% x1=[];y1=[];z1=[];
% x2=[];y2=[];z2=[];
% x3=[];y3=[];z3=[];
% x4=[];y4=[];z4=[];
% x5=[];y5=[];z5=[];
% x6=[];y6=[];z6=[];
% x7=[];y7=[];z7=[];
% x8=[];y8=[];z8=[];
% x9=[];y9=[];z9=[];
% x10=[];y10=[];z10=[];
% x11=[];y11=[];z11=[];
% x12=[];y12=[];z12=[];
% x13=[];y13=[];z13=[];
% x14=[];y14=[];z14=[];
% x15=[];y15=[];z15=[];
% x16=[];y16=[];z16=[];
% x17=[];y17=[];z17=[];
% x18=[];y18=[];z18=[];
% x19=[];y19=[];z19=[];
% x20=[];y20=[];z20=[];
% x21=[];y21=[];z21=[];
% x22=[];y22=[];z22=[];
% x23=[];y23=[];z23=[];
% x24=[];y24=[];z24=[];
% x25=[];y25=[];z25=[];
% x26=[];y26=[];z26=[];
% x27=[];y27=[];z27=[];
% x28=[];y28=[];z28=[];
% x29=[];y29=[];z29=[];
% x30=[];y30=[];z30=[];
% x31=[];y31=[];z31=[];
% x32=[];y32=[];z32=[];
% x33=[];y33=[];z33=[];
% x34=[];y34=[];z34=[];
% 
% fx1b=[];fy1b=[];fz1b=[];
% fx2b=[];fy2b=[];fz2b=[];
% fx3b=[];fy3b=[];fz3b=[];
% fx4b=[];fy4b=[];fz4b=[];
% fx5b=[];fy5b=[];fz5b=[];
% 
% fx6b=[];fy6b=[];fz6b=[];
% fx7b=[];fy7b=[];fz7b=[];
% fx8b=[];fy8b=[];fz8b=[];
% fx9b=[];fy9b=[];fz9b=[];
% % fx10b=[];fy10b=[];fz10b=[];

% x=cell(1,40000);
% y=cell(1,40000);
% z=cell(1,40000);
% xa=cell(1,40000);
% ya=cell(1,40000);
% za=cell(1,40000);
% x2=cell(1,40000);
% y2=cell(1,40000);
% z2=cell(1,40000);
% x2a=cell(1,40000);
% y2a=cell(1,40000);
% z2a=cell(1,40000);

% weekdays = [1,2,3,4,7,8,9,10,11,14,15,16,17,18,21,22,23,24,25,28,29,30,31];   %Week days for JAN, 2013
% weekdays = [1,4,5,6,7,8,11,12,13,14,15,18,19,20,21,22,25,26,27,28];           %Week days for FEB, 2013
% weekdays = [1,4,5,6,7,8,11,12,13,14,15,18,19,20,21,22,25,26,27,28,29];        %Week days for MAR, 2013
% weekdays = [1,2,3,4,5,8,9,10,11,12,15,16,17,18,19,22,23,24,25,26,29,30];      %Weekdays for APR, 2013
% weekdays = [1,2,3,6,7,8,9,10,13,14,15,16,17,20,21,22,23,24,27,28,29,30,31];   %Weekdays for MAY, 2013
% weekdays = [3,4,5,6,7,10,11,12,13,14,17,18,19,20,21,24,25,26,27,28];          %Weekdays for JUN, 2013
% weekdays = [1,2,3,4,5,8,9,10,11,12,15,16,17,18,19,22,23,24,25,26,29,30,31];   %Week days for JUL, 2013
% weekdays = [1,2,5,6,7,8,9,12,13,14,15,16,19,20,21,22,23,26,27,28,29,30];      %Weekdays for AUG, 2013
% weekdays = [2,3,4,5,6,9,10,11,12,13,16,17,18,19,20,23,24,25,26,27,30];        %Weekdays for SEP, 2013
% weekdays = [1,2,3,4,7,8,9,10,11,14,15,16,17,18,21,22,23,24,25,28,29,30,31];   %Weekdays for OCT, 2013
% weekdays = [1,4,5,6,7,8,11,12,13,14,15,18,19,20,21,22,25,26,27,28,29];        %Weekdays for NOV, 2013
weekdays = [2,3,4,5,6,9,10,11,12,13,16,17,18,19,20,23,24,25,26,27,30,31];     %Weekdays for DEC, 2013
for i=1:length(weekdays)   %%%%%changed from 30 for wt_time; it's 21 for ac_time
%     for j=1:40000
        d = weekdays(1,i)
        x1=[x1,wt1{1,d}]; %Bombay
        y1=[y1,wt1{2,d}]; %Bangalore
        z1=[z1,wt1{3,d}]; %Delhi
        x2=[x2,wt2{1,d}]; %Bombay
        y2=[y2,wt2{2,d}]; %Bangalore
        z2=[z2,wt2{3,d}]; %Delhi
        x3=[x3,wt3{1,d}]; %Bombay
        y3=[y3,wt3{2,d}]; %Bangalore
        z3=[z3,wt3{3,d}]; %Delhi
        x4=[x4,wt4{1,d}]; %Bombay
        y4=[y4,wt4{2,d}]; %Bangalore
        z4=[z4,wt4{3,d}]; %Delhi
        x5=[x5,wt5{1,d}]; %Bombay
        y5=[y5,wt5{2,d}]; %Bangalore
        z5=[z5,wt5{3,d}]; %Delhi
        x6=[x6,wt6{1,d}]; %Bombay
        y6=[y6,wt6{2,d}]; %Bangalore
        z6=[z6,wt6{3,d}]; %Delhi
        x7=[x7,wt7{1,d}]; %Bombay
        y7=[y7,wt7{2,d}]; %Bangalore
        z7=[z7,wt7{3,d}]; %Delhi
        x8=[x8,wt8{1,d}]; %Bombay
        y8=[y8,wt8{2,d}]; %Bangalore
        z8=[z8,wt8{3,d}]; %Delhi
        x9=[x9,wt9{1,d}]; %Bombay
        y9=[y9,wt9{2,d}]; %Bangalore
        z9=[z9,wt9{3,d}]; %Delhi
        x10=[x10,wt10{1,d}]; %Bombay
        y10=[y10,wt10{2,d}]; %Bangalore
        z10=[z10,wt10{3,d}]; %Delhi
        x11=[x11,wt11{1,d}]; %Bombay
        y11=[y11,wt11{2,d}]; %Bangalore
        z11=[z11,wt11{3,d}]; %Delhi
        x12=[x12,wt12{1,d}]; %Bombay
        y12=[y12,wt12{2,d}]; %Bangalore
        z12=[z12,wt12{3,d}]; %Delhi
        x13=[x13,wt13{1,d}]; %Bombay
        y13=[y13,wt13{2,d}]; %Bangalore
        z13=[z13,wt13{3,d}]; %Delhi
        x14=[x14,wt14{1,d}]; %Bombay
        y14=[y14,wt14{2,d}]; %Bangalore
        z14=[z14,wt14{3,d}]; %Delhi
        x15=[x15,wt15{1,d}]; %Bombay
        y15=[y15,wt15{2,d}]; %Bangalore
        z15=[z15,wt15{3,d}]; %Delhi
        x16=[x16,wt16{1,d}]; %Bombay
        y16=[y16,wt16{2,d}]; %Bangalore
        z16=[z16,wt16{3,d}]; %Delhi
        x17=[x17,wt17{1,d}]; %Bombay
        y17=[y17,wt17{2,d}]; %Bangalore
        z17=[z17,wt17{3,d}]; %Delhi
        x18=[x18,wt18{1,d}]; %Bombay
        y18=[y18,wt18{2,d}]; %Bangalore
        z18=[z18,wt18{3,d}]; %Delhi
        x19=[x19,wt19{1,d}]; %Bombay
        y19=[y19,wt19{2,d}]; %Bangalore
        z19=[z19,wt19{3,d}]; %Delhi
        x20=[x20,wt20{1,d}]; %Bombay
        y20=[y20,wt20{2,d}]; %Bangalore
        z20=[z20,wt20{3,d}]; %Delhi
        x21=[x21,wt21{1,d}]; %Bombay
        y21=[y21,wt21{2,d}]; %Bangalore
        z21=[z21,wt21{3,d}]; %Delhi
        x22=[x22,wt22{1,d}]; %Bombay
        y22=[y22,wt22{2,d}]; %Bangalore
        z22=[z22,wt22{3,d}]; %Delhi
        x23=[x23,wt23{1,d}]; %Bombay
        y23=[y23,wt23{2,d}]; %Bangalore
        z23=[z23,wt23{3,d}]; %Delhi
        x24=[x24,wt24{1,d}]; %Bombay
        y24=[y24,wt24{2,d}]; %Bangalore
        z24=[z24,wt24{3,d}]; %Delhi
        x25=[x25,wt25{1,d}]; %Bombay
        y25=[y25,wt25{2,d}]; %Bangalore
        z25=[z25,wt25{3,d}]; %Delhi
        x26=[x26,wt26{1,d}]; %Bombay
        y26=[y26,wt26{2,d}]; %Bangalore
        z26=[z26,wt26{3,d}]; %Delhi
        x27=[x27,wt27{1,d}]; %Bombay
        y27=[y27,wt27{2,d}]; %Bangalore
        z27=[z27,wt27{3,d}]; %Delhi
        x28=[x28,wt28{1,d}]; %Bombay
        y28=[y28,wt28{2,d}]; %Bangalore
        z28=[z28,wt28{3,d}]; %Delhi
        x29=[x29,wt29{1,d}]; %Bombay
        y29=[y29,wt29{2,d}]; %Bangalore
        z29=[z29,wt29{3,d}]; %Delhi
        x30=[x30,wt30{1,d}]; %Bombay
        y30=[y30,wt30{2,d}]; %Bangalore
        z30=[z30,wt30{3,d}]; %Delhi
        x31=[x31,wt31{1,d}]; %Bombay
        y31=[y31,wt31{2,d}]; %Bangalore
        z31=[z31,wt31{3,d}]; %Delhi
        x32=[x32,wt32{1,d}]; %Bombay
        y32=[y32,wt32{2,d}]; %Bangalore
        z32=[z32,wt32{3,d}]; %Delhi
        x33=[x33,wt33{1,d}]; %Bombay
        y33=[y33,wt33{2,d}]; %Bangalore
        z33=[z33,wt33{3,d}]; %Delhi
        x34=[x34,wt34{1,d}]; %Bombay
        y34=[y34,wt34{2,d}]; %Bangalore
        z34=[z34,wt34{3,d}]; %Delhi

        
%         x{1,j}=[x{1,j},wait{1,d,j}]; %Bombay
%         y{1,j}=[y{1,j},wait{2,d,j}]; %Bangalore
%         z{1,j}=[z{1,j},wait{3,d,j}]; %Delhi
%         xa{1,j}=[xa{1,j},waita{1,d,j}]; %Bombay
%         ya{1,j}=[ya{1,j},waita{2,d,j}]; %Bangalore
%         za{1,j}=[za{1,j},waita{3,d,j}]; %Delhi
%         x2{1,j}=[x2{1,j},wait2{1,d,j}]; %Bombay
%         y2{1,j}=[y2{1,j},wait2{2,d,j}]; %Bangalore
%         z2{1,j}=[z2{1,j},wait2{3,d,j}]; %Delhi
%         x2a{1,j}=[x2a{1,j},wait2a{1,d,j}]; %Bombay
%         y2a{1,j}=[y2a{1,j},wait2a{2,d,j}]; %Bangalore
%         z2a{1,j}=[z2a{1,j},wait2a{3,d,j}]; %Delhi
%     end
end
% % 
% figure;loglog(sort(x,'descend'),(1:length(x))/length(x),'o r')
% hold on;loglog(sort(y,'descend'),(1:length(y))/length(y),'o g')
% hold on;loglog(sort(z,'descend'),(1:length(z))/length(z),'o b')
% legend('Bombay','Bangalore','Delhi')
% % 
% figure;loglog(sort(xa,'descend'),(1:length(xa))/length(xa),'o r')
% hold on;loglog(sort(ya,'descend'),(1:length(ya))/length(ya),'o g')
% hold on;loglog(sort(za,'descend'),(1:length(za))/length(za),'o b')
% legend('Bombay','Bangalore','Delhi')
% 
% figure;loglog(sort(x2,'descend'),(1:length(x2))/length(x2),'o r')
% hold on;loglog(sort(y2,'descend'),(1:length(y2))/length(y2),'o g')
% hold on;loglog(sort(z2,'descend'),(1:length(z2))/length(z2),'o b')
% legend('Bombay','Bangalore','Delhi')
% 
% figure;loglog(sort(x2a,'descend'),(1:length(x2a))/length(x2a),'o r')
% hold on;loglog(sort(y2a,'descend'),(1:length(y2a))/length(y2a),'o g')
% hold on;loglog(sort(z2a,'descend'),(1:length(z2a))/length(z2a),'o b')
% legend('Bombay','Bangalore','Delhi')
% 
% xlen = zeros(1,40000);
% ylen = zeros(1,40000);
% zlen = zeros(1,40000);
% xalen = zeros(1,40000);
% yalen = zeros(1,40000);
% zalen = zeros(1,40000);
% x2len = zeros(1,40000);
% y2len = zeros(1,40000);
% z2len = zeros(1,40000);
% x2alen = zeros(1,40000);
% y2alen = zeros(1,40000);
% z2alen = zeros(1,40000);
% 
% % 
% for i=1:40000
% xlen(1,i) = length(x{1,i});
% ylen(1,i) = length(y{1,i});
% zlen(1,i) = length(z{1,i});
% xalen(1,i) = length(xa{1,i});
% yalen(1,i) = length(ya{1,i});
% zalen(1,i) = length(za{1,i});
% x2len(1,i) = length(x2{1,i});
% y2len(1,i) = length(y2{1,i});
% z2len(1,i) = length(z2{1,i});
% x2alen(1,i) = length(x2a{1,i});
% y2alen(1,i) = length(y2a{1,i});
% z2alen(1,i) = length(z2a{1,i});
% end
% 
% 
% figure;loglog(sort(x{1,find(xlen==max(xlen))},'descend'),(1:length(x{1,find(xlen==max(xlen))}))/length(x{1,find(xlen==max(xlen))}),'o r')
% hold on; loglog(sort(y{1,find(ylen==max(ylen))},'descend'),(1:length(y{1,find(ylen==max(ylen))}))/length(y{1,find(ylen==max(ylen))}),'o g')
% hold on; loglog(sort(z{1,find(zlen==max(zlen))},'descend'),(1:length(z{1,find(zlen==max(zlen))}))/length(z{1,find(zlen==max(zlen))}),'o b')
% legend('Bombay','Bangalore','Delhi')
% % 
% figure;loglog(sort(xa{1,find(xalen==max(xalen))},'descend'),(1:length(xa{1,find(xalen==max(xalen))}))/length(xa{1,find(xalen==max(xalen))}),'o r')
% hold on; loglog(sort(ya{1,find(yalen==max(yalen))},'descend'),(1:length(ya{1,find(yalen==max(yalen))}))/length(ya{1,find(yalen==max(yalen))}),'o g')
% hold on; loglog(sort(za{1,find(zalen==max(zalen))},'descend'),(1:length(za{1,find(zalen==max(zalen))}))/length(za{1,find(zalen==max(zalen))}),'o b')
% legend('Bombay','Bangalore','Delhi')
% 
% figure;loglog(sort(x2{1,find(x2len==max(x2len))},'descend'),(1:length(x2{1,find(x2len==max(x2len))}))/length(x2{1,find(x2len==max(x2len))}),'o r')
% hold on; loglog(sort(y2{1,find(y2len==max(y2len))},'descend'),(1:length(y2{1,find(y2len==max(y2len))}))/length(y2{1,find(y2len==max(y2len))}),'o g')
% hold on; loglog(sort(z2{1,find(z2len==max(z2len))},'descend'),(1:length(z2{1,find(z2len==max(z2len))}))/length(z2{1,find(z2len==max(z2len))}),'o b')
% legend('Bombay','Bangalore','Delhi')
% 
% figure;loglog(sort(x2a{1,find(x2alen==max(x2alen))},'descend'),(1:length(x2a{1,find(x2alen==max(x2alen))}))/length(x2a{1,find(x2alen==max(x2alen))}),'o r')
% hold on; loglog(sort(y2a{1,find(y2alen==max(y2alen))},'descend'),(1:length(y2a{1,find(y2alen==max(y2alen))}))/length(y2a{1,find(y2alen==max(y2alen))}),'o g')
% hold on; loglog(sort(z2a{1,find(z2alen==max(z2alen))},'descend'),(1:length(z2a{1,find(z2alen==max(z2alen))}))/length(z2a{1,find(z2alen==max(z2alen))}),'o b')
% legend('Bombay','Bangalore','Delhi')



%%%% taking transpose just for viewing data in matlab console (by Alfred)
%x = x';
%y = y';
%z = z';
