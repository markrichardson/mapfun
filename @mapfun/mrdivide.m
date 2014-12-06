function mfOut = mrdivide(ff,gg)
% MRDIVIDE   / division operator for mapfun objects

if isa(ff,'double') 
    error('double/mapfun not defined; did you mean to use ./ instead?')
    
elseif isa(gg,'double') 
   mfOut = ff*(1/gg);                         	% send to TIMES
    
else
    error('mapfun/mapfun not defined; did you mean to use ./ ?')
    
end