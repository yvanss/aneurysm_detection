function createfigureThres(Y1, X1, X2,x_label,save_name)
%CREATEFIGURE1(Y1,X1,X2)
%  Y1:  vector of y data
%  X1:  stem x
%  X2:  stem x

%  Auto-generated by MATLAB on 21-Mar-2013 19:20:18

% Create figure
figure1 = figure('Color',[1 1 1]);
font_size=20;
% Create axes
axes1 = axes('Parent',figure1,'YGrid','on',...
    'XTickLabel',{'0','50','100','150','200','255'},...
    'XTick',[0 50 100 150 200 255],...
    'XGrid','on',...
    'FontName','Times New Roman','FontSize',font_size);
% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 255]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0 1]);
box(axes1,'on');
hold(axes1,'all');

% Create xlabel
ylabel(['\textbf{' x_label ' $\longrightarrow$}'],'Interpreter','latex',...
    'FontSize',font_size);

% Create ylabel
xlabel(['\textbf{Global Threshold$\longrightarrow$}'],'Interpreter','latex',...
    'FontSize',font_size);

% Create plot
plot(Y1,'Parent',axes1,'LineWidth',2,'DisplayName','Global Threshold');

if strcmp(x_label,'Accuracy')
    last='%';
else
    last='';
end

% Create stem
stem(X1,Y1(X1),'LineWidth',2,...
    'Color',[0 1 0],...
    'Parent',axes1,...
    'DisplayName',['Auto-Threshold Value = ' num2str(X1) sprintf('\n') 'where ' x_label ' = ' num2str(round(Y1(X1)*100)/100) last]);

% Create stem
stem(X2,Y1(X2),'LineWidth',2,'Color',[1 0 0],'Parent',axes1,...
    'DisplayName',['Otsu Threshold Value = ' num2str(X2) sprintf('\n') 'where ' x_label ' = ' num2str(round(Y1(X2)*100)/100) last]);

% Create legend
legend(axes1,'show');
set(legend,'Location','SouthEast','FontSize',font_size);

if ~isequal(save_name,'')
    saveas(figure1,['.\htmlC\' save_name '.png']);
    saveas(figure1,['.\htmlC\' save_name '.eps'],'psc2');
    saveas(figure1,['.\htmlC\' save_name '.fig']);
    snapnow
    close(figure1)
end
