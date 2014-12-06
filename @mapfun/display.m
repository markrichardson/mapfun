function display(mapfun)
% DISPLAY specifies what is shown when a mapfun object is displayed

% Mark Richardson, August 2012.

disp(' ')
if isempty(mapfun)
    disp([inputname(1) ' ='])
    fprintf(' empty mapfun \n')
    fprintf('      interval       length    endpoint values\n')
    fprintf('         []            []             []       \n')   
%     fprintf('vertical scale = [] \n\n')    
else
    disp([inputname(1) ' =']), disp(' ')
    fprintf('   mapfun \n')
    fprintf('      interval      length     endpoint values\n')
    fprintf('    ( %3.5g,%3.5g )    %5d         %3.5g     %3.5g \n',...
        mapfun.ends(1),mapfun.ends(2),length(mapfun.fun),mapfun.leftval,feval(mapfun,mapfun.ends(2)))   
    fprintf('    using a scaled interpolant on [%3.5g,0] \n',mapfun.L)
    fprintf('        fun vertical scale = %3.5g \n\n',mapfun.scl)
end
