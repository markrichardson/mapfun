function [mnandmxVal,mnandmxPos] = minandmax(mf,localFlag)
% MINANDMAX   minimum and maximum values of a mapfun.

% Mark Richardson, August 2012.

if nargin == 1
   
    [mnVal,mnPos] = min(mf);                  % call min
    [mxVal,mxPos] = max(mf);                  % call max
    mnandmxVal = [ mnVal ; mxVal ];           % place in output vector
    mnandmxPos = [ mnPos ; mxPos ];
        
elseif strcmpi(localFlag,'local') 
    
    dfun = diff(mf.fun);                      % first derivative of fun
    dfunroots = roots(dfun);                  % roots of fun deriv 
    a = mf.ends(1); b = mf.ends(2);           % interval endpoints
    invmap = mf.invmap;                       % retrieve the map
    mnandmxPos = a + (b-a)*invmap(dfunroots); % compute roots and rescale
    mnandmxVal = feval(mf,mnandmxPos);
%     idx = abs( mnandmxVal - mf.leftval ) < 1e3*mf.scl*mapfunpref('eps');
    idx = abs( abs(mnandmxPos - a) ) < 1e7*mf.scl*length(mf)*(b-a)*mapfunpref('eps');
    mnandmxPos( idx ) = [];                   % remove any oscillations 
    mnandmxVal( idx ) = [];
    
else

    error('unrecgonised second argument')
    
end
