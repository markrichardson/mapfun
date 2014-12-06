function pass = constructor_options

% construct mapfuns to check that the various input options work

dom = [-2 1]; f1 = @(x) exp(x); ff1 = mapfun(f1,dom,400);
xx = linspace(dom(1),dom(2),51)';
pass(1) = max(abs(f1(xx) - ff1(xx))) < 70*mapfunpref('eps');

xx = linspace(0,1,51);

f2 = @(x) sqrt(x).*cos(x); ff2 = mapfun(f2,'E');
pass(2) = max(abs(f2(xx) - ff2(xx))) < 10*mapfunpref('eps');

f3 = @(x) x.^0.2.*cos(30*x); ff3 = mapfun(f3,'DE');
pass(3) = max(abs(f3(xx) - ff3(xx))) < 50*mapfunpref('eps');

f4 = @(x) x.*log(x); ff4 = mapfun(f4,'L',-5);
pass(4) = max(abs(f4(xx) - ff4(xx))) < 10*mapfunpref('eps');