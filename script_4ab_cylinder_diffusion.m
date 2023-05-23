clear all;
clc;


diffusion_coefficient = 0.1; %um^2/s
r=0.25; % um
frame_length=0.1; % 100 ms
number_of_steps = 500;
number_of_dimensions = 3;

%% surface of cylinder = rectangle

%surface of the cylinder
dxz = sqrt(2*diffusion_coefficient*frame_length).*randn(number_of_steps, number_of_dimensions-1);
position = [zeros(1,2); cumsum(dxz,1)];

%% mapping for 2d rect projection to cylinder

H = position(:,1); %x axis is the h cylindrical coordinates
R = r*ones(number_of_steps+1,1); % the radius is fixed at r
T = position(:,2)./R; %theta coordinates is defined as (theta)=Z/R
%% convert cylindrical coordinates back to cart for matlab

[z,y,x] = pol2cart(T,R,H);


%%
n_step=100;
th=0:pi/100:2*pi;
z_cylinder=r*cos(th);
y_cylinder=r*sin(th);

figure()
surf( [max(x(1:n_step)).*ones(1,size(th,2)); min(x(1:n_step)).*ones(1,size(th,2))],...
    [y_cylinder; y_cylinder], [z_cylinder; z_cylinder], 'FaceColor',[0.5 0.5 0.5],...
    'EdgeColor','none')
alpha 0.5

hold on
plot3(x(1:n_step),y(1:n_step),z(1:n_step),'r', 'LineWidth',1.5)
xlabel('x [$$\mu$$m]','Interpreter','latex')
ylabel('y [$$\mu$$m]','Interpreter','latex')
zlabel('z [$$\mu$$m]','Interpreter','latex')
axis image
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
view(-75,15)
print(gcf,'diffusion_on_cylinder','-dpng','-r300');
%%

figure()
surf( [max(x(1:n_step)).*ones(1,size(th,2)); min(x(1:n_step)).*ones(1,size(th,2))],...
    [y_cylinder; y_cylinder], [z_cylinder; z_cylinder], 'FaceColor',[0.5 0.5 0.5],...
    'EdgeColor','none')
alpha 0.5

hold on
plot3(x(1:n_step),y(1:n_step),z(1:n_step),'r', 'LineWidth',1.5)
xlabel('x [$$\mu$$m]','Interpreter','latex')
ylabel('y [$$\mu$$m]','Interpreter','latex')
zlabel('z [$$\mu$$m]','Interpreter','latex')
axis image
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
view(0,90)  % XY
print(gcf,'diffusion_on_cylinder_xy','-dpng','-r300');
%%
figure()
surf( [max(x(1:n_step)).*ones(1,size(th,2)); min(x(1:n_step)).*ones(1,size(th,2))],...
    [y_cylinder; y_cylinder], [z_cylinder; z_cylinder], 'FaceColor',[0.5 0.5 0.5],...
    'EdgeColor','none')
alpha 0.5

hold on
plot3(x(1:n_step),y(1:n_step),z(1:n_step),'r', 'LineWidth',1.5)
xlabel('x [$$\mu$$m]','Interpreter','latex')
ylabel('y [$$\mu$$m]','Interpreter','latex')
zlabel('z [$$\mu$$m]','Interpreter','latex')
axis image
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
view(90,0)  % YZ
print(gcf,'diffusion_on_cylinder_yz','-dpng','-r300');

%%
