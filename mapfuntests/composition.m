function pass = composition

tol = mapfunpref('eps');

f = @(x) exp(x); g = @(x) sqrt(x); h = @(x) f(g(x)); 
ff = mapfun(f); gg = mapfun(g); hh = ff(gg);

xx = linspace(0,1,101)';

pass(1) = max(abs(h(xx)-hh(xx))) < 60*tol;