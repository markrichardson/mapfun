function mfOut = sin(mf)
% SIN  sine function for mapfun objects

% Mark Richardson, August 2012.

mfOut = comp(mf, @(a) sin(a));

% mfOut = mapfun(@(x) sin(feval(ff,x)),ff.ends,'L',ff.L);