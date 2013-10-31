% dbparlogn_cpdf.m - evaluates a Pareto Lognormal Cuimulative Distribution.
%   See "The Double Pareto-Lognormal Distribution - 
%   A New Parametric Model for Size Distributions", W.J Reed & M. Jorgensen,
%   http://citeseer.ist.psu.edu/691544.html
%
%   Created by: J. Huntley, 02/20/08
% 
%   Edited by Ben Lockwood, 03/26/2013
%   Changed to single Pareto log-normal. Limit of equation (23) from the paper as beta
%   goes to infinity.
% 
% Second returned argument is density, to aid solving inverse. 

function [P,D] = plogncdf(X, alpha, nu, tau)

X(X<0) = 0;     % replace negative elements with zeros

arg1 = (log(X)-nu)./tau;
arg2 = (log(X) - nu - alpha.*tau.^2)./tau;
A = exp(alpha.*nu + 0.5*alpha.^2.*tau.^2);
P = normcdf(arg1) - X.^(-alpha).*A.*normcdf(arg2);

P(X==0) = 0;    % when X = 0, P = NaN but should be 0, so replace.

if nargout > 1
    D = alpha.*X.^(-alpha-1).*A.*normcdf(arg2); % equation (20)
    D(X==0) = 0;
end
