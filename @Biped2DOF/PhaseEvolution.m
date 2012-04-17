function [ h ] = PhaseEvolution( obj, h )

    if nargin < 2
        h = randi(10);
        obj.PhasePortrait(h); 
    end
    
    figure(h); hold on;
    X0 = [obj.X(1); obj.DX(1)]; 
    
    % Plot initial condition marked with a '+'
    plot(X0(1), X0(2), 'r+', 'MarkerSize', 7, 'LineWidth', 3); 
    
    % Overlay phase trajectory on the phase portrait
    plot(obj.X, obj.DX, 'r', 'LineWidth', 3);
    
    B = obj.B; 
    %set(gca, 'XTick', [-30; -60/2; 0; 60/2; 60]); 
     set(gca, 'XTick', [-B; -B/2; 0; B/2; B]); 
    % set(gca, 'XTickLabel', {'$-\pi$', '$-\beta/2$', '$0$', '$\beta/2$', '$\beta$'}); 
end

