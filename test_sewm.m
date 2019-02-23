% Test sewm against bootstrap
%
%
% NOTE
%   Currently testing against normal distribution
%
% DKS
% 2019-02-23


%% test configs
% distribution and weights ----------------------------------------------
X_mean = 0;         % distribution mean 
X_std = 1;          % dist std

% test repeats ----------------------------------------------------
N_test = 1e1;

% sample -----------------------------------------------------------
n_samp = 1e2;

% bootstrap ---------------------------------------------------------
B = 1e2;        % num of bootstrap samples


%% run test
for ii=1:N_test
    %% ramdomly sample data/weights
    x = normrnd(X_mean,X_std,n_samp,1);         % data
    w = rand(n_samp,1);     % weights - from uniform distribution [0,1]
    
    
    %% SEWM formula
    [x_wmean_se, x_wmean] = sewm(x,w);
    
    
    %% Bootstrap
    % create bootstrap samples
    
    % evaluate w-mean for each sample
    
    % evaluate empirical stddev from bootstrap samples
    
end


%% compare methods


%% vis