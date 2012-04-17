function [ h ] = PhasePortrait( obj, h )

    %% Adjustable Parameters
    
    N       = 100;  % Point Seperation
    dthlim  = 50;   % Y-Axis +/- Limit
    thlim   = 80;   % X-Axis +/- Limit
    
    %% Phase Curve Generation
    x1 = linspace(-90, 90, N); 
    x2 = linspace(-250, 250, N); 

    [dx1, dx2] = meshgrid(x1, x2); 

    u = zeros(size(dx1));
    v = zeros(size(dx2));

    for i = 1:numel(dx1)
        dx = obj.Motion(0, [dx1(i); dx2(i)]); 
        u(i) = dx(1); 
        v(i) = dx(2); 
    end

    %% Phase Portrait Plot
    if nargin < 2
        h = randi(10);
    end
    
    figure(h); clf; 
    
    streamslice(dx1, dx2, u, v, 20); h = figure(gcf); hold on; 
    title(['Uniform State Phase Portrait for $$\beta$$ = ' ...
        num2str(obj.B) '$$^{\circ}$$'], 'interpreter', 'latex'); 
    xlabel('$$\theta$$ [deg]', 'interpreter', 'latex'); 
    ylabel('$$\dot{\theta}$$ [deg/s]', 'interpreter', 'latex'); 
    axis([-thlim thlim -dthlim dthlim]); hold off; 
    
    %% Draw Regions
    StableRegions(obj, h); 
    
end

%% Stable Region Overlays
function [ hsr1, hsr2, hsr3 ] = StableRegions( obj, h )

    error(nargchk(2, 2, nargin));   % .. must have both inputs. 
    figure(h); hold on
    
    thrange     = xlim; 
    dthrange    = ylim; 
    DEL         = 0.1; 
    HIGH        = 2; 
    LOW         = 1; 

    % Physical parameters
    Icom = obj.I; 
    B    = obj.B; 
    mgL  = obj.m * obj.g * obj.L;   % Precompute for efficiency  
    mL2  = obj.m * ((obj.L)^2);
    
    %% Leg Spread Limits                [-Beta/2 < Theta < Beta/2]
    
    dthval  = dthrange(1) : DEL : dthrange(2); 
    thval   = ones(1,length(dthval)); 

    hspr = plot([-B*thval, NaN, B*thval], [dthval, NaN, dthval], ...
        'k-.', 'LineWidth', 2); 
%{
    %% Stable Region 1                        [Inside Energy Well]
    
    sr1 = @(th) sqrt( (2*mgL*(1-cosd(abs(th)-B/2))) / (Icom + mL2) ); % [Eq 27]

    thval = -B/2 : DEL : B/2;   % -B/2 < Theta0 < B/2
    sr1val = sr1(thval);    % Boundary values of Stable Region 1

    hsr1 = plot([thval, NaN, thval], [sr1val, NaN, -sr1val], ...
        'c--', 'LineWidth', 2); 

    %% Stable Region 2                        [Impact Energy Loss]
    
    % @HACK: For some reason the arg in sqrt is -ve, using -2 instead below: 
    sr2 = @(arg) sqrt(((2*mgL)/(Icom + mL2)) * (- cosd(arg) - cosd(B/2) + ...
        ( ( (1-cosd(B/2))*((Icom + mL2)^2) ) / ( (mL2*cosd(B)+Icom)^2) ) )); 

    thvala  = -(B/2)+DEL : DEL : 0-DEL;     % -B/2 < Theta0 < 0
    thvalb  = 0+DEL : DEL : (B/2)-DEL;      % 0 < Theta0 < B/2

    sr2aval =   sr2(thvala + B/2);          % dTheta0 >= 0 [Eq 38]
    sr2bval =  -sr2(thvalb - B/2);          % dTheta0 <= 0 [Eq 39]

    hsr2 = plot([thvala, NaN, thvalb], [sr2aval, NaN, sr2bval], ...
       'm--', 'LineWidth', 2); 

    %% Stable Region 3                       [Outside Energy Well] 
    
    sr3 = @(arg) sqrt((2*mgL*(1-cosd(arg))) / (Icom + mL2)); 

    thvala = thrange(LOW) : DEL : -B/2;     % Theta0 <= -B/2
    thvalb = B/2 : DEL : thrange(HIGH);     % Theta0 >= B/2

    sr3aval =   sr3(thvala + B/2);  % Lower bound of [Eq 44]
    sr3bval =   sr3(thvalb - B/2);  % Lower bound of [Eq 45]

    hsr3 = plot(...
        [thvala, NaN, thvala, NaN, thvalb, NaN, thvalb], ...
        [sr3aval, NaN, -sr3aval, NaN, sr3bval, NaN, -sr3bval], ...
       'y--', 'LineWidth', 2); 

    %% Plotting Stuff
%     hleg = legend([hsr1 hsr2 hsr3], 'STABLE_1', 'STABLE_2', 'STABLE_3');
%     set(hleg, ...
%         'Location', 'NorthOutside', ...
%         'FontAngle', 'italic', ...
%         'FontSize', 8, ...
%         'Orientation', 'horizontal'); 
%}
end

