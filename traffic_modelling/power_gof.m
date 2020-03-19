function [gof]=power_gof(x, xmin, varargin)
% PLPVA calculates the p-value for the given power-law fit to some data.
%    Source: http://www.santafe.edu/~aaronc/powerlaws/
% 
%    PLPVA(x, xmin) takes data x and given lower cutoff for the power-law
%    behavior xmin and computes the corresponding p-value for the
%    Kolmogorov-Smirnov test, according to the method described in 
%    Clauset, Shalizi, Newman (2007).
%    PLPVA automatically detects whether x is composed of real or integer
%    values, and applies the appropriate method. For discrete data, if
%    min(x) > 1000, PLPVA uses the continuous approximation, which is 
%    a reliable in this regime.
%   
%    The fitting procedure works as follows:
%    1) For each possible choice of x_min, we estimate alpha via the 
%       method of maximum likelihood, and calculate the Kolmogorov-Smirnov
%       goodness-of-fit statistic D.
%    2) We then select as our estimate of x_min, the value that gives the
%       minimum value D over all values of x_min.
%
%    Note that this procedure gives no estimate of the uncertainty of the 
%    fitted parameters.
%
%    Example:
%       x = (1-rand(10000,1)).^(-1/(2.5-1));
%       [p, gof] = plpva(x, 1);
%
%    For more information, try 'type plpva'
%
%    See also PLFIT, PLVAR

% Version 1.0   (2007 May)
% Version 1.0.2 (2007 September)
% Version 1.0.3 (2007 September)
% Version 1.0.4 (2008 January)
% Version 1.0.5 (2008 March)
% Version 1.0.6 (2008 April)
% Version 1.0.7 (2009 October)
% Version 1.0.8 (2012 January)
% Copyright (C) 2008-2012 Aaron Clauset (Santa Fe Institute)
% Distributed under GPL 2.0
% http://www.gnu.org/copyleft/gpl.html
% PLPVA comes with ABSOLUTELY NO WARRANTY
% 
% Notes:
% 
% 1. In order to implement the integer-based methods in Matlab, the numeric
%    maximization of the log-likelihood function was used. This requires
%    that we specify the range of scaling parameters considered. We set
%    this range to be [1.50 : 0.01 : 3.50] by default. This vector can be
%    set by the user like so,
%    
%       p = plpva(x, 1,'range',[1.001:0.001:5.001]);
%    
% 2. PLPVA can be told to limit the range of values considered as estimates
%    for xmin in two ways. First, it can be instructed to sample these
%    possible values like so,
%    
%       a = plpva(x,1,'sample',100);
%    
%    which uses 100 uniformly distributed values on the sorted list of
%    unique values in the data set. Second, it can simply omit all
%    candidates above a hard limit, like so
%    
%       a = plpva(x,1,'limit',3.4);
%    
%    Finally, it can be forced to use a fixed value, like so
%    
%       a = plpva(x,1,'xmin',1);
%    
%    In the case of discrete data, it rounds the limit to the nearest
%    integer.
% 
% 3. The default number of semiparametric repetitions of the fitting
% procedure is 1000. This number can be changed like so
%    
%       p = plpva(x, 1,'reps',10000);
% 
% 4. To silence the textual output to the screen, do this
%    
%       p = plpva(x, 1,'reps',10000,'silent');
% 

vec    = [];
sample = [];
limit  = [];
xminx  = [];
Bt     = [];
quiet  = false;
persistent rand_state;

% parse command-line parameters; trap for bad input
i=1; 
while i<=length(varargin), 
  argok = 1; 
  if ischar(varargin{i}), 
    switch varargin{i},
        case 'range',        vec    = varargin{i+1}; i = i + 1;
        case 'sample',       sample = varargin{i+1}; i = i + 1;
        case 'limit',        limit  = varargin{i+1}; i = i + 1;
        case 'xmin',         xminx  = varargin{i+1}; i = i + 1;
        case 'reps',         Bt     = varargin{i+1}; i = i + 1;
        case 'silent',       quiet  = true;
        otherwise, argok=0; 
    end
  end
  if ~argok, 
    disp(['(PLPVA) Ignoring invalid argument #' num2str(i+1)]); 
  end
  i = i+1; 
