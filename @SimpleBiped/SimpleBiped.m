classdef SimpleBiped
    %SIMPLEBIPED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        g = 9.81; 
    end
    
    properties
        B = 60; 
        L = 1; 
        Icom = 0.1; 
        m = 5; 
    end
    
    methods (Static)
        [ mgL, mL2 ] = Precompute(obj)
        %val = Precompute(obj, expr)
    end
    
    methods
        function obj = SimpleBiped(Beta, Length, Inertia, Mass)
            obj.B = Beta; 
            obj.L = Length; 
            obj.Icom = Inertia; 
            obj.m = Mass; 
        end
    end
    
    
end

