%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Program for the lecture                     %
%  Wave Interference                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;clc;close all


%% program settings
v = 200;
lambda = 400;
T = lambda/v;

x1= 200;
y1= 800;
x2= 800;
y2= 200;
z0 = 2;

filename = 'wave_interfere.gif';

[x,y] = meshgrid(0:1:1000);


%% output the traffic dynamics gif

for step = 1:451  

    clc
    disp(['now encoding... step:',num2str(step-1),'/',num2str(450),', rate:',num2str(fix((step-1)/450*100)),'%'])
    fig = figure('visible','off');
    fig.Position(3:4) = [1680 420];

    t = (step-1)/15;
    z1 = z0+0.5*sin(2*pi.*( sqrt((x-x1).^2+(y-y1).^2)./lambda - t/T));
    z2 = z0+0.5*sin(2*pi.*( sqrt((x-x2).^2+(y-y2).^2)./lambda - t/T));
    z = z1 + z2 - z0;

    % draw figure 1
    subplot(1,3,1);
    hold off
    scatter3(x1,y1,z0,30,'black','filled')
    xlim([0 1000])
    ylim([0 1000])
    zlim([0 4])
    hold on
    scatter3(x2,y2,z0,30,'black','filled')

    sc1 = surfc(x,y,z1);
    sc1(1).FaceColor = [255/255 127/255 80/255];
    sc1(1).EdgeColor = 'none';
    sc1(1).FaceAlpha = 0.4;
    sc1(2).LevelList = [2 2];
    sc1(2).EdgeColor = 'black';
    sc1(2).ZLocation = 4;
    imagesc(z1,[1 3])

    % draw figure 2
    subplot(1,3,2);
    hold off
    scatter3(x1,y1,z0,30,'black','filled')
    xlim([0 1000])
    ylim([0 1000])
    zlim([0 4])
    hold on
    scatter3(x2,y2,z0,30,'black','filled')

    sc2 = surfc(x,y,z2);
    sc2(1).FaceColor = [218/255 112/255 214/255];
    sc2(1).EdgeColor = 'none';
    sc2(1).FaceAlpha = 0.4;
    sc2(2).LevelList = [2 2];
    sc2(2).EdgeColor = 'black';
    sc2(2).ZLocation = 4;
    imagesc(z2,[1 3])

    % draw convert figure
    subplot(1,3,3);
    hold off
    scatter3(x1,y1,z0,30,'black','filled')
    xlim([0 1000])
    ylim([0 1000])
    zlim([0 4])
    hold on
    scatter3(x2,y2,z0,30,'black','filled')

    sc1 = surfc(x,y,z1);
    sc1(1).FaceColor = [255/255 127/255 80/255];
    sc1(1).EdgeColor = 'none';
    sc1(1).FaceAlpha = 0.05;
    sc1(2).LevelList = [2 2];
    sc1(2).EdgeColor = 'black';
    sc1(2).ZLocation = 4;

    sc2 = surfc(x,y,z2);
    sc2(1).FaceColor = [218/255 112/255 214/255];
    sc2(1).EdgeColor = 'none';
    sc2(1).FaceAlpha = 0.05;
    sc2(2).LevelList = [2 2];
    sc2(2).EdgeColor = 'black';
    sc2(2).ZLocation = 4;

    sc = surf(x,y,z);
    sc.FaceColor = [30/255 144/255 255/255];
    sc.EdgeColor = 'none';
    sc.FaceAlpha = 0.4;
    imagesc(z,[1 3])
    
    frame = getframe(fig);
    frame = frame2im(frame);

    % generate gif file
    [frame,map] = rgb2ind(frame,256);
    if step == 1
        imwrite(frame,map,filename,'gif','DelayTime',1/15);
    else
        imwrite(frame,map,filename,'gif',"WriteMode","append",'DelayTime',1/15);
    end

end