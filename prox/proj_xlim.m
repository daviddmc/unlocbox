function [sol,info] = proj_xlim(x, ~, param)
%PROJ_XLIM Proximal operator with L1 norm
%   Usage:  sol=proj_xlim(x, gamma)
%           sol=proj_xlim(x)
%           sol=proj_xlim(x, gamma, param)
%           [sol, info]=proj_xlim(x, gamma, param)
%
%   Input parameters:
%         x     : Input signal.
%         param : Structure of optional parameters.
%   Output parameters:
%         sol   : Solution.
%         info  : Structure summarizing informations at convergence
%
%   `prox_xlim(x, gamma, param)` solves:
%
%   .. sol = argmin_{z} 0.5*||x - z||_2^2 s.t x < xmax and x > xmin 
%
%   .. math::  sol = \min_{z} \frac{1}{2} \|x - z\|_2^2 \text{ subject to } x < x_{max} \text{ and } x > x_{min}
%
%   param is a Matlab structure containing the following fields:
%
%   * *param.xsup* : maximum value of x (default 1)
%
%   * *param.xinf* : minimum value of x (default 0).
%
%   * *param.verbose* : 0 no log, 1 a summary at convergence, 2 print main
%     steps (default: 1)
%
%
%   info is a Matlab structure containing the following fields:
%
%   * *info.algo* : Algorithm used
%
%   * *info.iter* : Number of iteration
%
%   * *info.time* : Time of exectution of the function in sec.
%
%   * *info.final_eval* : Final evaluation of the function
%
%   * *info.crit* : Stopping critterion used 
%
%
%   Rem: The input "~" is useless but needed for compatibility issue.
%
%   See also:  proj_b2



% Author: Nathanael Perraudin
% Date: Dec 2013
%

% Start the time counter
t1 = tic;

% Optional input arguments
if nargin<3, param=struct; end

% Optional input arguments
if ~isfield(param, 'verbose'), param.verbose = 1; end
if ~isfield(param, 'xsup'), param.xsup = 1; end
if ~isfield(param, 'xinf'), param.xinf = 0; end




% Projection

x(x>param.xsup) = param.xsup;
x(x<param.xinf) = param.xinf;
sol = x;

norm_l2 = 0.5 * norm(x(:)-sol(:));


% Log after the projection
if param.verbose >= 1
    fprintf('  proj_xlim 0.5*|| x - z ||_2 = %e \n',norm_l2);
end


info.algo=mfilename;
info.iter=0;
info.final_eval=norm_l2;
info.crit='TOL_EPS';
info.time=toc(t1);
end


