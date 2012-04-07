classdef BipedUtil
    %BIPEDUTIL Various utility functions for saving/loading simulation data
    
    properties (Constant)
        imgext = '.eps'; 
    end
    
    methods
        
        function [obj] = BipedUtil
            % apparently this is necessary. 
        end % /constructor
        
    end
    
    methods (Static)
        SavePlot(obj, name, h); 
    end
    
end

