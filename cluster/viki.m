% function dydt = vdp1(t,y)

% dydt = [y(2); (1-y(1)^2)*y(2)-y(1)];

function dphidx = viki(x,phi)
%VDP1  Evaluate the van der Pol ODEs for mu = 1
%
%   See also ODE113, ODE23, ODE45.

%   Jacek Kierzenka and Lawrence F. Shampine
%   Copyright 1984-2014 The MathWorks, Inc.
V=100;
k=5;

dphidx = [phi(2); phi(1)*V/k];
