clear all
f = figure(1);
sc=1;
set(f,'PaperUnits','centimeters','Units','centimeters','PaperPosition',[0 0 sc*8.4 sc*4],'Position',[0 0 sc*8.4 sc*4])
set(0, 'defaultaxesfontsize', sc*8);
set(0, 'defaulttextfontsize', sc*8);


R0 = [10,13,16,20,25,32,40,50,63,79,100,126,158,200,251,316,398,501,631,794,1000];
Vinf = 10:10:190;

%R0 = 1:0.01:2;
%Vinf = 0:10:4500;

[RR,VV] = meshgrid(R0,Vinf);

alpha = [0 0.25 0.5 0.75 1];

for i1=1:1
    
    alp = alpha(i1);
    % include your data here inside this loop
    c=1;
    for qi=1:21,
        q = R0(1,qi);
%         filename = sprintf('~/Dropbox/SIR_game/Algo_1/sys_16n_fine_2k/16n_alpha%1.2f_q%1.4f.mat', alp,q);
        filename = 'figure_4_data.mat';

        if exist(filename, 'file')
            load(filename);
            I(:,c)=dataq(1,:);
            V(:,c)=dataq(2,:);
        else
            fprintf('%1.4f %1.2f \n',q, alp);
            I(:,c)=0;
            V(:,c)=0;
        end
        
        H(c,:)=hist(V(:,c),Vinf); c=c+1;
    end
    

    s{i1} = subplot(1,5,i1);
    % plotting one slice at a time
    xImage = [1 1; 1 1];
    yImage = [RR(1,1) RR(1,end); RR(1,1) RR(1,end)];
    zImage = [VV(1,1) VV(1,1); VV(end,1) VV(end,1)];
    
    surf(xImage, yImage, zImage, 'CData', log(H'/2000), 'FaceColor','texturemap');
    caxis([-7 -2])
    axis tight; view(150,30)
    colormap parula; view(152,11); hold on
    grid off; box on;  axis off
%     %ylabel('\beta','FontSize',14,'FontWeight','bold');
%     tx = text(-1.5, -1.28, 2600,sprintf('\\alpha = %1.2f',alp));%,'FontWeight','bold');
%     set(tx,'rot',-20)
%     axis tight; hold on;
    
%     % x-axes ticks
%     for rng = [1 1.25 1.5 1.75 2];
%         plot3([1.001 1.001],[rng rng],[0    100],'w')
%         plot3([1.001 1.001],[rng rng],[4400 4500],'w')
%     end
%     text(1,   0.9,   -500, '1')
%     text(1,   1.3,  -1050, 'R_0')
%     text(1,   1.9,   -500, '2')
%     
%     % y-axes ticks
%     for rng = 0:1000:4500;
%         plot3([1.001 1.001],[1    1.05],[rng rng],'w')
%         plot3([1.001 1.001],[1.95 2],[rng rng],'w')
%     end
    

%     % inserting text manually for ticks and labels 
%     if i1==1
%     text(1.5, 1, 2500,'$V_{\infty}$','VerticalAlignment','middle','Interpreter','LaTeX')
%     text(1.001,   0.95,   1000, '1000','HorizontalAlignment','right')
%     text(1.001,   0.95,   4000, '4000','HorizontalAlignment','right')
%     
%     text(9.88,  8.63, 12450, '\bf (c)');
%     end
    
end

% cb = colorbar('horiz'); % defining colorbar
% yl=ylabel(cb,'$\log(P(V_{\infty}))$','rot',0,'VerticalAlignment','middle','Interpreter','LaTeX');
% set(yl,'Position',[ -7.7   -2.3    0])

% setting positions of each slice

set(s{1},'Position',[-0.04 0.22 0.42 0.74])
% set(s{2},'Position',[ 0.14 0.22 0.42 0.74])
% set(s{3},'Position',[ 0.32 0.22 0.42 0.74])
% set(s{4},'Position',[ 0.50 0.22 0.42 0.74])
% set(s{5},'Position',[ 0.68 0.22 0.42 0.74])
set(cb,  'Position',[ 0.2 0.115 0.76 0.02]) % setting position of colorbar
