classdef mapfun
% MAPFUN	Class definition for mapfun objects
% 
% MAPFUN(OP,ENDS) constructs a mapfun object for the function OP.  
%
% MAPFUN(OP,ENDS,N) where N a positive integer creates a fun for OP with N 
% Chebyshev points. This option is not adaptive.
% 
% mapfun objects consist of: 
% 
%       - a domain parameter, L
%       - a 'fun' corresponding to the transplanted function

% Mark Richardson, August 2012
    
    properties ( GetAccess = 'public' , SetAccess = 'public' )
        fun = [];  
        ends = [];
        leftval = [];
        map = [];
        param = [];
        formap = [];
        invmap = [];
        dformap = [];
        dinvmap = [];
        L = [];
        scl = [];
    end

    methods

        function mf = mapfun(varargin)
            if nargin == 0          
                return
            else
                mf = mapfun_ctor( mf , varargin{:} );
            end
        end      

    end

end

% Will help a great deal to embed all the composition operations, sin(ff)
% etc within a private/comp.m file. This way, it wil be easy to make any
% big changes to all the files just by altering comp.m.

% Eventually, will need to just carry the 'E','DE' etc. flag around as a 
% field, rather than the function handles explicitly. This should make it
% easier to adjust the slit map parameters. Also, currently to switch
% between maps, we need to use the mapfunpref('map',...) call. If we
% instead construct using mapfun(f,'map',...) we currently won't get 
% correct integrals etc unless mapfunpref is the same.

% chopping off spurious roots near exponential decay:
%                   roots.m
%                   max.m
%                   minandmax.m

% One or both of the transforms are required in the following files:    
%                   private/mapfun_ctor.m
%                   feval.m
%                   plot.m
%                   roots.m

% We feed the L field into the constructor call in the following files. In
% general, we use the largest of the two Ls, since in feval, we replace
% extreme values with the left limit:
%                   power.m
%                   compose.m
%                   minus.m
