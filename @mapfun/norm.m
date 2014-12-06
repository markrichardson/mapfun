function [norm, normLoc] = norm(ff,n)
% NORM   mapfun norm. At the moment we are assuming that the mapfuns are 
%        real functions (of a real variable).
%
%    NORM(ff) = sqrt(integral of abs(ff)^2).
%    NORM(ff,2) is the same as NORM(ff).
%    NORM(ff,'fro') is also the same as NORM(ff).
%    NORM(ff,1) NOT YET IMPLEMENTED: SPLITTING FUNCTIONALITY REQUIRED
%    NORM(ff,inf) = max(abs(ff)).
%    NORM(ff,-inf) = NOT YET IMPLEMENTED: SPLITTING FUNCTIONALITY REQUIRED
%    NORM(ff,p) NOT YET IMPLEMENTED: SPLITTING FUNCTIONALITY REQUIRED

% Mark Richardson, August 2012.

if nargin == 1
    n = 2;
end

if strcmp(n,'fro')
    n = 2;
end

normLoc = [];

if isempty(ff)
    norm = 0;
else
    switch n
        case 1
            error('mapfun 1 norm not yet defined -- requires splitting!')
        case 2
            norm = sqrt(sum(ff.^2));
        case {inf,'inf'}
            [norm normLoc] = minandmax(ff);
            [norm idx] = max([-norm(1), norm(2)]);
            normLoc = normLoc(idx);
        case {-inf,'-inf'}
            error('mapfun -inf norm not yet defined -- requires splitting!')
        otherwise
             if isnumeric(n) && isreal(n)
                if nargout == 2
                    error('cannot return two outputs for p-norms');
                end
                error('mapfun p norm not yet defined -- requires splitting!')
%                 norm = sum(abs(ff).^n)^(1/n);
            else
                error('Unknown norm');
            end
    end
end