function ntheta = get_theta(N,A,grid_size)

% Obtains the Deterministic Transition Function for a Square Grid World
% with 5 Actions (1-up, 2-down, 3-right, 4-left, 5-stay).

%% Input

% N - Number of States
% A - Number of Actions
% grid_size - Size of the grid, can be 3, 5 (depending on whether it is a 3x3 or 5x5 grid)
% terminal - Terminal/Goal state

%% Output

% ntheta is of the form T(s,a,s')

%% Code


% if isempty(terminal)==1
%     Goal = [];
% else
%     Goal = sub2ind([grid_size grid_size],terminal(2),terminal(1));
% end

% Self Code Deterministic with Cells
theta = cell(1,A);

% Umar's Code Deterministic Version
THETA = zeros(N*A,N);

% Umar's Code Stochastic Version
Theta = zeros(N*A,N);

% For Csaba's code Deterministic
ntheta = zeros(N,A,N);

% Action Up
theta{1} = zeros(N);
for c=1:N
    T = c-grid_size;
    if T<=0
        T=c;
    end
    theta{1}(c,T) = 1;
    ntheta(c,1,T) = 1;
end

for j=0:N-1
    sd = A*j + 1;
    THETA(sd,:) = theta{1}(j+1,:);
    Theta(sd,:) = theta{1}(j+1,:);
    val = find(THETA(sd,:)==1);
    intmd = setdiff(1:N,val);
    rn = randperm(N-1);
    Theta(sd,val) = 0.7;
    Theta(sd,intmd(rn(1))) = 0.3;
end

% Action Down
theta{2} = zeros(N);
for c=1:N
    T = c+grid_size;
    if T>N
        T=c;
    end
    theta{2}(c,T) = 1;
    ntheta(c,2,T) = 1;
end

for j=0:N-1
    sd = A*j + 2;
    THETA(sd,:) = theta{2}(j+1,:);
    Theta(sd,:) = theta{2}(j+1,:);
    val = find(THETA(sd,:)==1);
    intmd = setdiff(1:N,val);
    rn = randperm(N-1);
    Theta(sd,val) = 0.7;
    Theta(sd,intmd(rn(1))) = 0.3;
end

% Action Right
theta{3} = zeros(N);
for c=1:N
    T = c+1;
    if mod(c,grid_size)==0
        T=c;
    end
    theta{3}(c,T) = 1;
    ntheta(c,3,T) = 1;
end

for j=0:N-1
    sd = A*j + 3;
    THETA(sd,:) = theta{3}(j+1,:);
    Theta(sd,:) = theta{3}(j+1,:);
    val = find(THETA(sd,:)==1);
    intmd = setdiff(1:N,val);
    rn = randperm(N-1);
    Theta(sd,val) = 0.7;
    Theta(sd,intmd(rn(1))) = 0.3;
end

% Action Left
theta{4} = zeros(N);
for c=1:N
    T = c-1;
    if mod(T,grid_size)==0
        T=c;
    end
    theta{4}(c,T) = 1;
    ntheta(c,4,T) = 1;
end

for j=0:N-1
    sd = A*j + 4;
    THETA(sd,:) = theta{4}(j+1,:);
    Theta(sd,:) = theta{4}(j+1,:);
    val = find(THETA(sd,:)==1);
    intmd = setdiff(1:N,val);
    rn = randperm(N-1);
    Theta(sd,val) = 0.7;
    Theta(sd,intmd(rn(1))) = 0.3;
end

% Action Stay in Place
% theta{5} = eye(N);
% for c=1:N
%     ntheta(c,5,c) = 1;
% end
% 
% for j=0:N-1
%     sd = A*j + 5;
%     THETA(sd,:) = theta{5}(j+1,:);
%     Theta(sd,:) = theta{5}(j+1,:);
%     val = find(THETA(sd,:)==1);
%     intmd = setdiff(1:N,val);
%     rn = randperm(N-1);
%     Theta(sd,val) = 0.7;
%     Theta(sd,intmd(rn(1))) = 0.3;
% end

% Transpose of the Transition Matrix
theta{1} = theta{1}';
theta{2} = theta{2}';
theta{3} = theta{3}';
theta{4} = theta{4}';
% theta{5} = theta{5}';

% if isempty(terminal)==0
%     for j=1:A
%         THETA((Goal-1)*A + j,:) = 0;
%         Theta((Goal-1)*A + j,:) = 0;
%         ntheta(Goal,j,:) = 0;
%     end
% end