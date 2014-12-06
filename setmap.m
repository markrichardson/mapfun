function [formap,invmap,dformap,dinvmap] = setmap(map,alpha)
% SETMAP set the map from the following list of standard possibilities:
%     'E'  : the standard one-sided exponential map
%     'DE' : the one-sided double-exponential map

% Mark Richardson, August 2012.

if strcmpi(map,'E')
    formap = @(x) log(x);
    invmap = @(s) exp(s);
    dformap = @(x) 1./x;
    dinvmap = @(s) exp(s);

elseif strcmpi(map,'DE')
    formap = @(x) -log(1-log(x));
    invmap = @(t) exp(1-exp(-t));
    dformap = @(x) 1./x.*1./(1-log(x));
    dinvmap = @(t) exp(-t).*exp(1-exp(-t));

elseif strcmpi(map,'slit')
    gamma = alpha/pi*log(expm1(pi/alpha));
    formap = @(x) alpha/pi*log(expm1(pi/alpha*x))-gamma;
    invmap = @(s) alpha/pi*log1p(exp(pi/alpha*(s+gamma)));
    dformap = @(x) exp(pi/alpha*x)./expm1(pi/alpha*x);
    dinvmap = [];  % work this out at some point (need for mapop)
    
else    
    error('require map preference to be one of: ''E'', ''DE'' ')

end

