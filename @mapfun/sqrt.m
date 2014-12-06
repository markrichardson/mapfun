function mfOut = sqrt(mf)
% SQRT  square root for for mapfun objects

% Mark Richardson, August 2012.

mfOut = comp(mf, @(a) sqrt(a));

% mfOut = mapfun(@(x) sqrt(feval(ff,x)),ff.ends,'L',ff.L);