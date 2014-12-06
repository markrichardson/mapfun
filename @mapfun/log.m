function mfOut = log(mf)
% LOG  natural logarithm for for mapfun objects

% Mark Richardson, August 2012.

mfOut = comp(mf, @(a) log(a));

% mfOut = mapfun(@(x) log(feval(ff,x)),ff.ends,'L',ff.L);