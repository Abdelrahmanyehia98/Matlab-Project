% Create a new figure window for the interface
h = figure('Name', 'Volume to Area Calculation', 'Position', [100, 100, 400, 300]);

% Add an input field for the volume (V)
inputField = uicontrol('Style', 'edit', 'Position', [50, 200, 300, 30], 'String', 'Enter volume (V)');

% Add a text box to display the result
resultBox = uicontrol('Style', 'text', 'Position', [50, 100, 300, 30], 'String', 'Area:  ');

% Add a button to perform the calculation and display the result
buttonCalculate = uicontrol('Style', 'pushbutton', 'String', 'Calculate Area', ...
                           'Position', [50, 150, 300, 30], 'Callback', {@calculateResult, inputField, resultBox});

% Function to perform the calculations using an external function (Newton-Raphson)
function calculateResult(~, ~, inputField, resultBox)
    % Access the volume entered by the user
    V = str2double(get(inputField, 'String'));

    % Check if the input is a valid number
    if isnan(V)
        msgbox('Please enter a valid number for the volume!');
        return;
    end

    % Perform the Newton-Raphson method to find the root (radius)
    f1 = @(r) 4*pi*r - (2*V)/(r^2);
    f1_dash = @(r) 4*pi + (4*V)/(r^3);
    root = newton_raphson(f1, f1_dash, 1, 0.005, 20);

    % Calculate the height and area
    h = V / (pi * root^2);
    A = 2*pi*root^2 + 2*pi*root*h;

    % Display the result in the text box
    set(resultBox, 'String', ['Area: ' num2str(A)]);
end

% Newton-Raphson method
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

