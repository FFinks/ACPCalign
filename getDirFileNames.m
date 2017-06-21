function fn = getDirFileNames(includePath, directory, varargin)
% fileNames = getDirFileNames(includePath, directory,selectors)
% Takes a directory path and returns a cell array of fileNames. if includePath == true 
% then returns filenames with path. If includePath == false then returns only file name. Optionally
% takes selectors as a cell array of regex strings but then will only use first varargin. 
% Multiple selectors are joined according to AND logic.
% example selectors:
%   'bhv' : return files with 'bhv' file name
%   '!doc' : do not return files with 'doc' in the file name 

if nargin < 2
    disp('ERROR: getDirFileNames requires at least two arguments');
    return
end
if (includePath)
    targetPath = directory;
    if (targetPath(end) ~= '/')
        targetPath = [targetPath '/'];
    end
else
    targetPath = [];
end

wd = cd;
cd(directory);

l = dir;
fn = {l.name}';  % a cell array of filenames, which will will include '.' and '..', 
                 % which we eliminate manually along with any hidden directories that start with '.'
elimInd = strncmp('.',fn,1);
fn(elimInd) = [];

if nargin > 2
    if (iscell(varargin{1}))
        varargin = varargin{1};
        if (nargin > 3)
            fprintf('Ignoring additional selectors in getDirFileNames\n');
        end
    end
    filesInd = ones(1,length(fn));  % default is to keep all filenames
    negSelectorInd = strmatch('!',varargin);
    for nI = reshape(negSelectorInd,1,[])
        varargin{nI} = varargin{nI}(2:end);
    end
    for selectorI = 1:length(varargin)
        for fnI = 1:length(fn)
            strFound = ~isempty(regexp(fn{fnI},varargin{selectorI}));
            if (ismember(selectorI,negSelectorInd) & strFound)  % eliminate files with negative selector
                filesInd(fnI) = 0;
            end
            if (~ismember(selectorI,negSelectorInd) & ~strFound)  % eliminate files without positive selector
                filesInd(fnI) = 0;
            end
        end
    end
    
    fn = fn(logical(filesInd));  % keep only those selected above
end

% add path to filename if requested
for i = 1:length(fn)
    fn{i} = [targetPath fn{i}];
end