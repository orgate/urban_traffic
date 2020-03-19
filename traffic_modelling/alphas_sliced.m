open('approx_exponent_xmin_1_alpha1.fig');
h = gcf;
axesObjs = get(h, 'Children');
dataObjs = get(axesObjs, 'Children');
objTypes1 = get(dataObjs{1,1}, 'Type');
objTypes2 = get(dataObjs{2,1}, 'Type');
xdata1 = get(dataObjs{2,1}, 'XData');
ydata1 = get(dataObjs{2,1}, 'YData');
zdata1 = get(dataObjs{2,1}, 'ZData');


open('approx_exponent_xmin_1_alpha5.fig');
h = gcf;
axesObjs = get(h, 'Children');
dataObjs = get(axesObjs, 'Children');
objTypes1 = get(dataObjs{1,1}, 'Type');
objTypes2 = get(dataObjs{2,1}, 'Type');
xdata2 = get(dataObjs{2,1}, 'XData');
ydata2= get(dataObjs{2,1}, 'YData');
zdata2 = get(dataObjs{2,1}, 'ZData');


open('approx_exponent_xmin_1_alpha9.fig');
h = gcf;
axesObjs = get(h, 'Children');
dataObjs = get(axesObjs, 'Children');
objTypes1 = get(dataObjs{1,1}, 'Type');
objTypes2 = get(dataObjs{2,1}, 'Type');
xdata3 = get(dataObjs{2,1}, 'XData');
ydata3= get(dataObjs{2,1}, 'YData');
zdata3 = get(dataObjs{2,1}, 'ZData');


figure, surf(X,Y,zdata1*0+0.1,zdata1); hold on;
surf(X,Y,zdata1*0+0.5,zdata2); hold on;
surf(X,Y,zdata1*0+0.9,zdata3);
