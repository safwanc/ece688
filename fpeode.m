function [ dx ] = fpeode( x )
%FPEODE Computes the FPE ODE (Eq 11)
    
    global Icom B mgL mL2 
    dx = zeros(2,1); 
    
    theta  = x(1); 
    dtheta = x(2); 
    
    % Equation 11 from the Paper
    if (theta < 0)
        ddtheta = (mgL * sind(theta + B/2)) / (Icom + mL2); 
    elseif (theta > 0)
        ddtheta = (mgL * sind(theta - B/2)) / (Icom + mL2); 
    else
        if (dtheta < 0)
            ddtheta = (mgL * sind(theta + B/2)) / (Icom + mL2); 
        elseif (dtheta > 0)
            ddtheta = (mgL * sind(theta - B/2)) / (Icom + mL2); 
        else
            ddtheta = 0; 
        end
    end
    
    dx(1) = dtheta; 
    dx(2) = ddtheta; 
    
end

