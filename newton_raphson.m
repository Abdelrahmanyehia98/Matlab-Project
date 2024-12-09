
function root = newton_raphson(f, f_dash, x0, tol, max_iter)
    % Initialize variables
    x = x0;
    for iter = 1:max_iter
        % Calculate the next value
        x_next = x - f(x) / f_dash(x);

        % Check for convergence
        if abs(((x_next - x)/x_next)*100) < tol
            root = x_next;
            return;
        end

        % Update x
        x = x_next;
    end
    error('Newton-Raphson method did not converge within the maximum iterations.');
end

