figure(gcf); hold on

global mgL mL2 Icom B
thrange     = xlim; 
dthrange    = ylim; 
DEL         = 0.5; 
HIGH        = 2; 
LOW         = 1; 

%% Leg Spread Limits [-Beta/2 < Theta < Beta/2]
dthval = dthrange(1) : DEL : dthrange(2); 
thval = ones(1,length(dthval)); 

hspr = plot([-B/2*thval, NaN, B/2*thval], [dthval, NaN, dthval], ...
    'k', 'LineWidth', 2); 

%% Stable Region 1 [Inside Energy Well]

thval = -B/2 : DEL : B/2;                           % -B/2 < Theta0 < B/2
sr1 = @(th) sqrt( (2*mgL*(1-cosd(abs(th)-B/2))) / (Icom + mL2) ); % [Eq 27]

sr1pos = sr1(thval);    % Positive root
sr1neg = -1 * sr1pos;   % Negative root

hsr1 = plot([thval, NaN, thval], [sr1pos, NaN, sr1neg], ...
    'c--', 'LineWidth', 2); 

%% Stable Region 2 [Impact Energy Loss]

thvala  = -(B/2)+DEL : DEL : 0-DEL;               % -B/2 < Theta0 < 0
%dthvala = 0 : DEL : dthrange(HIGH);     % dTheta0 >= 0

thvalb  = 0+DEL : DEL : (B/2)-DEL;                % 0 < Theta0 < B/2
%dthvalb = dthrange(LOW) : DEL : 0;      % 

sr2 = @(arg) sqrt(((-2*mgL)/(Icom + mL2)) * (- cosd(arg) - cosd(B/2) + ...
    ( ( (1-cosd(B/2))*((Icom + mL2)^2) ) / ( (mL2*cosd(B)+Icom)^2) ) )); 

dthvala =   sr2(thvala + B/2);  % dTheta0 >= 0 [Eq 38]
dthvalb =  -sr2(thvalb - B/2);  % dTheta0 <= 0 [Eq 39]

hsr2 = plot([thvala, NaN, thvalb], [dthvala, NaN, dthvalb], ...
   'm--', 'LineWidth', 2); 

%% Stable Region 3 [Outside Energy Well] 



%% Legends
legend([hsr1 hsr2], 'Stable Region 1', 'Stable Region 2')
