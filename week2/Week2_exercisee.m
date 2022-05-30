% Solutions for Exercise 2e in the course
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
Tsim= 3600;     % [s] length of the simulation interval

N = 51;
x = linspace(0,L,N).';      % spatial grid
dx = x(2) - x(1);           % grid spacing (is constant)

% INSERT THE CODE FOR THE SPATIAL DISCRETIZATION FROM B HERE. 

I = speye(size(A));  % define an identity matrix to use below
E = rho*c*I;

%% compute the reference solution
NT = 3073;
t = linspace(0,Tsim,NT);  % time grid
Tref = TODO(t, T0, A, E, f); % choose a scheme to compute the reference solution

% compute the norm of the reference solution (used to compute the reltaive error later)
norm_Tref = max(sqrt(sum(Tref.^2)));  

%% Do the convergence study

e_fe = zeros(1,7); % Errors in the Forward Euler scheme
e_cn = zeros(1,7); % Errors in the Crank-Nicolson scheme
e_be = zeros(1,7); % Errors in the Backward Euler scheme
dt   = zeros(1,7); % time increments for the different values of NT
for ii = 1:7
    NT = 12*2^ii + 1;
    t = linspace(0,Tsim,NT);  % time grid
    
    T = forward_Euler(t, T0, A, E, f);
    e_fe(ii) = TODO;
    
    T = crank_nicolson(t, T0, A, E, f);
    e_cn(ii) = TODO;
    
    T = backward_Euler(t, T0, A, E, f);
    e_be(ii) = TODO;
    
    dt(ii) = Tsim/(NT-1);
end

loglog(dt, e_fe/norm_Tref, dt, e_cn/norm_Tref, dt, e_be/norm_Tref)
ylim([0, 1])
xlabel 'time increment [s]'
ylabel 'relative error [-]'
legend('Forward Euler','Crank-Nicolson','Backward Euler')

function T_FE = forward_Euler(t, T0, A, E, f)
T_FE = zeros(size(A,1), length(t));
dt = t(2) - t(1);
T_FE(:,1) = T0;
for kk = 1:length(t)-1
    T_FE(:,kk+1) = TODO;
end
end

function T_CN = crank_nicolson(t, T0, A, E, f)
T_CN = zeros(size(A,1), length(t));
dt = t(2) - t(1);
T_CN(:,1) = T0;
for kk = 1:length(t)-1
    T_CN(:,kk+1) = TODO;
end
end

function T_BE = backward_Euler(t, T0, A, E, f)
T_BE = zeros(size(A,1), length(t));
dt = t(2) - t(1);
T_BE(:,1) = T0;
for kk = 1:length(t)-1
    T_BE(:,kk+1) = TODO;
end
end