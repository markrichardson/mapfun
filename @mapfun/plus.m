function mfOut = plus(mf1,mf2)
% PLUS   addition operator for mapfun objects

if isa(mf1,'double') || isa(mf2,'double') 
    
    if isa(mf2,'double')                 % arrange to make ff the double
        temp = mf1;
        mf1 = mf2; 
        mf2 = temp;
    end
    
    mfOut = mf2;
    mfOut.fun = mf1 + mf2.fun;
    mfOut.leftval = mf1 + mf2.leftval;
    mfOut.scl = mf1 + mf2.scl;
    
else
    
    mfOut = comp(mf1,@(a,b) plus(a,b),mf2);
    
end
    
% else
%     
%     if sum(ff.ends == gg.ends) ~= 2
%         error('PLUS requires mapfuns to be defined on the same interval')
%     end
%     mfOut = mapfun(@(x) feval(ff,x) + feval(gg,x),ff.ends,'L',min(ff.L,gg.L));
% 
% end