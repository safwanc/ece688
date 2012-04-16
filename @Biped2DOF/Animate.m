function [ h ] = Animate( obj, h )

    if nargin < 2
        h = randi(10);
    end
    
    footsep = obj.d; 
    height = obj.h; 
    L = obj.L;
    t = obj.t; 
    
    [A, B, C] = obj.ForwardKinematics(obj.X(1));
    
    %% Figure Initialization
    figure(h); clf; hold on
    title('Unified Model $$\ddot{\theta} = F(\theta, \dot{\theta})$$', ...
        'interpreter', 'latex'); 
    xlabel('X [m]', 'interpreter', 'latex'); 
    ylabel('Y [m]', 'interpreter', 'latex'); 
    axis([-(footsep+0.1) (footsep+0.1) -0.1 (height+0.2)]); grid on;
    
    % Circles for COM and pivots
    c = 0 : pi/100 : 2*pi; 
    comcircx  = (L/15) * sin(c); comcircy = (L/15) * cos(c); 
    footcircx = (L/40) * sin(c); footcircy = (L/40) * cos(c); 

    % Initialize object handles
    line([-5 5], [0 0], 'LineWidth', 3, 'Color', 'k');
    
    com     = fill(comcircx+C(1), comcircy+C(2), 'b'); 
    stance  = plot([A(1), C(1)], [A(2), C(2)], 'b', 'LineWidth', 3); 
    swing   = plot([B(1), C(1)], [B(2), C(2)], 'b--', 'LineWidth', 3); 
    stancef = fill(footcircx+A(1), footcircy+A(2), 'b'); 
    swingf  = fill(footcircx+B(1), footcircy+B(2), 'b'); 

%% Animate Compass Biped
    for i = 1 : length(t) 
        
        theta = obj.X(i); [A, B, C] = obj.ForwardKinematics(theta);
        
        if (C(2) < 0)
            warning('The biped has fallen.'); 
            return
        else
            xlim([C(1)-(footsep+0.3) (C(1)+footsep+0.3)]);
            axis square
        end
        
        % COM Update
        set(com, 'XData', comcircx+C(1), 'YData', comcircy+C(2)); 

        % Stance Update
        set(stance, 'XData', [A(1), C(1)], 'YData', [A(2), C(2)]); 
        set(stancef, 'XData', footcircx+A(1), 'YData', footcircy+A(2)); 

        % Swing Update
        set(swing, 'XData', [B(1), C(1)], 'YData', [B(2), C(2)]); 
        set(swingf, 'XData', footcircx+B(1), 'YData', footcircy+B(2));
        
        if (theta < 0)
            set(stance, 'LineStyle', '-'); 
            set(swing, 'LineStyle', '--'); 
        else
            set(stance, 'LineStyle', '--'); 
            set(swing, 'LineStyle', '-'); 
        end
        
        if i < length(t)
            pause((t(i+1) - t(i))/2); 
        end
        
    end
    hold off    
end



