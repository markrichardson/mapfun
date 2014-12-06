function rts = roots(mf)
% ROOTS   Numerical roots of a mapfun object. Computes roots of the
% underlying fun and rescales to the problem interval.

% Mark Richardson, August 2012.

rts_s = roots(mf.fun);

invmap = mf.invmap;                         % retrieve inverse map
a = mf.ends(1); b = mf.ends(2);             
rts = a + (b-a)*invmap(rts_s);              % compute roots and rescale

% remove any suspected spurious roots (these can arise as oscillations 
% of the Chebyshev approximation of an exponentially decaying function)
rts( abs(rts - a) < 1e7*mf.scl*length(mf)*(b-a)*mapfunpref('eps') ) = [];

% append a root at zero if there is one
if abs(mf.leftval) < mf.scl*mapfunpref('eps')
    rts = [0 ; rts]; 
end