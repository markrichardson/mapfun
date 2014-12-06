function pass = times_and_divide

tol = mapfunpref('eps');
xx = linspace(0,2,101)';

f = @(x) exp(x); g = @(x) x.^0.1; 
ff = mapfun(f,[0 2]); gg = mapfun(g,[0 2]); 

t = @(x) f(x).*g(x); tt = ff.*gg;
d = @(x) g(x)./f(x); dd = gg./ff;

pass(1) = norm(t(xx) - tt(xx),inf) < 2e3*tol;
pass(2) = norm(d(xx) - dd(xx),inf) < 2e2*tol;

m2 = @(x) f(x)*2; mm2 = ff*2;
pass(3) = norm(m2(xx) - mm2(xx),inf) < 5e2*tol;

d2d =@(x) 2./f(x); dd2d = 2./ff;
pass(4) = norm(d2d(xx) - dd2d(xx),inf) < 5e2*tol;

d2 = @(x) g(x)/2; dd2 = gg/2;
pass(5) = norm(d2(xx) - dd2(xx),inf) < 5e1*tol;