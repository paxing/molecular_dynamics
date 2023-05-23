clear all;
clc;
%%
starting_position_x = 0;
starting_position_y = 0;
starting_position_z = 0;
diffusion_coefficient = 100; %um^2/s
number_of_dimensions = 3;
number_of_molecules = 10000;
frame_length=0.0001; % in s
radius_limit = [1 5 10]; % um
z_limit = 2/1000; % 2nm limit
%%
time_for_each_radius = zeros(numel(radius_limit),number_of_molecules);
for j = 1:numel(radius_limit)
    time = [];
    for i = 1:number_of_molecules
        position_x = starting_position_x;
        position_y = starting_position_y;
        position_z = starting_position_z;
        
        current_radius = sqrt(position_x^2+position_y^2);
        number_of_frames=0;
        while current_radius < radius_limit(j)
            dxyz = sqrt(2*diffusion_coefficient*frame_length).*randn(1, number_of_dimensions);
                    
            position_x = position_x + dxyz(1);
            position_y = position_y + dxyz(2);
            current_radius = sqrt(position_x^2+position_y^2);
            number_of_frames=number_of_frames+1;
        end
        time = [time number_of_frames*frame_length];
    end
    
  time_for_each_radius(j,:)=time;
end

%%

average_time = mean(time_for_each_radius,2);
std_time=std(time_for_each_radius,0,2);
%%
figure()
for i = 1:numel(radius_limit)
histogram(time_for_each_radius(i,:), 0:0.01:0.6);
hold on
end
legend('1$$ \mu$$m', '5$$ \mu$$m', '10$$ \mu$$m','Interpreter','latex')
ylabel('Counts','Interpreter','latex');
xlabel('Time (s)','Interpreter','latex');
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
%print(gcf,'Rayleigh_g','-dpng','-r300');

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
edges(idx(1)).*1000
% % Define Start points, fit-function and fit curve
% fitfun = fittype( @(b,x) raylcdf(x,b) );
% [fitted_curve,gof] = fit(edges.',cummulative_rayleigh.',fitfun,'StartPoint',x0(i));
% coeffvals = coeffvalues(fitted_curve);
% %coeffvals
% (sqrt(2*coeffvals^2*log(20)))
end
legend('1$$ \mu$$m', '5$$ \mu$$m', '10$$ \mu$$m','Interpreter','latex')
ylabel('Cummulative probability','Interpreter','latex');
xlabel('Time (s)','Interpreter','latex');
xlim([0 1])
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
%print(gcf,'cummulative_Rayleigh_g','-dpng','-r300');
%%


