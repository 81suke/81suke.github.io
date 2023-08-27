clear
clc

% mass
m = 0.25;
% initial speed
v0 = 20;
% resistance factor
k = 1/2 * 0.4 * 1.26 * pi*0.16^2/4;
% gravity acceleration
g = 9.8;
% short direction
theta = [10 20 30 40 50 60 70];
dt = 1/50;
time = 200;

color = ['r' 'g' 'b' 'c' 'm' 'y' 'k'];


for n = 1 : length(theta)
    x(n,1) = 0;
    y(n,1) = 0;
    vx(n,1) = v0*cosd(theta(n));
    vy(n,1) = v0*sind(theta(n));
    for t = 1 : time
        vx(n,t+1) = vx(n,t) - k*vx(n,t)/m*dt;
        vy(n,t+1) = vy(n,t) - g*dt - k*vy(n,t)/m*dt;
        x(n,t+1) = x(n,t) + (vx(n,t)+vx(n,t+1))/2*dt;
        y(n,t+1) = y(n,t) + (vy(n,t)+vy(n,t+1))/2*dt;
        if y(n,t+1) < 0
            y(n,t+1) = 0;
            x(n,t+1) = x(n,t) + (vx(n,t)+vx(n,t+1))/2 * -y(n,t)/(vy(n,t)+vy(n,t+1))*2;
            vx(n,t+1) = 0;
            vy(n,t+1) = 0;
        end
    end
end


for t = 1: time
    clc
    disp(['Now writing... flame:',num2str(t),'/',num2str(time),', rate:',num2str(fix(t/time*100)),'%'])
    fig = figure('visible','off');
    hold on
    for n = 1 : length(theta)
        p(n) = plot(x(n,1:t),y(n,1:t));
    end
    for n = 1 : length(theta)
        s(n) = scatter(x(n,t),y(n,t),'filled');
    end
    for n = 1 : length(theta)
        p(n).Color = color(n);
        s(n).MarkerFaceColor = color(n);
    end
    xlim([0 max(max(x))])
    ylim([0 max(max(y))])
    title('distance depending on injection angle')
    xlabel('horizontal displacement[m]')
    ylabel('vertical displacement[m]')
    legend('\theta=10^\circ','\theta=20^\circ','\theta=30^\circ','\theta=40^\circ', ...
    '\theta=50^\circ','\theta=60^\circ','\theta=70^\circ')
    saveas(fig,append('figure/throwing_',sprintf('%04d',t),'.png'))
end


output = VideoWriter('throwing.mp4','MPEG-4');
output.FrameRate = 10;
output.Quality = 100;
open(output)

for t = 1 : time
    clc
    disp(['Now encoding... flame:',num2str(t),'/',num2str(time),', rate:',num2str(fix(t/time*100)),'%'])
    image = imread(append('figure/throwing_',sprintf('%04d',t),'.png'));
    writeVideo(output,image)
end
close(output)

