function dxdt = nl_pen(t, x, omega_0)
    dxdt = zeros(2, 1);
    dxdt(1) = x(2);
    dxdt(2) = -omega_0^2*sin(x(1));
end