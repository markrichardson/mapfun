function out = isempty(mapfun)
% ISEMPTY	 'true' for empty mapfun
% ISEMPTY(G) 'true' (1) if F is an empty fun, and 'false' (0) otherwise

% Mark Richardson, March 2012

if numel(mapfun) > 1
    out = 0;
else
    out = isempty(mapfun.fun);
end