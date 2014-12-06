function mfOut = comp(mf1, op, mf2 )
% MFOUT  Composition of mapfun object with a function handle.
% 
% COMP(MF1,OP) returns the composition of the mapfun 
%       MF1 with OP, i.e., FOUT = OP(MF1).
%
% COMP(MF1,OP,MF2) returns the composition of OP with 
%       mapfuns F1 and F2, i.e., FOUT = OP(F1,F2).

% Mark Richardson, August 2012

if nargin == 2
        mfOut = mapfun(@(x) op(feval(mf1,x)),mf1.ends,mf1.map,mf1.param,'L',mf1.L);

elseif nargin == 3
    if isa(mf1,'mapfun') && isa(mf2,'mapfun')  
         % mf1 and mf2 both mapfuns
        if mf1.ends(1) ~= mf2.ends(1) || mf1.ends(2) ~= mf2.ends(2)
            error('mapfuns are required to be defined on the same interval')
        end
        [L,idx] = min([mf1.L,mf2.L]);  % THERE WILL BE A PROBLEM HERE IF WE COMP USING MAPFUN CONSTRUCTED WITH DIFFERENT MAPS
        maps = {mf1.map,mf2.map};
        params = {mf1.param,mf2.param};
        mfOut = mapfun(@(x) op(feval(mf1,x),feval(mf2,x)),mf1.ends,maps(idx),params(idx),'L',L);
         
    elseif isa(mf1,'mapfun')   
        % mf1 mapfun, mf2 double
        mfOut = mapfun(@(x) op(feval(mf1,x),mf2),mf1.ends,mf1.map,mf1.param,'L',mf1.L);
    
    else   
        % mf1 double, mf2 mapfun
        mfOut = mapfun(@(x) op(mf1,feval(mf2,x)),mf2.ends,mf2.map,mf2.param,'L',mf2.L); 
    
    end   
end
 



% OLD VERSION BELOW (EXACTLY THE SAME, JUST MORE CONDITIONS)

% function mfOut = comp(mf1, op, mf2 )
% % MFOUT  Composition of mapfun object with a function handle.
% % 
% % COMP(MF1,OP) returns the composition of the mapfun 
% %       MF1 with OP, i.e., FOUT = OP(MF1).
% %
% % COMP(MF1,OP,MF2) returns the composition of OP with 
% %       mapfuns F1 and F2, i.e., FOUT = OP(F1,F2).
% 
% % Mark Richardson, August 2012
% 
% if nargin == 2
%     if any(strcmpi(mf1.map,{'slit'}))
%         mfOut = mapfun(@(x) op(feval(mf1,x)),mf1.ends,mf1.map,mf1.param,'L',mf1.L);
%     else
%         mfOut = mapfun(@(x) op(feval(mf1,x)),mf1.ends,mf1.map,'L',mf1.L);
%     end
%     
% elseif nargin == 3
%     if isa(mf1,'mapfun') && isa(mf2,'mapfun')  
%          % mf1 and mf2 both mapfuns
%         if mf1.ends(1) ~= mf2.ends(1) || mf1.ends(2) ~= mf2.ends(2)
%             error('mapfuns are required to be defined on the same interval')
%         end
%         [L,idx] = min([mf1.L,mf2.L]);  % THERE WILL BE A PROBLEM HERE IF WE COMP USING MAPFUN CONSTRUCTED WITH DIFFERENT MAPS
%         maps = {mf1.map,mf2.map};
%         params = [mf1.param,mf2.param];
%         if any(strcmpi({mf1.map,mf2.map},{'slit'}))
%             mfOut = mapfun(@(x) op(feval(mf1,x),feval(mf2,x)),mf1.ends,maps(idx),params(idx),'L',L);
%         else
%             mfOut = mapfun(@(x) op(feval(mf1,x),feval(mf2,x)),mf1.ends,maps(idx),'L',L);
%         end
%          
%     elseif isa(mf1,'mapfun')   
%         % mf1 mapfun, mf2 double
%         if any(strcmpi(mf1.map,{'slit'}))
%             mfOut = mapfun(@(x) op(feval(mf1,x),mf2),mf1.ends,mf1.map,mf1.param,'L',mf1.L);
%         else
%             mfOut = mapfun(@(x) op(feval(mf1,x),mf2),mf1.ends,mf1.map,'L',mf1.L);
%         end
%         
%     else   
%         % mf1 double, mf2 mapfun
%         if any(strcmpi(mf2.map,{'slit'}))
%             mfOut = mapfun(@(x) op(mf1,feval(mf2,x)),mf2.ends,mf2.map,mf2.param,'L',mf2.L); 
%         else
%             mfOut = mapfun(@(x) op(mf1,feval(mf2,x)),mf2.ends,mf2.map,'L',mf2.L); 
%         end
%     end 
% end