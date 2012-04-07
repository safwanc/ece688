global BIPED

Beta    = 60;   % Biped Leg Spread      [deg]
Length  = 0.5;  % Biped Leg Length      [m]
Mass    = 0.1;  % Total Mass at COM     [kg]
Inertia = 0.1;  % Inertia about Pivot   [kg m^2]

BIPED = SimpleBiped(Mass, Inertia, Length, Beta); 
% [mgL, mL2] = SimpleBiped.Precompute(BIPED);
