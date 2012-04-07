
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
[SimTime, X] = ode45(@UnifiedEOM, Span, X0, SimOpts);

Theta   = X(:, 1); 
Omega   = X(:, 2); 

%% Plots Results
global HSim; figure(HSim); clf; hold on; 

subplot(2,1,1), plot(SimTime, Theta, 'r'); grid on; axis auto; 
ylabel('$$\theta$$ [deg]', 'interpreter', 'latex'); 
title('Unified Model $$\ddot{\theta} = F(\theta, \dot{\theta})$$', ...
    'interpreter', 'latex'); 

subplot(2,1,2), plot(SimTime, Omega, 'r'); 
ylabel('$$\dot{\theta}$$ [deg/s]', 'interpreter', 'latex'); 
xlabel('Time [s]'); axis auto; grid on; 

%% Save Data for Animation
save('UnifiedState.mat', 'SimTime', 'Theta', 'Omega'); 

% clear Sim* X* S* Theta Omega HSim