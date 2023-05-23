clear all;
clc;
%%
starting_position_x = 0;
starting_position_y = 0;
diffusion_coefficient = 0.3; %um^2/s
number_of_dimensions = 2;
number_of_molecules = 10000;
frame_length=0.1; % in s
radius_limit = [1 5 10]; % um
%%
time_for_each_radius = zeros(numel(radius_limit),number_of_molecules);
figure()
for j = 1:numel(radius_limit)
    time = [];
    for i = 1:number_of_molecules
        position_x = starting_position_x;
        position_y = starting_position_y;
        trajectory_x = [position_x];
        trajectory_y = [position_y];
        
        current_radius = sqrt(position_x^2+position_y^2);
        number_of_frames=0;
        while current_radius < radius_limit(j)
            dxy = sqrt(2*diffusion_coefficient*frame_length).*randn(1, number_of_dimensions);
                    
            position_x = position_x + dxy(1);
            position_y = position_y + dxy(2);
            current_radius = sqrt(position_x^2+position_y^2);
            number_of_frames=number_of_frames+1;
            trajectory_x = [trajectory_x position_x];
            trajectory_y = [trajectory_y position_y];
        end
        time = [time number_of_frames*frame_length];
    end
    
  time_for_each_radius(j,:)=time;
  plot(trajectory_x, trajectory_y)
  hold on
end
set(gca,'ColorOrderIndex',1)
for r=radius_limit
    theta = linspace(0,2*pi,100);
    plot(r*cos(theta),r*sin(theta))
    hold on
end
legend('1$$ \mu$$m', '5$$ \mu$$m', '10$$ \mu$$m','Interpreter','latex')
ylabel('Y position ($$\mu$$m)','Interpreter','latex');
xlabel('X position ($$\mu$$m)','Interpreter','latex');
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
axis image
%print(gcf,'exemple_trajectory','-dpng','-r300');
%%

average_time = mean(time_for_each_radius,2);
std_time=std(time_for_each_radius,0,2);
%%
figure()
for i = 1:numel(radius_limit)
histogram(time_for_each_radius(i,:), 0:0.5:100);
hold on
end
legend('1$$ \mu$$m', '5$$ \mu$$m', '10$$ \mu$$m','Interpreter','latex')
ylabel('Counts','Interpreter','latex');
xlabel('Time (s)','Interpreter','latex');
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
%print(gcf,'Rayleigh','-dpng','-r300');

%%
figure()
x0 =[1 10 50];
for i = 1:numel(radius_limit)
[N,edges] = histcounts(time_for_each_radius(i,:),1000);
cummulative_rayleigh = cumsum(N);
cummulative_rayleigh = [0 cummulative_rayleigh]./number_of_molecules;
plot(edges, cummulative_rayleigh, 'LineWidth',2)
hold on
idx=find(round(100.*cummulative_rayleigh)==95);
edges(idx(1))

end
legend('1$$ \mu$$m', '5$$ \mu$$m', '10$$ \mu$$m','Interpreter','latex')
ylabel('Cummulative probability','Interpreter','latex');
xlabel('Time (s)','Interpreter','latex');
xlim([0 400])
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
%print(gcf,'cummulative_Rayleigh','-dpng','-r300');
%%


