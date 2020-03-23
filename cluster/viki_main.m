
[x,phi] = ode45(@viki,[0 20],[2; 0]);

%plot(x,phi(:,1),'-o',x,phi(:,2),'-o')
plot(x,phi(:,1),'-o')
title('Schrodinger equation solution');
xlabel('Time x');
ylabel('Solution phi');
%legend('phi_1','phi_2')
legend('phi_1')
