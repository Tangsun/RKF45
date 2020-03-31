function dxdt = nl_sys(t, x)
    dxdt = zeros(2, 1);
    dxdt(1) = sin(5*x(2));
    dxdt(2) = cos(5*x(1));
end