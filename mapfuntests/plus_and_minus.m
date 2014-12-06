function pass = plus_and_minus

tol = mapfunpref('eps');
xx = linspace(0,2,101)';

f = @(x) exp(x); g = @(x) x.^0.1; 
ff = mapfun(f,[0 2]); gg = mapfun(g,[0 2]); 

p = @(x) f(x) + g(x); pp = ff + gg;
m = @(x) f(x) - g(x); mm = ff - gg;

pass(1) = norm(p(xx) - pp(xx),inf) < 2e3*tol;
pass(2) = norm(m(xx) - mm(xx),inf) < 2e3*tol;

p2 = @(x) f(x) + 2; pp2 = ff + 2;
pass(3) = norm(p2(xx) - pp2(xx),inf) < 5e2*tol;

m2 = @(x) g(x) - 2; mm2 = gg - 2;
pass(4) = norm(m2(xx) - mm2(xx),inf) < 5e1*tol;
