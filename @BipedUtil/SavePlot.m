function SavePlot(name, h)

    TimePlot = @(x) [x 'Time']; 
    PhasePlot = @(x) [x 'Phase']; 
    SavePlot = @(h,x) saveas(h, ['Plots/' x '.eps']); 

    if nargin < 2
        global HTimePlot HPhasePlot
        SavePlot(HTimePlot, TimePlot(name)); 
        SavePlot(HPhasePlot, PhasePlot(name));
    else
        SavePlot(h, name); 
    end

end