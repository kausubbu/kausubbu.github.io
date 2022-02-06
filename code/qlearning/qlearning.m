%% Basic Q-learning with non-decaying Epsilon Exploration Parameter
%
clear
close all

addpath plotting % Used to Plot the Policy

%% Setup the Problem

% Grid Domain (numbers represent the state)
% |1|2|3|
% |4|5|6|
% |7|8|9|

% Problem Parameters

N = 9;              % Number of States
grid_size = 3;      % Square Grid Size (nxn)
A = 4;              % Number of Actions (1. Up, 2. Down, 3. Right, 4. Left)
gamma = 0.9;        % Discount
episodes = 60;      % Number of Episodes
eps_limit = 50;     % Limit for the number of steps in an episode
terminal = 9;       % Goal or Terminal State

% Algorithm Parameters

alpha = 0.1;       % Learning Rate
ep = 0.8;           % Exploration Parameter
Q = zeros(N,A);     % Initialize Q Values as zero

% Transition Function (only used to get the next state). Note in actuality
% this is not used/required for Q-learning.
theta = get_theta(N,A,grid_size);

% Reward Function
rew = zeros(1,N); rew(terminal) = 1;

%% Perform Learning

for i=1:episodes
    
    % A new starting state for every episode
    tmp1 = randperm(N);
    next_state = tmp1(1);
    
    % Keeping track
    count = 0;          % Steps in an Episode
    reward_sum = [];    % Reward acquired in an Episode    
        
    while(1)
        
        % Current State
        current_state = next_state;
        
        % Action Selection
        if rand>ep
            % Epsilon Exploration
            tmp = randperm(A);      % Select Randomly
            act = tmp(1);
        else
            % Exploitation
            [dum act] = max(Q(current_state,:));    % Select Greedily
        end
        
        % Acquire next state
        next_state = find(theta(current_state,act,:) == 1);
        
        % Q-learning
        tderror = rew(current_state) + gamma*max(Q(next_state,:)) - Q(current_state,act);
        Q(current_state,act) = Q(current_state,act) + alpha*(tderror);
        
        % Tracking the reward received
        reward_sum = [reward_sum rew(current_state)];
        
        % To keep track of steps to the terminal state
        count = count + 1;
        
        % Break Condition for an Episode
        if current_state == terminal || count==eps_limit
            break;
        end
        
    end
    
    % Storing the Results
    rew_per_ep(i) = sum(reward_sum);                        % Reward per episode
    avg_rew_per_ep(i) = rew_per_ep(i)/length(reward_sum);   % Average reward per episode
    
end

%% Obtain the Policy

% Probabilistic Policy
for i=1:N
    policy_pi(i,:) = Q(i,:)./max(Q(i,:));
end

%% Plotting

% Actions
for i=1:N
    [val opt_act(i)] = max(policy_pi(i,:));
end
pi_act = reshape(opt_act,grid_size,grid_size)';
title('Policy'); plot_policy(pi_act,grid_size)

figure;
% Reward per episode
subplot(2,1,1); plot(1:episodes,rew_per_ep);
title('Reward per Episode');

% Average Reward per episode
subplot(2,1,2); plot(1:episodes,avg_rew_per_ep);
title('Average reward per Episode');