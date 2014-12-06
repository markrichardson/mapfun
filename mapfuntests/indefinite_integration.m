function pass = indefinite_integration

% check the indefinite integration process works

tol = mapfunpref('eps');

xx = linspace(-1,1,101)';

f1 = @(x) exp(x); ff1 = mapfun(f1,[-1 1]); 
g1 = @(x) exp(x); gg1 = cumsum(ff1);
pass(1) = max(abs(g1(xx) - exp(-1) - gg1(xx))) < 90*tol;

xx = linspace(0,1,101)';

f2 = @(x) sqrt(x); ff2 = mapfun(f2);
g2 = @(x) 2/3*x.^(3/2); gg2 = cumsum(ff2);
pass(2) = max(abs(g2(xx) - gg2(xx))) < 35*tol;

f3 = @(x) sin(2*pi*x); ff3 = mapfun(f3);
g3 = @(x) -1/2/pi*cos(2*pi*x); gg3 = cumsum(ff3);
pass(3) = max(abs(g3(xx) + 1/2/pi - gg3(xx))) < 30*tol;

xx = linspace(0,3,101)';

f4 = @(x) x.^(1/4); ff4 = mapfun(f4,[0 3]);
g4 = @(x) 4/5*x.^(5/4); gg4 = cumsum(ff4);
pass(4) = max(abs(g4(xx) - gg4(xx))) < 150*tol;
