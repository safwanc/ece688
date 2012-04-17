function [ t, x, dx ] = Simulate( obj, x0, tf, opts )
    
    error(nargchk(1, 3, nargin)); 
   %% Validate + Initialize Parameters
    if nargin < 4               % Default ODE solver options. 
        opts = odeset(...
            'RelTol', 1e-12, ...
            'abstol', 1e-12  ...
        );
    end
    
    if nargin < 3               % Default simulation run time. 
        tf = 10;
    end
    
    if nargin < 2               % Equilibrium state if unspecified.
        x0 = [0 0]'; 
    end

   %% Uniform State Vector via ODE45
    % Wrap the odefunc call in an anonymous function to pass the
    % biped specific kinematic/dynamic parameters (i.e. Icom, etc) 
    [t, state] = ode45(@(t,x) Motion(obj, t, x), [0 tf], x0, opts);
    
    obj.X   = state(:, 1); 
    obj.DX	= state(:, 2);
    obj.t   = t; 
    
    % Output raw state vector if the caller specifically requests
    if nargout > 2
        dx = obj.DX; 
    end
    
    if nargout > 1
        x = obj.X; 
    end
    
end