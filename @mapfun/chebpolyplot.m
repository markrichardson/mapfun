function chebpolyplot(mapfun)
% CHEBPOLYPLOT passes the 'fun' part of a mapfun to chebpolyplot

% Mark Richardson, August 2012.

chebpolyplot(chebfun(mapfun.fun))
