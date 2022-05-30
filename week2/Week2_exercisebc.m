% Solutions for Exercise 2bc in the course
% Modeling, Simulation, Optimization (practical course)
% at Friedrich-Alexander Universität Erlangen-Nürnberg
% Daniel Veldman (2020)
% Chair in Dynamics, Control, and Numerics, Department of Data Science

clear all   % clear all variables that existed before
close all   % close all figures
clc         % clear the command window

L   = 0.3;   % [m] length of the rod
Acs = 0.01;  % [m2] cross sectional area of the rod
k   = 57.7;   % [W/m/K] thermal conductivity of the rod
c   = 448;   % [J/kg/K] heat capacity of the rod
rho = 7840;  % [kg/m3] mass density of the rod
T0  = 293;   % [K] reference temperature (not used)
h   = 3;     % [W/K] cooling coefficient at the right boundary
Q0  = 100;   % [W/m] intensity of the applied heat load 
a   = 0.1;   % [m] width parameter for the applied heat load
Q   =@(x) Q0*exp(-(x-L/2).^2/a^2); % [W/m] applied heat load
Tsim= 60;     % [s] length of the simulation interval

N = 51;
x = linspace(0,L,N).';      % spatial grid
dx = x(2) - x(1);           % grid spacing (is constant)

NT  = 100;                  % number of time steps
t = linspace(0,Tsim,NT+1);  % time grid
dt = t(2) - t(1);           % time step

f =  TODO;                  % load vector

T0 = TODO;                  % initial condition

% make a figure of the applied heat load (just for understanding)
fig = figure(1);
plot(x, f)
xlabel 'x [m]'
ylabel 'Q(x) [W/m]'

% make a figure of the initial condition (just for understanding)
fig = figure(2);
plot(x, T0)
xlabel 'x [m]'
ylabel 'U(0,x) [K]'

%% Spatial discretization
% Explicit implementation of the BC, start with an N-1 by N-1 matrix
A = sparse(N-1, N-1);
for ii = 2:N-2
    % TODO internal nodes
end
% TODO BC


%% Compute the steady state temperature field
Tss = TODO; 
figure(3)
plot(x, [0; Tss])
xlabel 'x [m]'
ylabel 'steady state temperature increase [K]'

%% Temporal discretization

% Forward Euler
T_FE = zeros(size(A,1), NT+1); % each column of T_FE represents the solution at a certain time instant. 
T_FE(:,1) = T0;
for kk = 1:NT
    T_FE(:,kk+1) = TODO
    figure(4)
    plot(x,[0; T_FE(:,kk+1)], x, [0; Tss])
    ylim([0,2.5])
    xlabel 'x [m]'
    ylabel 'temperature increase [K]'
    title(['Explicit Euler: t = ', num2str(t(kk+1)), ' s'])
    pause(0.1);
end

% Crank-Nicholson
T_CN = zeros(size(A,1), NT+1);
T_CN(:,1) = T0;
for kk = 1:NT
    T_CN(:,kk+1) = TODO
    figure(4)
    plot(x,[0; T_CN(:,kk)], x, [0; Tss])
    ylim([0,2.5])
    xlabel 'x [m]'
    ylabel 'temperature increase [K]'
    title(['Crank-Nicholson: t = ', num2str(t(kk+1)), ' s'])
    pause(0.1);
end

% Backward Euler
T_BE = zeros(size(A,1), NT+1);
T_BE(:,1) = T0;
for kk = 1:NT
    T_BE(:,kk+1) = TODO
    figure(4)
    plot(x,[0; T_BE(:,kk)], x, [0; Tss])
    ylim([0,2.5]);
    xlabel 'x [m]'
    ylabel 'temperature increase [K]'
    title(['Implicit Euler: t = ', num2str(t(kk+1)), ' s'])
    pause(0.1);
end