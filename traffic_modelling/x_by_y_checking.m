% Th = [];
% for i=1:10000
% tr = round(gamrnd(1,1));
% th = [];
% for t=1:tr
% dh = 0.3*rand;
% vh = gamrnd(1,(dh.^2)./(1+(dh.^2)));
% th = [th,dh./vh];
% end
% Th = [Th,cumsum(th)];
% end
% 
% 
% 
% for i=1:10000
% tr = round(gamrnd(1,1));
% th = [];
% for t=1:tr
% dh = 3*rand;
% vh = gamrnd(1,(dh.^2)./(1+(dh.^2)));
% th = [th,dh./vh];
% end
% Th = [Th,cumsum(th)];
% end

dt = [];
dtm = [];

for i=1:1000
    lr = 100*rand(1,100);
    lr = sort(lr,'ascend');
    dhr = [diff(lr), 100-lr(end)+lr(1)];
    vr = (dhr.^2)./(1+(dhr.^2));
    cr = gamrnd(1,vr/1,1,100);
    dt = [dt, dhr./cr];
    dtm = [dtm,min(dhr./cr)];
end


figure; loglog(sort(dt,'descend'),[1:length(dt)]/length(dt),'b o');
figure; loglog(sort(dtm,'descend'),[1:length(dtm)]/length(dtm),'b o');
