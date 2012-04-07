HNUMFIG = 5; 

%% Simulation Parameters
x0 = [...
        -3; ... Initial Angle
         1; ... Initial Angular Velocity
     ]; 
x0 = [-29; 0];
tspan = [0 20];

simopts = odeset(...
    'RelTol', 1e-12, ...
    'abstol', 1e-12  ...
);

params;

%% Numerical Integration
[t, x] = ode45(@fpeode, tspan, x0, simopts);

th  = x(:,1); 
dth = x(:,2); 

%% Plots Results
figure(HNUMFIG); clf; plot(t, th, 'r'); 
title('Numerical Simulation'); axis auto; grid on; 
xlabel('Time [s]'); ylabel('\theta [deg]'); 

%% Save Data for Animation
save('animdata.mat', 't', 'th'); 