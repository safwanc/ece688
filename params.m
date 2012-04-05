global Icom B L m g mgL mL2 

% Standard parameters
Icom = 0.1; 
L = 1; 
m = 2; 
g = 9.81; 
B = 60; 

% YABR Parameters
% Icom = 0.0004971 + 2*(0.0001096) + 2*(0.0001212); 
% L = 0.5; 
% m = 0.5313 + 2*(0.0981) + 2*(0.0553); 

% Precompute for efficiency
mgL = m*g*L; 
mL2 = m*(L^2);