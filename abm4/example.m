% Base variables
syms x y;
f = y - x^2 + 1;

r = 10;
h = 0.2;
T = 2;
startY = zeros(1, 4);

% ODE Symbolic Solve
syms x y(x);
ode = diff(y) == y - x^2 + 1;
cond = y(0) == 2;
ySol(x) = dsolve(ode,cond);

% ODE compute start points
for i = 1:4
    startY(i) = ySol(h*(i-1));
end

% ODE Numeric Solve
[xs, ys] = abm4(r, f, h, T, startY);

% Plotting answers
title('ODE Answers')
grid on;

hold on;
plot(xs, ys);

hold on;
fplot(ySol,[0, T]);

legend('Numeric', 'Symbolic');

% find error, symbolic-numeric
symYs = ySol(0:h:T);
errorYs = symYs - ys;
error = double(norm(errorYs, inf));
fprintf("Error: %f\n", error);