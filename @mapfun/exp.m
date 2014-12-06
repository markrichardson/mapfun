function mfOut = exp(mf)
% EXP  exponential function for mapfun objects

% Mark Richardson, August 2012.

mfOut = comp(mf, @(a) exp(a));

% mfOut = mapfun(@(x) exp(feval(ff,x)),ff.ends,'L',ff.L);