function mfOut = power(mf1,mf2)
% .^   mapfun power
%
% F.^G returns a mapfun F to the scalar power G, a scalar F to the
% mapfun power G, or a mapfun F to the mapfun power G.

% Mark Richardson, August 2012.

 mfOut = comp(mf1,@(a,b) power(a,b),mf2);
 
 

 % if isa(mf1,'mapfun') && isa(mf2,'mapfun')           % mapfun.^mapfun
% 
%     if mf1.ends(1) ~= mf2.ends(1) || mf1.ends(2) ~= mf2.ends(2)
%         error('mapfuns need to be defined on the same interval')
%     end
% 
%     L = min(mf1.L,mf2.L);                           % use the largest L    
%     mfOut = mapfun(@(x) feval(mf1,x).^feval(mf2,x),mf1.ends,'L',L);
%     
% elseif isa(mf1,'mapfun')                            % mapfun.^double
% 
%      mfOut = mapfun(@(x) feval(mf1,x).^mf2,mf1.ends,'L',mf1.L);
%      
% else                                                % double.^mapfun
%     
%     mfOut = mapfun(@(x) mf1.^feval(mf2,x),mf2.ends,'L',mf2.L);
% 
% end


