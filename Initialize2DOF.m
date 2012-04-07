global Biped

Beta    = 60;   % Biped Leg Spread      [deg]
Length  = 0.5;  % Biped Leg Length      [m]
Mass    = 2.0;  % Total Mass at COM     [kg]
Inertia = 0.1;  % Inertia about Pivot   [kg m^2]

Biped = Biped2DOF(Mass, Inertia, Length, Beta)
% [mgL, mL2] = Biped2DOF.Precompute(BIPED);

clear Beta Length Mass Inertia