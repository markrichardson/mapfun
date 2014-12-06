function pass = definite_integration

tol = mapfunpref('eps');

f1 = @(x) exp(x); ff1 = mapfun(f1,[-1 1]);
pass(1) = abs(sum(ff1) - (exp(1)-exp(-1))) < 40*tol;

f2 = @(x) sqrt(x); ff2 = mapfun(f2);
pass(2) = abs(sum(ff2) - 2/3) < 5*tol;

f3 = @(x) sin(2*pi*x); ff3 = mapfun(f3);
pass(3) = abs(sum(ff3)) < 5*tol;

f4 = @(x) x.*log(x); ff4 = mapfun(f4);
pass(4) = max(sum(ff4) -(-0.25)) < 2*mapfunpref('eps');