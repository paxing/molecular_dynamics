clear all;
clc;


diffusion_coefficient = 0.1; %um^2/s
r=0.25; % um
frame_length=0.1; % 100 ms
number_of_steps = 500;
number_of_dimensions = 3;

%% surface of cylinder = rectangle

%surface of the cylinder
figure()
for i = 1:5
    dxz = sqrt(2*diffusion_coefficient*frame_length).*randn(number_of_steps, number_of_dimensions-1);
    
    position = [zeros(1,2); cumsum(dxz,1)];

    %% mapping for 2d rect projection to cylinder
    
    H = position(:,1); %x axis is the h cylindrical coordinates
    R = r*ones(number_of_steps+1,1); % the radius is fixed at r
    T = position(:,2)./R; %theta coordinates is defined as (theta)=Z/R
    %% convert cylindrical coordinates back to cart for matlab
    
    [z,y,x] = pol2cart(T,R,H);
    
    
    for time_lag=1:300
        displacements = [x(1+time_lag:end)-x(1:end-time_lag) ...
            y(1+time_lag:end)-y(1:end-time_lag) z(1+time_lag:end)-z(1:end-time_lag)];
        squared_displacements = displacements.^2;
        msd3d(i,time_lag)=mean(sum(squared_displacements,2));
        msd2d_xy(i,time_lag)=mean(sum(squared_displacements(:,1:2),2));
        msd2d_yz(i,time_lag)=mean(sum(squared_displacements(:,2:3),2));
        
        
    end
    subplot(1,5,i)
    plot((1:300).*frame_length,msd3d(i,:), 'LineWidth',2)
    hold on
    plot((1:300).*frame_length,msd2d_xy(i,:), 'LineWidth',2)
    hold off
    legend('3D','2D in xy','Interpreter','latex');
    xlabel('Time lag [s]','Interpreter','latex');
    ylabel('MSD in 3d [$$\mu$$m]$$^2$$','Interpreter','latex');
    set(gca,'FontSize',16);
    set(gca,'TickLabelInterpreter','latex');
    ax=gca;
    ax.LineWidth=1.5;
    set(gcf,'position',[10,10,1600, 400]) %[x0,y0,width,height]

    print(gcf,'diffusion_on_cylinder_each_trial','-dpng','-r300');
    
end
%%
figure()
subplot(121)
plot((1:300).*frame_length,msd3d.', 'LineWidth',2)
xlabel('Time lag [s]','Interpreter','latex');
ylabel('MSD in 3d [$$\mu$$m]$$^2$$','Interpreter','latex');
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;

subplot(122)
curve1 = mean(msd3d,1) + std(msd3d,1);
curve2 = mean(msd3d,1) - std(msd3d,1);
inBetween = [curve1, fliplr(curve2)];
fill([1:300, fliplr(1:300)].*frame_length, inBetween, 'r','LineStyle','none');
alpha 0.25
hold on
plot((1:300).*frame_length,mean(msd3d,1), 'r', 'LineWidth',2)
xlabel('Time lag [s]','Interpreter','latex');
ylabel('MSD in 3d [$$\mu$$m]$$^2$$','Interpreter','latex');
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
print(gcf,'MSD_diffusion_on_cylinder_3d','-dpng','-r300');

%%
figure()
subplot(121)
plot((1:300).*frame_length,msd2d_xy.', 'LineWidth',2)
xlabel('Time lag [s]','Interpreter','latex');
ylabel('MSD in xy [$$\mu$$m]$$^2$$','Interpreter','latex');
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;

subplot(122)
curve1 = mean(msd2d_xy,1) + std(msd2d_xy,1);
curve2 = mean(msd2d_xy,1) - std(msd2d_xy,1);
inBetween = [curve1, fliplr(curve2)];
fill([1:300, fliplr(1:300)].*frame_length, inBetween, 'r','LineStyle','none');
alpha 0.25
hold on
plot((1:300).*frame_length,mean(msd2d_xy,1), 'r', 'LineWidth',2)
xlabel('Time lag [s]','Interpreter','latex');
ylabel('MSD in xy [$$\mu$$m]$$^2$$','Interpreter','latex');
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
print(gcf,'MSD_diffusion_on_cylinder_xy','-dpng','-r300');

%%


%%
figure()
subplot(121)
plot((1:300).*frame_length,msd2d_yz.', 'LineWidth',2)
xlabel('Time lag [s]','Interpreter','latex');
ylabel('MSD in yz [$$\mu$$m]$$^2$$','Interpreter','latex');
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;

subplot(122)
curve1 = mean(msd2d_yz,1) + std(msd2d_yz,1);
curve2 = mean(msd2d_yz,1) - std(msd2d_yz,1);
inBetween = [curve1, fliplr(curve2)];
fill([1:300, fliplr(1:300)].*frame_length, inBetween, 'r','LineStyle','none');
alpha 0.25
hold on
plot((1:300).*frame_length,mean(msd2d_yz,1), 'r', 'LineWidth',2)
xlabel('Time lag [s]','Interpreter','latex');
ylabel('MSD in yz [$$\mu$$m]$$^2$$','Interpreter','latex');
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
print(gcf,'MSD_diffusion_on_cylinder_yz','-dpng','-r300');
%%
n_points=40;
figure()
p3d = polyfit(frame_length.*(1:5),mean(msd3d(:,1:5),1),1);
p3d(1)/6
plot(frame_length.*(0:n_points), p3d(1)*(frame_length.*(0:n_points))+ p3d(2), 'k','LineWidth',2);
hold on
pxy = polyfit(frame_length.*(1:5),mean(msd2d_xy(:,1:5),1),1);
pxy(1)/4
plot(frame_length.*(0:n_points), pxy(1)*(frame_length.*(0:n_points))+ pxy(2), 'b','LineWidth',2);
hold on
pyz = polyfit(frame_length.*(1:5),mean(msd2d_yz(:,1:5),1),1);
plot(frame_length.*(0:n_points), pyz(1)*(frame_length.*(0:n_points))+ pyz(2), 'r','LineWidth',2);
hold on
pyz(1)/4
scatter(frame_length.*(1:n_points), mean(msd3d(:,1:n_points),1), 20, 'k')
hold on
scatter(frame_length.*(1:n_points), mean(msd2d_xy(:,1:n_points),1), 20, 'b')
hold on
scatter(frame_length.*(1:n_points), mean(msd2d_yz(:,1:n_points),1), 20, 'r')
hold on
%xlim([0,0.5])
legend('3d', 'xy', 'yz','Interpreter','latex');
xlabel('Time lag [s]','Interpreter','latex');
ylabel('MSD [$$\mu$$m]$$^2$$','Interpreter','latex');
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
print(gcf,'MSD_diffusion_on_cylinder_linear','-dpng','-r300');
