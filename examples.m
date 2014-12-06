% examples
%% 1.
f = @(x) sin(pi/2*x); g = @(x) sqrt(x);
fc = chebfun(f,[0 1]);
fm = mapfun(f); gm = mapfun(g);
length(fc.^fc)
length(fm.^fm)
t = gm.^fm
%% 2. 
f = @(x) exp(x); g = @(x) sqrt(x);
ff = mapfun(f); gg = mapfun(g);
gg
t = ff(gg)
%% 3. 
% with constant 1.05 Exponenital map (length 1085) vs DE map (length 603)
% vs slit map using strip width of 1.05 (386)
alpha = 0.05;
f = @(x) log(cos(2*pi*x) +1 + alpha);    % try changing the added constant
fe = mapfun(f,'e')
fde = mapfun(f,'de')
fs = mapfun(f,'slit',alpha)
plot(fs.fun)
%% 4. 
M = 1e4; f = @(x) sin(M*x); mapfun(f,'e'), mapfun(f,'slit',1\log(M)), 1\log(M)
%% 5.
M = 6e3; f = @(x) sin(M*x); mapfun(f,'e'), ff = mapfun(f,'slit',31/M), 30/M
length(chebfun(f,[0 1]))
%% 
% something funny/interesting happens when a singular facot is placed inside
% a sine or cosine as opposed to multipliyng it:
M = 1e3; 
f = @(x) sqrt(x).*cos(2*pi*M*x);
g = @(x) cos(2*pi*M*sqrt(x));
fe = mapfun(f,'e')
fs = mapfun(f,'slit',10/M)

ge = mapfun(g,'e')
gs = mapfun(g,'slit',10/M)
% may it be the case that you can't do signifcantly better htan the
% exponential map when the singualr term is inside the cosine?


