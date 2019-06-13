function [ X, Y ] = abm4( r, f, h, T, startY )

digits(r*2);

% Optimize function `f` for numerical computation
syms x y;
symbolicF = symfun(f, [x y]);
numericF = matlabFunction(symbolicF);

% Init ranges
X = 0:h:T;
Y = startY;

% Iterate i's and find Y(i+1)
for i = 5:length(X)
    % Predictor
    Y(i) = adams_bashforth4(numericF, h, X(i-4:i-1), Y(i-4:i-1));
    
    % Corrector, iterate while gets r correct decimals (rD)
    correctY = 0;
    while abs(correctY - Y(i)) >= 0.5 * 10 ^ (-r)
        correctY = Y(i);
        
        % Corrector
        Y(i) = adams_moulton4(numericF, h, X(i-3:i), Y(i-3:i));
    end
end

end

