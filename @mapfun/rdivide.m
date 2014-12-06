function mfOut = rdivide(mf1,mf2)
% RDIVIDE   ./ division operator for mapfun objects

if isa(mf1,'double') 
    if isempty(roots(mf2))
%         mfOut = mapfun(@(x) mf1./feval(mf2,x),mf2.ends,'L',mf2.L);
        mfOut = comp(mf1,@(a,b) rdivide(a,b),mf2);
    else
        error('divisor has roots on its interval of definition') 
    end
    
elseif isa(mf2,'double')
    mfOut = mf1*(1/mf2);

else
    if sum(mf1.ends == mf2.ends) ~= 2
        error('RDIVIDE requires mapfuns to be defined on the same interval')
    end
    
    if isempty(roots(mf2))    
%         mfOut = mapfun(@(x) feval(mf1,x)./feval(mf2,x),mf1.ends,'L',min(mf1.L,mf2.L));
          mfOut = comp(mf1,@(a,b) rdivide(a,b),mf2);
    else    
        error('divisor has roots on its interval of definition') 
    end
    
end