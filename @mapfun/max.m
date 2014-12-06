function [maxVal,pos] = max(mf,localFlag)
% MAX	Global maximum of a mapfun on its interval of definition
% MAX(MF) is the global maximum of the mapfun G
% [Y,X] = MAX(MF) returns the value X s.t. Y = G(X) is the global maximum

% Mark Richardson, August 2012.

% Though we cannot compute derivatives of mapfun objects accurately (since
% the derivative of the map blows up as x -> 0), it is still possible to do
% optimisation since we can compute the roots of the derivative accurately
% without needing to compute the derivative itself accurately.

dfun = diff(mf.fun);                            % first derivative of fun
dfunroots = roots(dfun);                        % roots of fun deriv 
a = mf.ends(1); b = mf.ends(2);                 % interval endpoints
invmap = mf.invmap;                             % retrieve the map
rts = a + (b-a)*invmap(dfunroots);              % compute roots and rescale
% idx = abs(feval(mf,rts)-mf.leftval) < 50*mf.scl*mapfunpref('eps');
idx = abs( abs(rts - a) ) < 1e7*mf.scl*length(mf)*(b-a)*mapfunpref('eps');
rts( idx ) = [];                                % remove any oscillations 

if nargin == 1                     % global maximum
    
    rr = [ a ; rts ; b ];                       % append endpoints
    [maxVal,idx2] = max(feval(mf,rr));          % compute global maximum
    pos = rr(idx2);                             % location of maximum

elseif strcmpi(localFlag,'local')  % local maxima
 
    d2fun = diff(dfun);                         % second derivative of fun
    dfunroots(idx) = [];                        % remove the oscillations
    d2vals = feval(d2fun,dfunroots);            % evaluate 2nd deriv at extrema 
    idx3 = d2vals < 0;                          % find the ones < 0
    pos = rts(idx3);                            % locations of local maxima

%     if abs(feval(dfun,0)) > 5*mapfunpref('eps')
%         pos = [pos ; b];                       % deal with right endpoint (not quite right)
%     end
    maxVal = feval(mf,pos);                     % values of local maxima
    
else

    error('unrecgonised second argument')

end