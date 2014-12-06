function out = feval(g,x)
% Y = FEVAL(G,X)
% Evaluation of a mapfun G at points X.

% Mark Richardson, August 2012

formap = g.formap;                  
invmap = g.invmap; 

a = g.ends(1); b = g.ends(2);

% extract points which are not equal to left limit
xx = x; xx( x==a ) = a + realmin;

% evaluate interpolant at the mapped points
out = feval(g.fun,formap((xx-a)/(b-a)));    

xL = a + (b-a)*invmap(g.L);      % work out the approximation region [xL,1]
out( xx <= xL ) = g.leftval;      % replace x < xL with left limit

end