clear all; clc; close all;

%% MAE 144
%HW1 problem 3
syms z1 p1
% Define D(s)
s = tf('s');
z1_val = 1;
p1_val = 10;
Ds = (s + z1_val) / (s * (s + p1_val));
% Convert using custom function
Dz_custom = GAB_C2D_matched(Ds, 1);
% Compare the results
disp('Custom Function Result:')
disp(Dz_custom)

function Dz = GAB_C2D_matched(Ds, T, varargin)
    % XYZ_C2D_matched: Converts D(s) to D(z) using matched z-transform
    % Default values
    omega_bar = 0;
    Type = 'strictly-causal';

    % Parse optional input arguments
    for k = 1:length(varargin)
        if strcmp(varargin{k}, 'omega_bar')
            omega_bar = varargin{k+1};
        elseif strcmp(varargin{k}, 'Type')
            Type = varargin{k+1};
        end
    end

    % Obtain poles and zeros of D(s)
    [zeros_s, poles_s, ~] = zpkdata(Ds, 'v');

    % Map to z-plane using matched transformation
    zeros_z = exp(T * (zeros_s + 1i * omega_bar));
    poles_z = exp(T * (poles_s + 1i * omega_bar));

    % If strictly-causal, shift by one sampling period
    if strcmp(Type, 'strictly-causal')
        zeros_z = zeros_z / exp(T * 1i * omega_bar);
        poles_z = poles_z / exp(T * 1i * omega_bar);
    end

    % Return D(z) as a transfer function
    Dz = zpk(zeros_z, poles_z, dcgain(Ds), T);
end

