N = 1e6;
u = rand(1,N);

lam = 1;                        % mean of the waiting time instances' distribution

x = -1./log(1-(u.^(1/100)));    % distribution of time steps delta t
y = -lam.*log(lam.*u);          % distribution of velocities or waiting time instances (exponential distribution)
z = zeros(1,N);                 % collecting waiting times

for i=1:N
    s = floor(sum(-1./log(1-(rand(1,10).^(1/100)))));
    %s = floor(-lam*log(lam*rand));
    xx = -1./log(1-(rand(1,s).^(1/100)));
    z(1,i) = sum(xx);
end


% figure, plot(sort(x,'descend'),(1:length(x))./length(x),'b o');
% figure, semilogy(sort(y,'descend'),(1:length(y))./length(y),'b o');
figure, plot(sort(z,'descend'),(1:length(z))./length(z),'b o');
