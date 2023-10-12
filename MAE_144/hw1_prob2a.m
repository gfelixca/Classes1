clear all; clc; close all;

%% MAE 144
%HW1 problem 2a
% Define numerator and denominator of G(s) using its roots
b = RR_poly([-2 2 -5 5], 1);
a = RR_poly([-1 1 -3 3 -6 6], 1);

% Define the desired polynomial f(s) for the closed-loop system
f_a = RR_poly([-1 -1 -3 -3 -6 -6], 1);

% Solve the Diophantine equation to get x(s) and y(s)
[x, y] = RR_diophantine(a, b, f_a);

% Verify the solution by comparing a(s)x(s) + b(s)y(s) to f(s)
test = trim(a*x + b*y);

% Compute the residual error between the desired and obtained polynomial
residual_2a = norm(f_a - test);

% Display the residual error 
disp('Residual error:');
disp(residual_2a);