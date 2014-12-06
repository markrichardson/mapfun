function mfOut = compose(ff,gg)
% COMPOSE computes the composition ff(gg) of the two mapfuns ff and gg.

% first check that the range of gg is in the domain of ff
mn = min(gg); mx = max(gg);
a = ff.ends(1); b = ff.ends(2);
tol = mapfunpref('eps');

if mn < a - tol || mx < a - tol || mn > b + tol || mx > b + tol
    error('f(g) requires the range of g to be in the domain of f')
end

% we use the domain of ff and the largest (in abs val) of the two L's
mfOut = mapfun(@(x) feval(ff,feval(gg,x)),ff.ends,'L',min(ff.L,gg.L));