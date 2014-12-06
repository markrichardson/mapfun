function mfOut = cos(mf)
% COS  cosine function for mapfun objects

% Mark Richardson, August 2012.

 mfOut = comp(mf, @(a) cos(a));

% mfOut = mapfun(@(x) cos(feval(ff,x)),ff.ends,'L',ff.L);