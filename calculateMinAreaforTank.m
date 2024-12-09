V=1000
f1=@(r) 4*pi*r - (2*V)/(r^2);
f1_dash = @(r) 4*pi + (4*V)/(r^3);
root = newton_raphson(f1,f1_dash,1,0.005,20);
h = V / (pi * root^2);
A = 2*pi*root^2 + 2*pi*root*h;
disp(A);



h = V / (pi * root^2);
A = 2*pi*root^2 + 2*pi*root*h;


