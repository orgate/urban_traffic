
%load Wait_time4_taxis_vel_bombay_bang_delhi04.mat;
load Wait_time_taxis_bang08.mat;
siz = size(vel1);
D = siz(2);
mean_vel = zeros(D,288);


for ll=1:D
    for ve=1:288
        mean_vel(ll,ve) = mean(vel1{2,ll,ve}); % collecting only for Bangalore
    end
end


meanvel = zeros(D,96);
for ii=1:D
for jj=1:96
meanvel(ii,jj) = mean([mean_vel(ii,3*jj),mean_vel(ii,3*jj-1),mean_vel(ii,3*jj-2)]);
end
end
%vel_mean = mean(meanvel,1);
%meanvel(5,24) = mean([mean_vel(2,5,3*24),mean_vel(2,5,3*24-2)]);%due to
%some data issues for JAN
%meanvel(14,43) = mean([mean_vel(14,3*43-2)]);%due to some data issues for APR
%meanvel(14,44) = mean([mean_vel(14,3*44),mean_vel(14,3*44-1)]);%due to some data issues for APR

meanvel(6,35) = mean([mean_vel(6,3*35),mean_vel(6,3*35-1)]);%due to some data issues for AUG
meanvel(11,46) = mean([mean_vel(11,3*46-2)]);%due to some data issues for AUG
meanvel(11,47) = mean([mean_vel(11,3*47),mean_vel(11,3*47-1)]);%due to some data issues for AUG

%vel_mean = mean(meanvel,1);
vel_median = median(meanvel,1);
vel_quant1 = quantile(meanvel,0.25);
vel_quant3 = quantile(meanvel,0.75);
velmeans = [vel_quant1;vel_median;vel_quant3];
%velmeans = [vel_quant1;vel_mean;vel_quant3];
figure,
sd = plotshaded([1:96],velmeans,'b',[1 0.7 1]);

% taxis_day = zeros(3,D,288);
%  for ii=1:3
% for jj=1:D
% for kk=1:288
% taxis_day(ii,jj,kk) = length(unique(taxis{ii,jj,kk}));
% end
% end
%  end
% 
% taxi1 = zeros(22,96);
% for ii=1:22
% for jj=1:96
% taxi1(ii,jj) = mean([taxis_day(2,ii,3*jj),taxis_day(2,ii,3*jj-1),taxis_day(2,ii,3*jj-2)]);
% end
% end
% no_mean = mean(taxi1,1);
% %no_median = median(taxi1,1);
% no_quant1 = quantile(taxi1,0.25);
% no_quant3 = quantile(taxi1,0.75);
% taxi = [no_quant1;no_mean;no_quant3];
% %taxi = [no_quant1;no_median;no_quant3];
% figure,
% sd = plotshaded([1:96],taxi,'b',[1 0.7 1]);
% 

%%% Plotting speed variation of a taxi on a particular day (here 8th Jan, 2013)
% K = load(['AlignedData_20130108.dat']);
% uniq_tax = unique(K(:,1));
% num = zeros(length(uniq_tax),1);
% for i=1:length(uniq_tax)
% ut = K(find(K(:,1)==uniq_tax(i,1)),2);
% num(i,1) = length(unique(ut));          % no. of data points (in terms of unique time stamps) for each taxi on a day
% end
% [maxi, indmaxi] = max(num);
% Kh_ind = find(K(:,1)==uniq_tax(indmaxi,1));
% Kh_vel = [K(Kh_ind,2),K(Kh_ind,5)];
% [Kh_time,Kh_time_ind] = sort(Kh_vel(:,1),'ascend');
% Kh_time = mod(Kh_time,86400);
% Kh_check = diff(Kh_time);       % used to make sure time stamps are non-identical
% vel_taxi_kh = Kh_vel(Kh_time_ind,2);
% Kh_time = Kh_time(Kh_check>0);
% vel_taxi_kh = vel_taxi_kh(Kh_check>0);
% figure, plot(Kh_time,vel_taxi_kh);
