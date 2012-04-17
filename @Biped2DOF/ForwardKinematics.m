function [A, B, C] = ForwardKinematics(obj, theta)
    % Compute the positions of PivotA, PivotB and the COM based on the
    % unified state variable 'theta'. 
    
    persistent Rotate
    
    if isempty(Rotate)
        Rotate  = @(v,a) ([cosd(a) sind(a); -sind(a) cosd(a)] * v); 
    end
    
    % Nominal Configuration: 
    A = [-obj.d 0]'; 
    B = [obj.d 0]'; 
    C = [0 obj.h]'; 
    
    if theta ~= 0
        
        Beta   = obj.B; 
        ThetaA = obj.GetThetaA(theta); 
        ThetaB = obj.GetThetaB(theta); 
        Leg    = [0 obj.L]';
        
        if (theta < 0)
            % A is Pivot
            C = Rotate(Leg, ThetaA) + A; 
            B = Rotate(A-C, -Beta) + C; 
        else 
            % B is Pivot
            C = Rotate(Leg, ThetaB) + B; 
            A = Rotate(B-C, Beta) + C; 
        end
        
    end
    
end