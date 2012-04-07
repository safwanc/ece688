function [ dx ] = Motion( obj, t, x )
% FPEODE Computes the FPE ODE (Eq 11)
    
    dx = zeros(2,1); theta  = x(1); dtheta = x(2); 
    [ Icom, beta, mgL, mL2 ] = UnifiedParameters(obj); 
    
    if (theta < 0)
        ddtheta = (mgL * sind(theta + beta/2)) / (Icom + mL2); 
    elseif (theta > 0)
        ddtheta = (mgL * sind(theta - beta/2)) / (Icom + mL2); 
    else
        if (dtheta < 0)
            ddtheta = (mgL * sind(theta + beta/2)) / (Icom + mL2); 
        elseif (dtheta > 0)
            ddtheta = (mgL * sind(theta - beta/2)) / (Icom + mL2); 
        else
            ddtheta = 0; 
        end
    end
    
    dx(1,1) = dtheta; 
    dx(2,1) = ddtheta; 
    
end

function [ Icom, Beta, mgL, mL2 ] = UnifiedParameters(obj)

    Icom = obj.I; 
    Beta = obj.B; 
    mgL  = obj.m * obj.g * obj.L; 
    mL2  = obj.m * ((obj.L)^2);
    
end

