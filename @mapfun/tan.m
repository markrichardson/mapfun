function mfOut = tan(mf)
% TAN  tangent function for mapfun objects

% Mark Richardson, August 2012.

if isempty(roots(cos(mf)))
%     mfOut = mapfun(@(x) tan(feval(ff,x)),ff.ends,'L',ff.L);
    mfOut = comp(mf, @(a) tan(a));
else
    error('applying TAN may result in one or more divergent point singularities')
end
