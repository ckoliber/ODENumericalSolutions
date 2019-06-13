function [ result ] = adams_bashforth4( f, h, X, Y )

Betas_Order4 = [55/24 -59/24 37/24 -9/24];

% Compute the Sigma(Beta_i * f(i-k))
seriesResult = 0;
for k = 0:3
    seriesResult = seriesResult + Betas_Order4(k+1) * f(X(4-k), Y(4-k));
end

result = Y(4) + h*seriesResult;

end