end
if ~isempty(vec) && (~isvector(vec) || min(vec)<=1),
	fprintf('(PLPVA) Error: ''range'' argument must contain a vector; using default.\n');
    vec = [];
end;
if ~isempty(sample) && (~isscalar(sample) || sample<2),
	fprintf('(PLPVA) Error: ''sample'' argument must be a positive integer > 1; using default.\n');
    sample = [];
end;
if ~isempty(limit) && (~isscalar(limit) || limit<1),
	fprintf('(PLPVA) Error: ''limit'' argument must be a positive value >= 1; using default.\n');
    limit = [];
end;
if ~isempty(Bt) && (~isscalar(Bt) || Bt<2),
	fprintf('(PLPVA) Error: ''reps'' argument must be a positive value > 1; using default.\n');
    Bt = [];
end;
if ~isempty(xminx) && (~isscalar(xminx) || xminx>=max(x)),
	fprintf('(PLPVA) Error: ''xmin'' argument must be a positive value < max(x); using default behavior.\n');
    xminx = [];
end;

% reshape input vector
x = reshape(x,numel(x),1);

% select method (discrete or continuous) for fitting
if     isempty(setdiff(x,floor(x))), f_dattype = 'INTS';
elseif isreal(x),    f_dattype = 'REAL';
else                 f_dattype = 'UNKN';
end;
if strcmp(f_dattype,'INTS') && min(x) > 1000 && length(x)>100,
    f_dattype = 'REAL';
end;
N = length(x);
x = reshape(x,N,1); % guarantee x is a column vector
if isempty(rand_state)
    rand_state = cputime;
    rand('twister',sum(100*clock));
end;
if isempty(Bt), Bt = 1000; end;
nof = zeros(Bt,1);

if ~quiet,
    fprintf('Power-law Distribution, p-value calculation\n');
    fprintf('   Copyright 2007-2010 Aaron Clauset\n');
    fprintf('   Warning: This can be a slow calculation; please be patient.\n');
    fprintf('   n    = %i\n   xmin = %6.4f\n   reps = %i\n',length(x),xmin,length(nof));
end;
tic;
% estimate xmin and alpha, accordingly
switch f_dattype,
    
    case 'REAL',
        
        % compute D for the empirical distribution
        z     = x(x>=xmin);	nz   = length(z);
        y     = x(x<xmin); 	ny   = length(y);
        alpha = 1 + nz ./ sum( log(z./xmin) );
        cz    = (0:nz-1)'./nz;
        cf    = 1-(xmin./sort(z)).^(alpha-1);
        gof   = max( abs(cz - cf) );


    case 'INTS',

        if isempty(vec),
            vec  = (1.50:0.01:3.50);    % covers range of most practical 
        end;                            % scaling parameters
        zvec = zeta(vec);

        % compute D for the empirical distribution
        z     = x(x>=xmin);	nz   = length(z);	xmax = max(z);
        y     = x(x<xmin); 	ny   = length(y);

        L  = -Inf*ones(size(vec));
        for k=1:length(vec)
            L(k) = -vec(k)*sum(log(z)) - nz*log(zvec(k) - sum((1:xmin-1).^-vec(k)));
        end
        [Y,I] = max(L);
        alpha = vec(I);

        fit = cumsum((((xmin:xmax).^-alpha))./ (zvec(I) - sum((1:xmin-1).^-alpha)));
        cdi = cumsum(hist(z,(xmin:xmax))./nz);
        gof = max(abs( fit - cdi ));

    otherwise,
        fprintf('(PLPVA) Error: x must contain only reals or only integers.\n');
        p   = [];
        gof = [];
        return;
end;
