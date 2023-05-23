clear all;
clc;

data=csvread("PHS6953HE_lab1_Dataset1.csv", 1,0);

%% positions

figure()
plot(data(:,1),data(:,2),'LineWidth',2)
axis image
xlabel('x [$$\mu$$m]','Interpreter','latex');
ylabel('y[$$ \mu$$m]','Interpreter','latex');

set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
%set(gcf,'position',[10,10,800, 500]) % [x0 y0 width heigth]
%print(gcf,'5a1','-dpng','-r300');

%%


figure()
plot(data(:,3),data(:,1),'LineWidth',2)
hold on
plot(data(:,3),data(:,2),'LineWidth',2)
legend('x direction', 'y direction','Interpreter','latex', 'Location','best');
xlabel('Time [s]','Interpreter','latex');
ylabel('Position [$$\mu$$m]','Interpreter','latex');
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
%set(gcf,'position',[10,10,800, 500]) % [x0 y0 width heigth]
%print(gcf,'5a2','-dpng','-r300');

%% Displacement

Displacements = data(2:end,1:2)- data(1:end-1,1:2);

figure()
histogram(Displacements(:,1));
hold on
histogram(Displacements(:,2));

xlabel('Position [$$\mu$$m]','Interpreter','latex');
ylabel('Counts','Interpreter','latex');
legend('x direction', 'y direction','Interpreter','latex', 'Location','best');

set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
%set(gcf,'position',[10,10,800, 500]) % [x0 y0 width heigth]
print(gcf,'5b','-dpng','-r300');

%% MSD

figure()
max_time_lag=10;
for time_lag = 1:max_time_lag
measured_displacements = data((1+time_lag):end,1:2)- data(1:(end-time_lag),1:2);
squared_displacements = measured_displacements.^2;
sum_squared_displacements = sum(squared_displacements,2);
mean_squared_measured_displacement(time_lag)=mean(sum_squared_displacements);
hold on
scatter(0.1*time_lag,mean_squared_measured_displacement(time_lag), 100,'b')
end
p = polyfit(0.1*(1:time_lag),mean_squared_measured_displacement,1);
slope = p(1);
intercept = p(2);
plot(0:0.1*max_time_lag, slope*(0:0.1*max_time_lag)+intercept, 'b', 'LineWidth',2);
xlabel('Time lag [s]','Interpreter','latex');
ylabel('MSD [$$\mu$$m]$$^2$$','Interpreter','latex');
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
set(gcf,'position',[10,10,800, 500]) % [x0 y0 width heigth]
caption = sprintf('y = %f x + %f', p(1), p(2));
text(0.1, 0.1, caption, 'FontSize', 16, 'Color', 'k', 'Interpreter','latex');
%print(gcf,'5c','-dpng','-r300');


