function [ h ] = Animate( obj, h, frames )

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
    pretitle = '2DOF Unified State Compass Biped'; 
    timestamp = @(title,t) [title ' (t = ' num2str(t, 3) 's)']; 
    
%     title('Unified Model $$\ddot{\theta} = F(\theta, \dot{\theta})$$', ...
%         'interpreter', 'latex'); 
    title(pretitle); 
    xlabel('X [m]', 'interpreter', 'latex'); 
    ylabel('Y [m]', 'interpreter', 'latex'); 
    axis([-(footsep+0.125) (footsep+0.125) -0.025 (height+0.1)]); grid on;
    
    % Circles for COM and pivots
    c = 0 : pi/100 : 2*pi; 
    c2 = 0 : pi/100 : pi; 
    comcircx  = (L/10) * sin(c); comcircy = (L/10) * cos(c); 
    footcircx = (L/40) * sin(c); footcircy = (L/40) * cos(c); 

    % Initialize object handles
    line([-5 5], [0 0], 'LineWidth', 3, 'Color', 'k');
    
    fpetarget  = line([0.1 0.1], [0.005 2], 'LineWidth', 2, 'LineStyle', ':', 'Color',[.4 .4 .4]);
    fpesol     = line([footsep footsep], [0.005 2], 'LineWidth', 2, 'LineStyle', ':', 'Color',[.8 .8 .8]);

    stance  = plot([A(1), C(1)], [A(2), C(2)], 'k', 'LineWidth', 3); 
    swing   = plot([B(1), C(1)], [B(2), C(2)], 'k--', 'LineWidth', 3); 
    stancef = fill(footcircx+A(1), footcircy+A(2), [0.6235 0.7647 0.8627]); 
    swingf  = fill(footcircx+B(1), footcircy+B(2), [0.6235 0.7647 0.8627]); 
    com     = fill(comcircx+C(1), comcircy+C(2), [0.6235 0.7647 0.8627]); 
    
    set(gca, 'XTickLabel', []);
    set(gca, 'YTickLabel', []);
    
    %% Frame Selection
    SAVEPLOT = 0; 
    
    previous = struct(); 
    previous.velocity = [0 0]'; 
    previous.C = [0 0]'; 
    previous.X = 0; 
    previous.t = 0; 
    previous.thA = 0; 
    previous.thB = 0; 
    
    frame = 1 : 1 : length(t);
    framedelay = 0.001; 
    
    if nargin > 2 % Save specific frames..
        frame = zeros(length(frames), 1); 
        for i = 1 : length(frames)
            [~,idx] =  min(abs(t-frames(i)));
            frame(i) = idx; 
        end
        
        framedelay = 1; 
        SAVEPLOT = 1; 
    end
    
%% Animate Compass Biped
    for i = 1 : length(frame) 
        n = frame(i); % Select a specific frame to draw
        t = obj.t(n);
        
        theta = obj.X(n); [A, B, C] = obj.ForwardKinematics(theta);
        tstep = abs(t - previous.t); 
        
        
        if i > 1
            v = (C - previous.C) / tstep;
        else
            v = [0; 0]; 
        end
        
        thA = GetThetaA(obj, theta); dthA = (thA - previous.thA) / tstep;
        thB = GetThetaB(obj, theta); dthB = (thB - previous.thB) / tstep;

        if (C(2) < 0)
            warning('The biped has fallen.'); 
            return
        else
            % Readjust plot view to keep biped centered. 
            xlim([C(1)-(footsep+0.125) (C(1)+footsep+0.125)]);
            %axis square
        end
        
        [phi, fpex2] = FPESolver(v(1), v(2), dthA, obj.m, obj.I, obj.g, C(2)); 

        % Plotting Updates
        title(timestamp(pretitle,t)); 
        
        % FPE Update
        fpex = C(1) + fpex2;
        set(fpesol, 'XData', [fpex fpex]); 
        
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
        
        %% 
        if nargin > 2
            BipedUtil.SavePlot(['Frame' num2str(frames(i))], gcf); 
        end
        
        previous.t = t; 
        previous.C = C; 
        previous.thA = thA; 
        previous.thB = thB;
        previous.velocity = v;
        
        pause(framedelay); 
        
    end
    
    hold off    
end



