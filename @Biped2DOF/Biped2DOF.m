classdef Biped2DOF < handle
    %BIPED2DOF Standard Compass Biped Model
    %   Represents the standard sagittal biped configuration used for
    %   simplified gait analysis in bipedal locomotion. This class is
    %   unique in the sense that it utilizes a uniform state variable
    %   to represent the system via geometric relationship between the
    %   physical parameters of the system. This approach is described
    %   in detail by Derek et al in [1]. 
    %
    %   See also:   INITIALIZE2DOF
    % 
    %   Reference:  [1] Introduction of the Foot Placement Estimator: 
    %                   A Dynamic Measure of Balance for Bipedal Robotics
    % 
    %                   (DOI: http://dx.doi.org/10.1115/1.2815334)
    
    % Author:       Safwan Choudhury, MASc
    %               University of Waterloo
    %
    % Date:         April 10, 2012
    %
    % Email:        schoudhu@uwaterloo.ca
    % Website:      http://ece.uwaterloo.ca/~schoudhu
    
    %% Class Properties
    
    properties (Constant)
        
        g = 9.81;   % Gravity Constant      [m/s^2]
        
    end
    
    properties 
        
        B = 60;     % Biped Leg Spread      [deg]
        
    end
    
    properties (SetAccess = private)
        
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
    
    %% Class Methods
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
        
        % Computes FK
        [A, B, C] = ForwardKinematics(obj, theta)
        
        [a] = GetThetaA(obj, theta); 
        [b] = GetThetaB(obj, theta); 
        
    end % /methods
    
end % /classdef

