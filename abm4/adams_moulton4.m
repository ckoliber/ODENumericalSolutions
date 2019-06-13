function [ result ] = adams_moulton4( f, h, X, Y )

Betas_Order4 = [9/24 19/24 -5/24 1/24];

% Compute the Sigma(Beta_i * f(i-k+1))
seriesResult = 0;
for k = 0:3
    seriesResult = seriesResult + Betas_Order4(k+1) * f(X(4-k), Y(4-k));
end

result = Y(3) + h*seriesResult;

end