clear all; close all; clc

%Calculate and plot analytical solution for pendulum
tspan = [0, 100]; x0 = [pi-0.01; 0]; omega_0 = 1;
T = [tspan(1): 0.1: tspan(2)];
theta = zeros(length(T), 1);
omega = zeros(length(T), 1);
for i = 1: length(T)
    m = sin(x0(1)/2)^2;
    u = ellipticK(m) - omega_0*T(i);
    theta(i) = 2*asin(sin(x0(1)/2)*jacobiSN(u, m));
end

%Plot responses using rkf45 and ode45
tol = 1e-8; options = odeset('AbsTol', tol);
tic;
[T2, X2, e2] = rkf45(@(t, x) nl_pen(t, x, omega_0), tspan, x0, tol);
rkf_time = toc;
tic;
[sol_T2, sol_X2] = ode45(@(t, x) nl_pen(t, x, omega_0), T2, x0, options);
ode_time = toc;

figure(1); hold on
plot(T2, wrapToPi(X2(1, :)), 'ro-', 'LineWidth', 1);
plot(sol_T2, wrapToPi(sol_X2(:, 1)), 'bx-', 'LineWidth', 1);
plot(T, theta, 'k.-', 'LineWidth', 1);
legend('\theta, rkf45', '\theta, ode45', '\theta, analytical');
figure(2); hold on
plot(T2, X2(2, :), 'ro--', 'LineWidth', 1);
plot(sol_T2, sol_X2(:, 2), 'bx--', 'LineWidth', 1);
legend('d\thetadt, rkf45', 'd\thetadt, ode45');
xlabel('Time [sec]');
ylabel('x(t)');