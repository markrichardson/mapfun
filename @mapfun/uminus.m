function mfOut = uminus(mf)
% UMINUS unary minus for mapfun objects.
% 
% Mark Richardson, August 2012.

mfOut = mf;

% Everything stays the same except the following fields:

mfOut.fun = -mf.fun;
mfOut.leftval = -mf.leftval;