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
X_std = 10;          % dist std

% test repeats ----------------------------------------------------
N_test = 1e2;

% sample -----------------------------------------------------------
n_samp = 1e2;

% bootstrap ---------------------------------------------------------
B = 1e2;        % num of bootstrap samples


%% run test
SEWM_formula=NaN(N_test,1);
SEWM_bs=NaN(N_test,1);

for ii=1:N_test
    %% ramdomly sample data/weights
    x = normrnd(X_mean,X_std,[n_samp,1]);         % data
    w = rand(n_samp,1);     % weights - from uniform distribution [0,1]
    
    
    %% SEWM formula
    [x_wmean_se, x_wmean] = sewm(x,w);
    
    
    %% Bootstrap
    % create bootstrap samples
    bs_Isamp=cellfun(@(c) randi(n_samp,[n_samp,1]), cell(B,1),...
            'UniformOutput',false);
    bs_x = cellfun(@(I) x(I), bs_Isamp, 'uni', 0);
        
    % evaluate w-mean for each sample
    [~,bs_wmean] = cellfun(@(X) sewm(X,w), bs_x);
    
    % evaluate empirical stddev from bootstrap samples
    bs_wmean_se = std(bs_wmean);
    bs_wmean = mean(bs_wmean);
    
    
    %% store
    SEWM_formula(ii) = x_wmean_se;
    SEWM_bs(ii) = bs_wmean_se;
end


%% compare methods
H_test = figure;
hold on;

p_test = plot(SEWM_bs,SEWM_formula,'o');

ax=gca;
ax.XLim=ax.YLim;    % identical axis limits

% annotation
tp = plot(ax.XLim, ax.YLim,'k-');
uistack(tp,'bottom');

xlabel('bootstrapped SEM_w');
ylabel('formula SEM_w');

title();