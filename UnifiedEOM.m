function [ DX ] = UnifiedEOM( t, X )
% FPEODE Computes the FPE ODE (Eq 11)
    
    global Biped; Icom = Biped.I;  Beta = Biped.B; 
    [mgL, mL2] = Biped2DOF.Precompute(Biped);

    DX = zeros(2,1); 
    
    Theta  = X(1); 
    Omega = X(2); 
    
    % Equation 11 from the Paper
    if (Theta < 0)
        ddtheta = (mgL * sind(Theta + Beta/2)) / (Icom + mL2); 
    elseif (Theta > 0)
        ddtheta = (mgL * sind(Theta - Beta/2)) / (Icom + mL2); 
    else
        if (Omega < 0)
            ddtheta = (mgL * sind(Theta + Beta/2)) / (Icom + mL2); 
        elseif (Omega > 0)
            ddtheta = (mgL * sind(Theta - Beta/2)) / (Icom + mL2); 
        else
            ddtheta = 0; 
        end
    end
    
    DX(1,1) = Omega; 
    DX(2,1) = ddtheta; 
    
end

