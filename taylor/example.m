% Base variables
syms t y;
f = exp(-t^2) + 4*y;
p = 2;
u0 = 1;
t0 = 0;
h = 0.01;
T = 5;

% ODE Numeric Solve
[ts, ys] = taylorP(f, p, u0, t0, h, T);

% ODE Symbolic Solve
syms x y(t);
ode = diff(y) == exp(-t^2) + 4*y;
cond = y(t0) == u0;
ySol(t) = dsolve(ode,cond);

% Plotting answers
title('ODE Answers')
grid on;

hold on;
plot(ts, ys);

hold on;
fplot(ySol,[t0, T]);

legend('Symbolic', 'Numeric');

% find error, symbolic-numeric
symYs = ySol(t0:h:T);
errorYs = symYs - ys;
error = double(norm(errorYs, inf));
fprintf("Error: %f\n", error);