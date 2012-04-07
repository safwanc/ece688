function [ mgL, mL2 ] = PrecomputeConsts(obj)
    m = obj.m; 
    g = obj.g; 
    L = obj.L; 
    
    mgL = m*g*L; 
    mL2 = m*(L^2);
    
%     switch (expr)
%         case 'mgL'
%             val = m*g*L; 
%         case 'mL2'
%             val = m*(L^2); 
%         otherwise
%             error('Failed to precompute due to invalid expression'); 
%     end
end

