classdef Biped2DOF
    %SIMPLEBIPED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        g = 9.81;   % Gravity Constant      [m/s^2]
    end
    
    properties
        B = 60;     % Biped Leg Spread      [deg]
        L = 1;      % Biped Leg Length      [m]
        I = 0.1;    % Inertia about Pivot   [kg m^2]
        m = 5;      % Total Mass at COM     [kg]
    end
    
    methods (Static)
        [ mgL, mL2 ] = Precompute(obj)
    end
    
    methods
        function obj = Biped2DOF(Mass, Inertia, Length, Beta)
            if nargin > 0
                obj.m = Mass; 
                obj.I = Inertia; 
                obj.L = Length; 
                obj.B = Beta; 
            end
        end
    end
    
    
end

