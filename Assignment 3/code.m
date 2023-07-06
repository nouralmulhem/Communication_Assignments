clc;
close all;
clear;
%% Generate signal
% time
t = 0:0.01:1;

duty = 100;
% signal one
s1 = square(2*pi*t, duty);

% Generate square wave with 75% duty cycle
duty = 75; 
% signal two
s2 = square(2*pi*t, duty);

% return the Gram-Schmidt orthonormal bases functions
% for both signals s1 and s2
[phi1, phi2] = GM_Bases(s1, s2);

%% plot signal one
figure
plot(t, phi1)
title('bases function for signal 1')
xlabel('time')
ylabel('signal 1')
legend('phi 1')

%% plot signal two
figure
plot(t, phi2)
title('bases function for signal 2')
xlabel('time')
ylabel('signal 2')
legend('phi 2')
%% get signal spaces
% return the projection of s1 and s2 over the
% basis function phi1 and phi2
% get spaces of signal one
[v11, v21] = signal_space(s1, phi1, phi2);
% get spaces of signal two
[v12, v22] = signal_space(s2, phi1, phi2);

%% plot spaces of signal one and two
figure
hold on
title('signal space representation')
scatter(v11, v21, 'blue')
plot([0 v11] , [0 v21], 'LineWidth', 2)
scatter(v12, v22, 'red')
plot([0 v12] , [0 v22], 'LineWidth', 2)
hold off
xlabel('phi_1');
ylabel('phi_2');

%% add noice to signal one and two
add_noise(s1,s2,phi1,phi2)

%% gat orthonormal bases of signal one and two
function [phi1,phi2] = GM_Bases(s1,s2)
% get integration of signal 1
s11= trapz(0:0.01:1, s1);
% get bases one 
phi1 = s1 / s11;

% get s2 in bases one 
s21 = phi1.*s2;
% get integration of signal 2
val = trapz(0:0.01:1, s21);
% subtract from siganl two
s2 = s2 - val*phi1;
s2_squared = s2 .* s2;
% get integration of signal 2 after substracted 
s22 = trapz(0:0.01:1, s2_squared);
% get bases two 
phi2 = s2 / sqrt(s22);
end
%% get signal space representation of input signal s
function [v1,v2] = signal_space(s,phi1,phi2)
v1 = dot(s, phi1) /length(s);
v2 = dot(s, phi2) /length(s);
end

%% add noice to signal one and two
function add_noise(s1,s2,phi1,phi2)
% get spaces of signal one
[v11_origin, v21_origin] = signal_space(s1, phi1, phi2);
% get spaces of signal two
[v12_origin, v22_origin] = signal_space(s2, phi1, phi2);
% values of snr
snr = [-5,0,10];
E1 = sum(abs(s1).^2);
E2 = sum(abs(s2).^2);
for i=1:3
    % get snr value
    snr_value=10 ^(snr(i)/10);
    % get variance of signal 1
    variance1 = E1 ./ snr_value;
    % get variance of signal 2
    variance2 = E2 ./ snr_value;
    figure
    title("signal space with snr = " + snr_value + " dB")
    for j=1:50
        % Add the noise to the original signal
        r1 = s1 +  (sqrt(variance1) * randn(size(s1)));
        % noise on signal two
        r2= s2 +  (sqrt(variance2) * randn(size(s2)));
        % get spaces of signal one noisey
        [v11,v21]=signal_space(r1,phi1,phi2);
        % get spaces of signal two noisey
        [v12,v22]=signal_space(r2,phi1,phi2);

        hold on;
        scatter(v11, v21, 'blue');
        hold on;
        scatter(v12, v22, 'green');
    end
    hold on;
    scatter(v11_origin, v21_origin, 50 , 'red', 'filled');
    hold on;
    scatter(v12_origin, v22_origin, 50 , 'magenta', 'filled');
    xlabel('phi_1');
    ylabel('phi_2');
    title(['SNR:' , num2str(snr(i))]);
    legend( 'Signal one noisey', 'Signal two noisey','Signal one', 'Signal two' );
    hold off;
end
end
