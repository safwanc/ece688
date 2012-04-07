global HSim; 
Initialize2DOF; 

%% Simulation Parameters
% X0 = [...
%         -3; ... Initial Angle
%          1; ... Initial Angular Velocity
%      ]; 
X0 = [-29; 0];

Span = [0 20];

SimOpts = odeset(...
    'RelTol', 1e-12, ...
    'abstol', 1e-12  ...
);

%% Numerical Integration
[t, X] = ode45(@UnifiedEOM, Span, X0, SimOpts);

Theta   = X(:, 1); 
Omega   = X(:, 2); 

%% Plots Results
figure(HSim); clf; hold on; 

subplot(2,1,1), plot(t, Theta, 'r'); ylabel('\theta [deg]'); 
title('Numerical Simulation Results'); axis auto; grid on; 


subplot(2,1,2), plot(t, Omega, 'r'); ylabel('\omega [deg/s]'); 
xlabel('Time [s]'); axis auto; grid on; 

%% Save Data for Animation
save('animdata.mat', 't', 'Theta', 'Omega'); 