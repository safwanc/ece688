function [ mgL, mL2 ] = Precompute(obj)

    m = obj.m; 
    g = obj.g; 
    L = obj.L; 
    
    mgL = m*g*L; 
    mL2 = m*(L^2);
    
end

