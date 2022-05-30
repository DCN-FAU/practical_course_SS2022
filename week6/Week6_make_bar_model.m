clear all
close all
clc

L   = 0.3;   % [m] length of the rod
Acs = 1e-4;  % [m2] cross sectional area of the rod
k   = 401;   % [W/m/K] thermal conductivity of the rod
rho = 8960;  % [kg/m3] mass density
c   = 385;   % [J/kg/K] heat capacity
T0  = 293;   % [K] reference temperature (not used)
h   = 3;     % [W/K] cooling coefficient at the right boundary

M = 100;    % number of elements
N = M+1;   % number of nodes

Le = L/M;  % length of one element
x = linspace(0,L,N);  % spatial grid with the node positions

Ee = 1/6*[2,1; 1, 2];
Ae = [-1 1; 1 -1];      % Element stiffness matrix

%% Assemble the matrices
E = sparse(N,N);        % Initialize zero matrices
A = sparse(N,N);
B = sparse(N,1);
for e = 1:M
    ind = e:e+1;
    E(ind,ind) = E(ind,ind) + Ee*Le;
    A(ind,ind) = A(ind,ind) + Ae/Le;
    if e < 26
        B(ind) = sum(Ee)*Le;
    end
end
A = Acs*k*A;
A(1,1) = A(1,1) - Acs*h;
A(end,end) = A(end,end) - Acs*h;

B = B / (L/4);

E = Acs*rho*c*E;

% B = zeros(N,1);
% B(1:3) = 1;

Xinit = zeros(N,1);

Xd = sin(2*pi*x/L).';

Q = sparse(N,N);
Q(end,end) = 10;

save('Week11_bar_model', 'x', 'A', 'E', 'B', 'Xinit', 'Q', 'N')