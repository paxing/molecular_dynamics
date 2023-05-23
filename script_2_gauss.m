
x= linspace(-10,10,1001);
sigma=1;
mu=1;
gaus= 1/(sqrt(2*pi)*sigma)*exp(-(x-mu).^2/(2*sigma^2));


%%

figure()
plot(x,gaus, 'b','LineWidth',2)
hold on
plot([-sqrt(2*log(2))*sigma+mu,sqrt(2*log(2))*sigma+mu], [1/2*max(gaus), 1/2*max(gaus)], 'r', 'LineWidth',2)

legend('Gaussian ditribution', 'FWHM','Interpreter','latex');
ylabel('Amplitude (a.u.)','Interpreter','latex');

xlabel('Position ($$x$$)','Interpreter','latex');
set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
ax=gca;
ax.LineWidth=1.5;
set(gcf,'position',[10,10,800, 500]) % [x0 y0 width heigth]
print(gcf,'gauss','-dpng','-r300');
