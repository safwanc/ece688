classdef Biped2DOF < handle
    %BIPED2DOF Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        
        g = 9.81;   % Gravity Constant      [m/s^2]
        
    end
    
    properties (SetAccess = private)
        
        B = 60;     % Biped Leg Spread      [deg]
        L = 0.5;    % Biped Leg Length      [m]
        I = 0.1;    % Inertia about Pivot   [kg m^2]
        m = 2.0;    % Total Mass at COM     [kg]
        
        X   = [];   % Uniform State Angle       [deg, deg/s]
        DX  = [];   % Uniform State Velocity    [deg/s]
        t   = [];   % Simulation Time Vector    [s]
        
    end
    
    properties (SetAccess = private, GetAccess = private)
        
        d = [];     % Nominal Pivot Seperation  [m]
        h = [];     % Nominal COM Height        [m]
        
    end % /properties
    
    methods 
        
        function [obj] = Biped2DOF(Mass, Inertia, Length, Beta)
            
            if nargin > 0
                obj.m = Mass; 
                obj.I = Inertia; 
                obj.L = Length; 
                obj.B = Beta; 
            end
            
            obj.d = obj.L * sind(obj.B/2); 
            obj.h = obj.L * cosd(obj.B/2);

        end % /constructor
        
        
        % ODE representing the Equation of Motion Equation (11) in [1]:
        [dx] = Motion(obj, t, x)
        
        % Numerically integrates ODE to simulate a Biped2DOF instance: 
        [t, x, dx] = Simulate(obj, x0, tf, opts)
  
        
    end % /methods
    
    methods (Static)
        
        [anga] = ThetaA(obj, theta); 
        [angb] = ThetaB(obj, theta); 
        
    end % /methods (Static)
    
end % /classdef

