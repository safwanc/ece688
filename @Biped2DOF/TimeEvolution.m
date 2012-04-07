function [ h ] = TimeEvolution( obj, h )

    if nargin < 2
        h = randi(10);
    end
    
    figure(h); clf;  hold on; 

    subplot(2,1,1), plot(obj.t, obj.X, 'r'); grid on; axis auto; 
    ylabel('$$\theta$$ [deg]', 'interpreter', 'latex'); 
    
    title('Unified Model $$\ddot{\theta} = F(\theta, \dot{\theta})$$', ...
        'interpreter', 'latex'); 

    subplot(2,1,2), plot(obj.t, obj.DX, 'r'); axis auto; grid on; 
    ylabel('$$\dot{\theta}$$ [deg/s]', 'interpreter', 'latex'); 
    
    % xlabel('Time [s]'); 
    hold off; 
    
end

