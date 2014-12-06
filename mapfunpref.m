function varargout = mapfunpref(varargin)
% MAPFUNPREFPREF - sets the mapfun preferences structure
% 
% MAPFUNPREFPREF - intialises MAPFUNPREFPREF and returns current status
% MAPFUNPREFPREF('eps',1e-14) - sets mapfun tolerance to 1e-14
% MAPFUNPREFPREF('formap',@(x) log(x)) - changes x -> s map
% MAPFUNPREFPREF('invmap',@(s) exp(s)) - changes s -> x map

% Mark Richardson, August 2012.

persistent prefs        % remembered by this function

% % if nargin > 1, then the user wants to change a setting
% % first make sure that prefs has been initialised
if isempty(prefs) 
    prefs = initPrefs; 
end

% if nargin is 0 or 1, then we either need to initialise MAPFUNPREFPREF 
% or a user wants to see one or all of the settings
if nargin == 0 
    varargout = {prefs};
    return

elseif nargin == 1

    if isstruct(varargin{1})
        % check that if a struct is passed in, it has the 
        % same fields as a mapfun prefs struct (TO DO!!)
        prefs = varargin{1};
        varargout = {prefs};

    elseif strcmpi(varargin{1},'factory')
        % set to default settings if 'factory' is passed
        prefs = initPrefs;
        varargout = {prefs};

    else
        varargout{1} = prefs.(varargin{1});
    end

    return

end

k = 1;                            % cycle thorugh {varargin} array
while k <= length(varargin)       % change prefs structure accordingly

   if strcmpi('eps',varargin{k})
       if ~isnumeric(varargin{k+1})
           error('require a floating-point value for ''eps'' preference ')
       end
       prefs.eps = varargin{k+1};
       k = k + 2;

   elseif strcmpi('domain',varargin{k})
       if sum(size(varargin{k+1})==[1 2])~=2
           error('require a vector [a b] for ''domain'' preference ')
       end
       prefs.domain = varargin{k+1};
       k = k + 2;

   elseif strcmpi(varargin{k},'map')
       
       if ischar(varargin{k+1})
           prefs.map = varargin{k+1};
           prefs.param = [];                % reset param pref
           % calls the SETMAP function in the root folder (placed 
           % here because it is also accessed from mapfun_ctor)
           if strcmpi(prefs.map,'slit')
               if k + 2 <= nargin && isa(varargin{k+2},'double')
                  prefs.param = varargin{k+2};  % assume if a number is provided 
                  k = k + 3;                    % here it is the strip-map parameter
               else
                  prefs.param = 0.15;           % no stripwidth provided -- use 
                  k = k + 2;                    % an arbitrary default value (default also in mapfun_ctor line 33)
               end
           else
               k = k + 2;
           end
           [formap,invmap,dformap,dinvmap] = setmap(prefs.map,prefs.param);
           prefs.formap = formap;
           prefs.invmap = invmap;
           prefs.dformap = dformap;
           prefs.dinvmap = dinvmap;
       else
          error('please provide a valid map type') 
       end
 
   else
       error('unrecognised mapfunpref')
   end
end

varargout = {prefs};

end

function varargout = initPrefs
% factory values for MAPFUNPREF class
%
%     eps    - default tolerance
%     domain - default problem domain 
%     formap - maps x in (0,1] -> t in (-inf,0]
%     invmap - maps z in (-inf,0] -> x in (a,1]

options =   { 'eps' , 'domain' , 'map' , 'param' , 'formap' , 'invmap' , 'dformap' , 'dinvmap'};
% factoryvals = {eps , [0 1] , 'E' ,@(x) log(x), @(s) exp(s) , @(x) 1./x , @(s) exp(s)};   % one sided exponential map (phiE)
factoryvals = {eps, [0 1] , 'DE' , [] , @(x) -log(1-log(x)), @(t) exp(1-exp(-t)) , @(x) 1./x.*1./(1-log(x)) , @(t) exp(-t).*exp(1-exp(-t)) };   % one sided double-exponential map (phiDE)
for k = 1:length(factoryvals)
    varargout.(options{k}) = factoryvals{k};
end
varargout = {varargout};
end


% function [formap,invmap] = setmap(map)
% % set the map from the following list of standard possibilities:
% % 'E'  the standard one-sided exponential map
% % 'DE' the one-sided double-exponential map
% 
% if strcmpi(map,'E')
%     formap = @(x) log(x);
%     invmap = @(s) exp(s);
% 
% elseif strcmpi(map,'DE')
%     formap = @(x) -log(1-log(x));
%     invmap = @(t) exp(1-exp(-t));
% 
% else    
%     error('require map preference to be one of: ''E'', ''DE'' ')
% end
% 
% end
