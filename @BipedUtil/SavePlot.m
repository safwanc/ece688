function SavePlot(obj, name, h)
    if nargin < 3
        h = gcf; 
    end

    saveas(h, [name obj.imgext]); 
end