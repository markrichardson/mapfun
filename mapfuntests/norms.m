function pass = norms

tol = mapfunpref('eps');

f = @(x) exp(x); g = @(x) x.^0.1; 
ff = mapfun(f,[0 2]); gg = mapfun(g,[0 2]); 

pass(1) = abs(norm(ff,2) - 5.176782303378431) < 25* tol;
pass(2) = abs(norm(ff,inf) - 7.389056098930650) < 10* tol;
pass(3) = norm(ff-ff) == 0;

pass(4) = abs(norm(gg,2) - 1.383653590436708) < 25*tol;
pass(5) = abs(norm(gg,inf) - 1.071773462536293) < 10*tol;

