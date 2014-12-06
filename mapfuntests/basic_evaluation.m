function pass = basic_evaluation

% construct three mapfuns and check that they evaluate satisfactorily

xx = linspace(0,1,101)';   % build vector of test nodes

f1 = @(x) exp(x); ff1 = mapfun(f1);   % functions and sincfuns
f2 = @(x) sqrt(x); ff2 = mapfun(f2);
f3 = @(x) x.^0.2.*cos(30*x); ff3 = mapfun(f3);
f4 = @(x) x.*log(x); ff4 = mapfun(f4);

test_tol = mapfunpref('eps');

pass(1) = max(abs(f1(xx) - ff1(xx))) < 3.5e1*test_tol;
pass(2) = max(abs(f2(xx) - ff2(xx))) < 1.5e1*test_tol;
pass(3) = max(abs(f3(xx) - ff3(xx))) < 2.0e3*test_tol;
pass(4) = max(abs(f4(xx) - ff4(xx))) < 5e1*test_tol;
