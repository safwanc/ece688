global Icom B L m g mgL mL2 

%% Standard parameters
g = 9.81; 
B = 60; 

%% Simple Parameters
Icom = 0.1; 
L = 0.5; 
m = 10; 

%% YABR Parameters
% Icom = 0.0004971 + 2*(0.0001096) + 2*(0.0001212); 
% L = 0.0826+0.0303+0.0852+0.1101; 
% m = 0.5313 + 2*(0.0981) + 2*(0.0553); 

%% Precompute
mgL = m*g*L; 
mL2 = m*(L^2);