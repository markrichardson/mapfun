function pass = rootfinding

f3 = @(x) x.^0.5.*cos(10*pi*x); ff3 = mapfun(f3);

pass(1) = max(abs(roots(ff3) - [0 0.05:0.1:0.95]')) < 5e1*mapfunpref('eps');