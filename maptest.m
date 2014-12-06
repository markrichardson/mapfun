function maptest

% Mark Richardson, August 2012.

userpref = mapfunpref;               % remember current user preferences
mapfunpref('factory');               % reset mapfun preferences to defaults
warnstate = warning;                 % remember current warning settings
warning off                          % turn off warnings for the tests

mapfundir = fileparts(which('maptest.m'));  % get mapfun directory
dirname = fullfile(mapfundir,'mapfuntests');   % get mapfuntest directory

dirlist = dir( fullfile(dirname,'*.m') );  % search in directory for *.m
mfile = {dirlist.name};             % get names of the tests
namelen = 0;                        % get length of the filenames 
for k = 1:numel(mfile)
    namelen = max(namelen,length(mfile{k}));
end

userpath = path;                % remember current user path
addpath(dirname)                % add mapfuntest directory to path

% cycle through all tests for each possible map pairing

maps = {'E','DE'};
% maps = {'E','DE','slit'}; 

for kk = 1:numel(maps)
    
    if any(strcmpi(maps{kk},{'slit'}))
        mapfunpref('map',maps{kk},0.5);       % use a particular map parameter for the tests
    else
        mapfunpref('map',maps{kk});
    end
    
    % printout heading
    fprintf(['\nTesting %i functions with the ' maps{kk} '-map:\n\n'],length(mfile))

    t = zeros(length(mfile),1);     % allocate storage for times
    failed = t;                     % pass/fail markers

    for j = 1:length(mfile)         % loop through files in mapfuntests directory

        fun = mfile{j}(1:end-2);    % get name of test file

        % set up white space for printout
        ws = repmat(' ',1,namelen+1-length(fun)-length(num2str(j)));

        % print function number and name and leave space
        fprintf(['  Test #' num2str(j) ': (' fun ')... ', ws ])
        
        try 
            tic, pass = feval( fun );   % run current test            
            t(j) = toc; 
            failed(j) = ~ all(pass);    % fail if any subtests fail
            if failed(j)
              fprintf('FAILED')         % print failure
            else
              fprintf('passed in %2.3fs ',t(j))   % print success
            end
        catch
            failed(j) = -1;             % print crashed
            fprintf('CRASHED!!! ') 
        end
        fprintf('\n')
    end

    % summary printouts
    if all(~failed)
      fprintf(['\n  All ' maps{kk} ' tests passed!\n\n'])
    else
      fprintf(['\n  %i ' maps{kk} ' tests failed and %i crashed\n\n'],sum(failed>0),sum(failed<0))
    end
    ts = sum(t); tm = ts/60;

    fprintf(['  Total time for the ' maps{kk} '-map tests: \n                 %1.1f seconds = %1.1f minutes \n\n'],ts,tm)

end    
    
warning(warnstate);             % return warnings to previous state
mapfunpref(userpref);           % return to the original preferences
rmpath(dirname);                % remove mapfuntest from path
path(path,userpath);            % keep it if it was there before

end