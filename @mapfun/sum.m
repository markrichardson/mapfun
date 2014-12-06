function val = sum(mf)
% SUM compute the definite integral of a mapfun.

% Mark Richardson, August 2012.

% Regardless of the domain of definition of mf, rho needs to be a 
% function on [0 1]. So we rescale mf itself but not mf.deriv.
a = mf.ends(1); b = mf.ends(2);

if any(strcmpi(mf.map,{'slit'}))
        rho = mapfun(@(x) feval(mf,a+(b-a)*x)./mf.dformap(x),...
                                        [0 1],mf.map,mf.param,'L',mf.L);
else
    rho = mapfun(@(x) feval(mf,a+(b-a)*x)./mf.dformap(x),...
                                        [0 1],mf.map,'L',mf.L);
end                                        
                                                                           
val = (b-a)*sum(rho.fun);