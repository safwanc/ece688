function [ h ] = Animate( obj, h )

    if nargin < 2
        h = randi(10);
    end
    
    i = 1; GetTheta = @(k) obj.X(k); 
    theta = GetTheta(i); 
    
    
   %% Compute Kinematics
    % Calculate Combined Model Angles: 
    thetaa = obj(theta); 
    thetab = th - B/2; 

    % Compute nominal foot position + COM height
    d = L * sind(B/2); 
    h = L * cosd(B/2);

    % Compute the pivot points for each leg
    PivotA = -d; PivotB = d; 


    % Position Vector to COM (i.e. Stance Foot)
    rstance = [L*sin(thetaa), L*cos(thetaa)]; 

    % Position Vector from COM (i.e. Swing Foot)
    rswing = ((-1 * [L*sin(thetab), L*cos(thetab)]) + rstance); 


    %% Figure Initialization
    figure(h); clf; hold on
    title('Unified Model $$\ddot{\theta} = F(\theta, \dot{\theta})$$', ...
        'interpreter', 'latex'); 
    xlabel('X [m]', 'interpreter', 'latex'); 
    ylabel('Y [m]', 'interpreter', 'latex'); 
    axis([-(d+1) (d+1) -0.5 (h+2)]); grid on;
    

    c = 0 : pi/100 : 2*pi; % Circles for COM and pivots
    comcircx  = (L/15) * sin(c); comcircy = (L/15) * cos(c); 
    footcircx = (L/40) * sin(c); footcircy = (L/40) * cos(c); 

    % Initialize object handles
    floor   = line([-5 5], [0 0], 'LineWidth', 3, 'Color', 'k');
    com     = fill(comcircx+rstance(1,1), comcircy+rstance(1,2), 'b'); 
    stance  = plot([0, rstance(1,1)], [0, rstance(1,2)], 'b', 'LineWidth', 3); 
    stancef = fill(footcircx+0, footcircy+0, 'b'); 
    swing   = plot([0, rswing(1,1)], [0, rswing(1,2)], 'b--', 'LineWidth', 3); 
    swingf  = fill(footcircx+rswing(1,1), footcircy+rswing(1,2), 'b'); 

    %% Animate Compass Biped
    for i = 1 : length(t) 
        % COM Update
        set(com, 'XData', comcircx+rstance(i,1), 'YData', comcircy+rstance(i,2)); 

        % Stance Update
        set(stance, 'XData', [0, rstance(i,1)], 'YData', [0, rstance(i,2)]); 
        set(stancef, 'XData', footcircx+0, 'YData', footcircy+0); 

        % Swing Update
        set(swing, 'XData', [rstance(i,1), rswing(i,1)], 'YData', [rstance(i,2), rswing(i,2)]); 
        set(swingf, 'XData', footcircx+rswing(i,1), 'YData', footcircy+rswing(i,2));

        if i < length(t)
            pause(t(i+1) - t(i)); 
        end
    end
    hold off    
end

function [a, b, c] = ForwardKinematics(obj, theta)
    % Compute the positions of PivotA, PivotB and the COM based on the
    % unified state variable 'theta'. 
    
    RotateCW  = @(theta) obj.L*[cosd(theta);sind(theta)]; 
    RotateCCW = @(theta) obj.L*[cosd(theta);-sind(theta)];
    
    a = -obj.d; 
    b = obj.d; 
    
    if (theta > 0) 
        a = - obj.d; 
        % compute b, c
    elseif (theta < 0)
        b = obj.d; 
        % compute a, c
    else
        a = 

end

