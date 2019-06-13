function [resultT, resultY] = taylorP(f, p, u0, t0, h, T)

% init result values
resultT = t0:h:T;
resultY = t0:h:T;

resultT(1) = t0;
resultY(1) = u0;

% create symbolic derivations functions, convert to numeric function
% dfs(1) = f(t, y(t))
% dfs(2) = diff(f(t, y(t)))
% dfs(3) = diff(diff(f(t, y(t))))
% ...
syms t y;
dfs(1) = symfun(f, [t y]);
for i = 1:p-1
    dfs(i+1) = diff(dfs(i), t) + f*diff(dfs(i), y);
end
df = matlabFunction(symfun(dfs, [t y]));

% compute the taylor series value for p, range
for i = 1:((T-t0)/h)
    % u_i+1 = u_i + h*Du_i + (h^2/2)*D2u_i + ...
    
    % compute
    D = df(resultT(i), resultY(i));
    
    % set default value for taylor series p (u0)
    resultY(i+1) = resultY(i);
    
    % sum taylor series parts
    for j = 1:p
        resultY(i+1) = resultY(i+1) + h^(j)/factorial(j) * D(j);
    end
    
end

end