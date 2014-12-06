function mf = mapfun_ctor(mf,varargin)
% MAPFUN_CTOR  constructor for mapfun objects

% Mark Richardson, August 2012.

op = tidy_input(varargin{1});       % assume first argument is a function handle            
npts = []; L = [];                  % initialise stuff
prefs = mapfunpref;                 % get current prefs

k = 2;                              % cycle through varargin array and
while k <= length(varargin)         % change prefs structure accordingly
    
   if ischar(varargin{k})
       if strcmpi(varargin{k},'eps')        % tolerance
           prefs.eps = varargin{k+1};
           k = k + 2;
           
       elseif any(strcmpi(varargin{k},{'E','DE'}))
           prefs.map = varargin{k}; 
           [formap,invmap,dformap,dinvmap] = setmap(prefs.map); 
           prefs.formap = formap;
           prefs.invmap = invmap;   
           prefs.dformap = dformap; 
           prefs.dinvmap = dinvmap; 
           k = k + 1;
           
       elseif any(strcmpi(varargin{k},{'slit'}))
           prefs.map = varargin{k};     
           if k + 2 <= nargin && isa(varargin{k+1},'double')
              prefs.param = varargin{k+1};  % assume if a number is provided 
              k = k + 2;                    % here it is the strip-map parameter
           else
              prefs.param = 0.15;           % no stripwidth provided -- use 
              k = k + 1;                    % an arbitrary default value (default also in mapfunpref line 75)
           end
           [formap,invmap,dformap,dinvmap] = setmap(prefs.map,prefs.param); 
           prefs.formap = formap;
           prefs.invmap = invmap;   
           prefs.dformap = dformap; 
           prefs.dinvmap = dinvmap; 
           
       elseif strcmpi(varargin{k},'L')
           L = varargin{k+1};
           k = k + 2;
           
       else
           error('unrecognised string input in call to mapfun constructor')
       end
       
       
   else 
       % domain vector [a b] provided
       if isa(varargin{k},'double') && sum(size(varargin{k})==[1 2])==2
           prefs.domain = varargin{k};
       % integer provided (the number of sample points)
       elseif isa(varargin{k},'double') && sum(size(varargin{k})==[1 1])==2 % && mod(varargin{k},1) == 0
           npts = varargin{k};
       end
       k = k + 1;  
       
   end
end

a = prefs.domain(1);                          % rescale the function 
b = prefs.domain(2);                          % provided on [a,b] to a 
f = @(x) op( a + x*(b-a) );                   % function on [0,1]

x = linspace(a,b,12);                         % estimate vertical scale
scl = max(abs(feval(op,x))); 
mf.scl = scl;

% define other fields
mf.ends = prefs.domain;                        % domain of definition
mf.leftval = op(a + realmin);                  % store left endpoint

% set very small left function values to zero (for aesthetic reasons)
if abs(mf.leftval) < eps*scl; mf.leftval = 0; end

mf.map = prefs.map;
mf.param = prefs.param;
mf.formap = prefs.formap;                      % formap 
mf.invmap = prefs.invmap;                      % invmap used in construction
mf.dformap = prefs.dformap;
mf.dinvmap = prefs.dinvmap;

if isempty(L)
    mf.L = determineL(f,prefs.invmap,mf.scl);  % adaptively work out domain 
else                                           % parameter L if one is not
    mf.L = L;                                  % provided in varargin
    
end

% call 'fun' and stored the result as a mapfun field
% (fun accounts for interval rescalings, so we always work on [-L 0])
mf.fun = fun(@(t) f(prefs.invmap(t)),[mf.L 0],npts); 

end

function gout = tidy_input(g)
% Deal with the input argument g. If g is a string, convert it 
% to an anonymous function. If it is a constant, set this to the 
% corresponding anonymous function.
if isa(g,'char'), eval(['g = @(x) ' g ';']), end
if isnumeric(g), g = @(x) 0.*x + g;  end
% check for constant function
if isa(g,'function_handle')
    t = functions(g); str = t.function;
    str2 = str(strfind(str,')')+1:end); % look for bit after @(x) ...
    if sum(isletter(str2)) == 0, g1 = eval(str2); g = @(x) 0.*x + g1; end
    gout = g;
end
if isa(g,'mapfun'), gout = @(x) feval(g,x); end
end

function Lout = determineL(f,map,scl)
% determines L for a given input function and map

tol = scl*1e-16;
f0 = f(0); 
if isnan(f0); 
    f0 = f(realmin); 
end

A = -800; B = 0; 
Mlast = 0; M = Inf; 

while abs(M-Mlast) > 2e-16
    Mlast = M; 
    M = (A+B)/2;
    if  abs(f(map(M))-f0) > tol
        B = M; 
    else
        A = M; 
    end
end
Lout = M;
end
