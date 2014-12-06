function mfOut = cumsum(mf)
% CUMSUM compute the indefinite integral of a mapfun.

% Mark Richardson, August 2012.

a = mf.ends(1); 
b = mf.ends(2);

if any(strcmpi(mf.map,{'slit'}))
        rho = mapfun(@(x) feval(mf,a+(b-a)*x)./mf.dformap(x),...
                                        [0 1],mf.map,mf.param,'L',mf.L);
else
    rho = mapfun(@(x) feval(mf,a+(b-a)*x)./mf.dformap(x),...
                                        [0 1],mf.map,'L',mf.L);
end

mfOut = mf; 
mfOut.fun = (b-a)*cumsum(rho.fun); 

% Following the chebfun convention, we set the left value to zero.
mfOut.leftval = 0;          
    
% re-estimate scale
x = linspace(a,b,12); 
scl = max(abs(feval(mfOut,x))); 
mfOut.scl = scl;