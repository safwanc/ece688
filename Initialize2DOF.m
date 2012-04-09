% INITIALIZE2DOF Instantiates a Biped2DOF object with initial conditions.
%
% Course:       ECE 688
%               Nonlinear Systems
%
% See also:     BIPED2DOF

% Author:       Safwan Choudhury, MASc
%               University of Waterloo
%
% Date:         April 10, 2012
%
% Email:        schoudhu@uwaterloo.ca
% Website:      http://ece.uwaterloo.ca/~schoudhu

global Biped

%% System Parameters + Init
Beta    = 60;   % Biped Leg Spread      [deg]
Length  = 0.5;  % Biped Leg Length      [m]
Mass    = 2.0;  % Total Mass at COM     [kg]
Inertia = 0.1;  % Inertia about Pivot   [kg m^2]

Biped = Biped2DOF(Mass, Inertia, Length, Beta) % Display initialized biped

%% Clean
clear Beta Length Mass Inertia