function [mVal,mPos] = min(mf,localFlag)
% MIN	global/local minima of a mapfun on its interval of definition
% 
% MIN(MF) is the global minimum of the mapfun G
% 
% [Y,X] = MAX(MF) returns the value X s.t. Y = MF(X) is the global minimum
% 
% [Y,X] = MAX(MF,'LOCAL') returns the vector of values X s.t. Y = MF(X) are
% the local minima of the mapfun MF.

% Mark Richardson, August 2012.

if nargin == 1
    [mVal,mPos] = max(-mf);
else
    [mVal,mPos] = max(-mf,localFlag);
end

mVal = -mVal;


