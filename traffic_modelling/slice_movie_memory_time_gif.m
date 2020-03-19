load ('measure_pir_f.dat');%make sure that you work in folder named "20". file names are same

mapk   = 6e-1 : 2e-1 : 6;
mapkk   = 6e-1 : 2e-1 : 6;
mapkkk   = 8e-4 : 2e-4 : 8e-3;


vom_x = size(mapk,2);
vom_y = size(mapkk,2);
vom_z = size(mapkkk,2);


v = measure_pir_f (:, 6); %pir counts
%v = measure_pir_f (:, 7); %memory_time

%vom = zeros (28, 28, 37);
%for i = 1 : 28
%for j = 1 : 28
%for k = 1 : 37
%vom (i, j, k) = v (37*28*(i - 1) +  37*(j - 1) + k);
%end
%end
%end


vom = zeros (vom_x, vom_y, vom_z);
for i = 1 : vom_x
for j = 1 : vom_y
for k = 1 : vom_z
vom (i, j, k) = v (vom_z*vom_y*(i - 1) +  vom_z*(j - 1) + k);
end
end
end


filename = 'slice_vary_kinase_sigma12_PIR_count.gif';
%filename = 'slice_vary_kinase_sigma12_memory_time.gif';
%older gif files contain wrong axis labels 
%slice works differently for this volm data
clf;
vals = 8e-4 : 2e-4 : 8e-3 ;
h= slice(mapkk, mapk, mapkkk, vom, [], [], vals(1));
axis([6e-1 6 6e-1 6 8e-4 8e-3]);
colorbar;
view(43,34)
xlabel ('[MAP2K_{total}]');
ylabel ('[MAPK_{total}]');
zlabel ('[MAP3K_{total}]');
for id = vals
   %delete(h);
   h= slice(mapkk, mapk, mapkkk, vom, [], [], id);
   set(h,'EdgeAlpha',0,'FaceAlpha',0.6)
   axis([6e-1 6 6e-1 6 8e-4 8e-3]);
   xlabel ('[MAP2K_{total}]');
   ylabel ('[MAPK_{total}]');
   zlabel ('[MAP3K_{total}]');
   colorbar; %hold on;
   view(43,34)
   
   frame = getframe(1);
   im = frame2im(frame);
   [A,map] = rgb2ind(im,256);
   if id == vals(1)
       imwrite(A,map,filename,'gif','LoopCount',0,'DelayTime',0.1);
   else
       imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.5);
   end
   
   pause(0.3);hold off;
   delete(h);  
end

for id = vals
   %delete(h);
   h= slice(mapkk, mapk, mapkkk, vom, [], [], id);
   set(h,'EdgeAlpha',0,'FaceAlpha',0.2)
   axis([6e-1 6 6e-1 6 8e-4 8e-3]);
   xlabel ('[MAP2K_{total}]');
   ylabel ('[MAPK_{total}]');
   zlabel ('[MAP3K_{total}]');
   colorbar; hold on;
   view(43,34)
   
   frame = getframe(1);
   im = frame2im(frame);
   [A,map] = rgb2ind(im,256);
   imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.5);
      
   pause(0.3);
end


for v1=0:5:360
    view(43+v1,34)
    pause(0.3);
    frame = getframe(1);
    im = frame2im(frame);
    [A,map] = rgb2ind(im,256);
    imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.5);
end
%close;