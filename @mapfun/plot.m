function plot(mf,varargin)

% Mark Richardson, August 2012.

if ishold
    ax = axis;
    main_plot(mf,varargin)
    hold on
    axis(ax)
else
%     clf
    main_plot(mf,varargin)
    hold off
end

end

function main_plot(mapfun,plot_prefs)

n = 2003; 
xvals = linspace(mapfun.ends(1),mapfun.ends(2),n)'; 
yvals = feval(mapfun,xvals);

if isempty(plot_prefs)
    plot(xvals,yvals)
else
                 
    invmap = mapfun.invmap;             
       
    if strcmp(plot_prefs{1},'.-')
        plot(xvals,yvals), hold on
        chebnodes = -mapfun.L/2*(chebpts(length(mapfun))-1);
        a = mapfun.ends(1); b = mapfun.ends(2);
        nodes = a + invmap(chebnodes)*(b-a);
        plot(nodes,feval(mapfun,nodes),'.'), hold off
        
    elseif strcmp(plot_prefs{1},'.')
        chebnodes = -mapfun.L/2*(chebpts(length(mapfun))-1);
        a = mapfun.ends(1); b = mapfun.ends(2);
        nodes = a + invmap(chebnodes)*(b-a);
        plot(nodes,feval(mapfun,nodes),'.')
        
    elseif strcmpi(plot_prefs{1},'linewidth')
        plot(xvals,yvals,'linewidth',plot_prefs{2})   
        
    else
        plot(xvals,yvals,plot_prefs{1})
    end
end

mn = min(yvals); mx = max(yvals); cc = 0.05;

if length(mapfun)>1
    axis([mapfun.ends(1) mapfun.ends(2) ...
                min((1-cc)*mn,(1+cc)*mn) max((1-cc)*mx,(1+cc)*mx)])
end 

end


% function plot(mapfun)
% 
% % PLOT     plots mapfuns by sampling the interpolant at 2000 points
% 
% a = mapfun.ends(1); b = mapfun.ends(2);
% 
% xx = linspace(a,b,2001);
% plotvals = feval(mapfun,xx);
% 
% plot(xx,plotvals)