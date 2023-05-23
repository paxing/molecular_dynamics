clear all;
clc;


diffusion_coefficient = 0.1; %um^2/s
r=0.25; % um
frame_length=0.1; % 100 ms
number_of_steps = 25;
number_of_dimensions = 3;
number_of_molecules=1000;
%% surface of cylinder = rectangle

%surface of the cylinder
for i = 1:number_of_molecules
initial_position = sqrt(2*diffusion_coefficient*frame_length).*randn(1,number_of_dimensions-1);
dxz = sqrt(2*diffusion_coefficient*frame_length).*randn(number_of_steps, number_of_dimensions-1);
position = [initial_position; initial_position+cumsum(dxz,1)];
%% mapping for 2d rect projection to cylinder
H = position(:,1); %x axis is the h cylindrical coordinates
R = r*ones(number_of_steps+1,1); % the radius is fixed at r
T = position(:,2)./R; %theta coordinates is defined as (theta)=Z/R
%% convert cylindrical coordinates back to cart for matlab
[z,y,x] = pol2cart(T,R,H);
time_lag=1;
displacements = [x((1+time_lag):end)-x(1:(end-time_lag)) ...
    y(1+time_lag:end)-y(1:end-time_lag) z(1+time_lag:end)-z(1:end-time_lag)];
squared_displacements = displacements.^2;
msd2d_xy(i,:)=sum(squared_displacements(:,1:2),2);

%p = polyfit(frame_length.*(1:5), msd2d_xy(i,1:5),1);
%diffusion_coefficient_xy(i)=p(1)/4;
diffusion_coefficient_xy(i,:) =  msd2d_xy(i,:)/(4*frame_length);
y_position(i,:)=y(2:end);
end


%%
figure()

scatter(y_position(:), smooth(y_position(:), diffusion_coefficient_xy(:),10000),'r')

xlim([-0.25 0.25])
ylim([0 0.1])
xlabel('Y position [$$\mu$$m]','Interpreter','latex');
ylabel('D [$$\mu$$m]$$^2$$/s','Interpreter','latex');
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
%print(gcf,'MSD_diffusion_on_cylinder_fct_y','-dpng','-r300');
