function mfOut = mtimes(ff,gg)
% MTIMES   * multiplication operator for mapfun objects

if isa(ff,'double') || isa(gg,'double') 
    mfOut = ff.*gg;                         	% send to TIMES
    
else
    error('mapfun*mapfun not defined; did you mean to use .* ?')
    
end