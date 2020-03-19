
timul = 10000;
alpha = 0.2;
bta = 0.2;
rt = 0.3;
dt = 0.01;

dis_h = 0.2;
vel_h = 0.2;

time = 0;
Vel_h = [];
Acc = [];
while (time<tsimul)
    rndm_deceleration = randn;
    acc = -(alpha + rndm_deceleration).*vel_h + bta.*(((dis_h-(vel_h.*rt)))./(dis_h+1));%%% acceleration update
    vel_h = vel_h + acc*dt;
    Acc = [Acc,acc];
    Vel_h = [Vel_h,vel_h];
    time = time + dt;
end

hist(Acc,1000);
hist(Vel_h,1000);