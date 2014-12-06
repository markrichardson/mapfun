function val = subsref(mapfun,index)
% SUBSREF    defines the subsref operation for mapfun objects

% Mark Richardson, August 2012.

    switch index(1).type
    case '.'         
        if strcmp(index(1).subs,'fun')
            val = mapfun.fun; 

        elseif strcmp(index(1).subs,'ends')
            if length(index) == 2
                x = index(2).subs{1};
                ends = mapfun.ends;
                val = ends(x);
            else
                val = mapfun.ends; 
            end 
            
        elseif strcmp(index(1).subs,'leftval')
             val = mapfun.leftval;   
             
        elseif strcmp(index(1).subs,'map')
             val = mapfun.map;   
            
        elseif strcmp(index(1).subs,'formap')
             val = mapfun.formap;    
             
        elseif strcmp(index(1).subs,'invmap')
             val = mapfun.invmap;        

        elseif strcmp(index(1).subs,'deriv')
             val = mapfun.invmap;   
            
        elseif strcmp(index(1).subs,'L')
             val = mapfun.L;
            
        elseif strcmp(index(1).subs,'scl')
            val = mapfun.scl;
        else
            error('wrong field!')
        end   
        
    case '()'
        x = index.subs{1};
        if isa(x,'mapfun')
            val = compose(mapfun,x);
        elseif isa(x,'double')
            val = feval(mapfun,x);
        else
            error('uncrecognised input argument')
        end
    end
end

