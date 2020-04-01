clear all; close all; clc

tspan = [0, 2]; x0 = 10; abstol = 1e-6; reltol = 1e-4;
options = odeset('AbsTol', abstol, 'RelTol', reltol);
tic;
[sol_T, sol_X] = ode45(@lin_sys, tspan, x0, options);
ode_time = toc;
tic;
[T, X, e] = rkf45(@lin_sys, tspan, x0, abstol, reltol);
rkf_time = toc;
figure(1); hold on
plot(T, X, 'ro-', 'LineWidth', 1);
plot(sol_T, sol_X, 'bx-', 'LineWidth', 1);
legend('rkf45', 'ode45');
xlabel('Time [sec]');
ylabel('x(t)');

tspan = [0, 20]; x0 = [0; 3]; abstol = 1e-9;
% options = odeset('AbsTol', tol);
tic;
[T2, X2, e2] = rkf45(@nl_pen, tspan, x0, abstol, reltol);
rkf_time = toc;
tic;
[sol_T2, sol_X2] = ode45(@nl_pen, T2, x0, options);
ode_time = toc;

figure(2); hold on
plot(T2, wrapToPi(X2(1, :)), 'ro-', 'LineWidth', 1);
plot(sol_T2, wrapToPi(sol_X2(:, 1)), 'bx-', 'LineWidth', 1);
legend('x_1, rkf45', 'x_1, ode45');
figure(3); hold on
plot(T2, X2(2, :), 'ro--', 'LineWidth', 1);
plot(sol_T2, sol_X2(:, 2), 'bx--', 'LineWidth', 1);
legend('x_2, rkf45', 'x_2, ode45');
xlabel('Time [sec]');
ylabel('x(t)');