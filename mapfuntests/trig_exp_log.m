function pass = trig_exp_log

xx = linspace(-1,1,101)';
tol = mapfunpref('eps');

f = @(x) exp(x); ff = mapfun(f,[-1 1]);
g = @(x) sin(f(x)); gg = sin(ff);
h = @(x) cos(g(x)); hh = cos(gg);
l = @(x) x; ll = log(ff);

pass(1) = max(abs(f(xx) - ff(xx))) < 60*tol;
pass(2) = max(abs(g(xx) - gg(xx))) < 50*tol;
pass(3) = max(abs(h(xx) - hh(xx))) < 50*tol;
pass(4) = max(abs(l(xx) - ll(xx))) < 50*tol;

j = @(x) sqrt(2*x); jj = mapfun(j);
k = @(x) tan(j(x)); kk = tan(jj);

xx = linspace(0,1,101)';
pass(5) = max(abs(k(xx)-kk(xx))) < 7e2*tol;