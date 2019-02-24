% Standard error of weighted mean when variable's estimator and standard
% error are known for each weight by multiple samples
%
%
% DKS
% 2019-02-24

%% configs
n_vars = 1e2;        % number of random vars to take weighted mean
n_samp = 1e4 * ones(n_vars,1);   % number of samples taken for each rand var
% n_samp = round(1e2 * rand(n_vars,1));     % variable sample size per var


%% Initialisation
% distribution params -----------------------------------------
F_mean = 1e2*rand(n_vars,1);        % mean of each normal distribution F
F_sig = rand(n_vars,1);         % std of F

% weights -----------------------------------------------------
% weights per var
wF = rand(n_vars,1);       

% weights per observed sample
wx = arrayfun(@(w,n) w*ones(n,1), wF, n_samp, 'uni', 0);
wx = vertcat(wx{:});


%% main
% Simulated experimental data --------------------------------------
% observed samples for each var/distribution
x_obs = arrayfun(@(mu,sig,n) normrnd(mu,sig,[n,1]),F_mean,F_sig,n_samp,'uni',0);

% mean and standard error
x_obs_mu = cellfun(@(x) mean(x), x_obs);
x_obs_std = cellfun(@(x) std(x), x_obs);
x_obs_se = cellfun(@(x) std(x)/sqrt(length(x)), x_obs);


% SEWM by individual samples --------------------------------------
x = vertcat(x_obs{:});

[sewm_x, Mw_x] = sewm(x,wx)

% my formula for SEWM from mean and SE estimates -------------------------
[sewm_xF, Mw_xF] = myformula_sewmdist(x_obs_mu,x_obs_se,wF)

[sewm_xF2, Mw_xF2] = myformula_sewmdist(x_obs_mu,x_obs_std,wF)

[sewm_xF3, Mw_xF3] = sewm(x_obs_mu,wF)


%% functions
function [se_Mw, Mw] = myformula_sewmdist(x,sigx,w)
% my formula for standard error of weighted mean given SE of each value

w_sum = sum(w);
Mw = sum(x.*w)/w_sum;       % weighted mean

se_Mw = sqrt(sum((sigx.*w).^2))/w_sum;    % standard error of weighted mean

end