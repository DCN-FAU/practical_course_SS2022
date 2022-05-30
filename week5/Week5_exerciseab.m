clear all
close all
clc

load('Week5_rod_model')

w = 1e-5;               % weight
u0 = zeros(N,1);        % initial guess 
beta = 100;             % initial step size

%% exercise a

% compute cost functional J0 at the initial guess
T0 = -A\(E*u0);
em = Em*T0 - Tm;
J0 = 0.5*(em.')*em + 0.5*w*u0.'*E*u0;

gA =  TODO;      % gradient w.r.t. weighted inner product
gB =  TODO;  % gradient w.r.t. Eucliden inner product

figure(1)
plot(x, gA)
ylim([-Inf,0])
xlabel 'x [m]'
ylabel '\nabla J'
title 'gradient w.r.t. the weighted inner product'


figure(2)
plot(x, gB)
ylim([-Inf,0])
xlabel 'x [m]'
ylabel '\nabla J'
title 'gradient w.r.t. the Euclidean inner product'

%% exercise b
GA = TODO;   % compute linear coefficients G
GB = TODO;

TnablaA = TODO;   % compute Tnabla
TnablaB = TODO;

HA = TODO;   % compute the quadratic coefficients H
HB = TODO;

betaoptA = TODO;   % find the optimal step size
betaoptB = TODO;

% compute cost function values for several step sizes for comparison
betaA = linspace(0, 2*betaoptA, 20);
betaB = linspace(0, 2*betaoptB, 20);

JtestA = zeros(size(betaA));
for kk = 1:length(betaA)
    u1 = u0 - gA*betaA(kk);
    T0 = -A\(E*u1);
    em = Em*T0 - Tm;
    JtestA(kk) = 0.5*(em.')*em + 0.5*w*u0.'*E*u0;
end

JtestB = zeros(size(betaB));
for kk = 1:length(betaA)
    u1 = u0 - gB*betaB(kk);
    T0 = -A\(E*u1);
    em = Em*T0 - Tm;
    JtestB(kk) = 0.5*(em.')*em + 0.5*w*u0.'*E*u0;
end

% compare quadratic approximation to the true solution
figure(3)
plot(betaA, JtestA, betaA, J0 -GA*betaA + 0.5*HA*betaA.^2)
xlabel 'step size \beta'
ylabel 'J(u_0 + \beta \nabla J(u_0))'
title 'gradient w.r.t. the weighted inner product'

figure(4)
plot(betaB, JtestB, betaB, J0 -GB*betaB + 0.5*HB*betaB.^2)
xlabel 'step size \beta'
ylabel 'J(u_0 + \beta \nabla J(u_0))'
title 'gradient w.r.t. the Euclidean inner product'