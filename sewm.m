function [SEMw, Mw] = sewm(x,w,dimension)
% Standard error of a weighted mean
%
% I N P U T
%   x:  N-length vector of random variables
%   w:  N-length vector of weights for arithmetic mean
%
% O U T P U T
%   SEMw:   standard error of the weighted mean
%   Mw:     weighted mean
%
% NOTE
%   Formula from W. G. Cochran (1977) Sampling Techniques (3rd Edn). Wiley,
%   New York.
%   For further information, see:
%       Gatz and Smith (1995) The standard error of a weighted mean
%       concentration--I. Boostrapping vs other methods.
%       [stackexchange
%       forum](https://stats.stackexchange.com/questions/25895/computing-standard-error-in-weighted-mean-estimation)
%
% DKS
% 2019-02-23

if nargin<3
    dimension = 1;
end

n = length(x);      % number of samples
w_sum = nansum(w,dimension);     
w_sqrd = w.^2;      
Mw = nansum(w.*x,dimension)./w_sum;     
% w_mean = mean(w);   % mean of weights

% % formula as in Gatz and Smith
% SEMw = sqrt( n/((n-1)*w_sum^2) * ( sum( (w.*x - w_mean*Mw).^2 )   ...
%     - 2*Mw*sum( (w - w_mean).*(w.*x - w_mean*Mw) ) ...
%     + Mw^2 * sum( (w - w_mean).^2 ) ) );

% formula in a computationally friendly form [stackexchange forum]
SEMw = sqrt( n./((n-1).*w_sum.^2) .* ( nansum( (w_sqrd.*x.^2), dimension ) ...
                            - 2.*Mw.*nansum( w_sqrd.*x, dimension ) ...
                            + Mw.^2.*nansum( w_sqrd, dimension ) ) );

end