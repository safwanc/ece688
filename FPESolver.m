function [ phi, fpex ] = FPESolver( vx, vy, w, m, Icom, g, h)
% FPESOLVER Provides the FPE equation in the F(x) = 0 form. 
%   This function is used in the context of solver methods to obtain a
%   solution for the Foot Placement Estimator (FPE) angle PHI. 
%
% Syntax:  [  phi, fpex  ] = FPESolver( VX, VY, W, M, ICOM, G, H )
%
% Inputs:
%    VX - COM Velocity in X Direction
%    VY - COM Velocity in Y Direction
%    W - Average Angular Velocity About Pivot 
%    M - Total Mass of the Biped
%    ICOM - Total Inertia about the Biped COM
%    G - Gravity Constant
%    H - Height of COM
%
% Outputs:
%    PHI - FPE Angle
%
% See also:     BIPED2DOF RUNSIMULATION

% Author:       Safwan Choudhury, MASc
%               University of Waterloo
%
% Email:        schoudhu@uwaterloo.ca
% Website:      http://ece.uwaterloo.ca/~schoudhu

%   ------------- BEGIN FUNCTION --------------


    StepCount = 0; 
    MaxSteps = 20; 
    Tolerance = 1e-7; 
    CurrentValue = 1.0; 

    if (vx > 0.0)
        LowPos = 0.0; 
        HighPos = 1.570; 
    else
        LowPos = 0.0; 
        HighPos = -1.570; 
    end

    A = m * h; 
    B = A*vx + Icom*w; 
    C = 2.0 * A * (g); 
    D = C * Icom; 
    C = A * C * h; 
    A = A * vy;

    s1 = sin(LowPos); 
    c1 = cos(LowPos); 

    LowValue = A*s1 + B*c1; 
    LowValue = c1*LowValue*LowValue + (C+D*c1*c1)*(c1-1); 

    s1 = sin(HighPos); 
    c1 = cos(HighPos); 

    HighValue = A*s1 + B*c1; 
    HighValue = c1*HighValue*HighValue + (C+D*c1*c1)*(c1-1); 

    while ((abs(CurrentValue) > Tolerance) && (StepCount < MaxSteps))
        CurrentPos = (HighPos + LowPos) * 0.5; 

        s1 = sin(CurrentPos); 
        c1 = cos(CurrentPos); 

        CurrentValue = A*s1 + B*c1; 
        CurrentValue = c1*CurrentValue*CurrentValue + (C+D*c1*c1)*(c1-1); 

        if (CurrentValue < 0.0)
            HighValue = CurrentValue; 
            HighPos = CurrentPos; 
        else
            LowValue = CurrentValue; 
            LowPos = CurrentPos; 
        end

        StepCount = StepCount + 1;  
    end

    phi  =  CurrentPos/2; 
    fpex =  h * tan(phi);

%   ------------- END OF FUNCTION --------------

end

