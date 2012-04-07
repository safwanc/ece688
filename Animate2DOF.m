



h = figure(5); clf(h); axis([xrange yrange]); hold on
title('2DOF Biped Animation'); xlabel('X [m]'); ylabel('Y [m]'); 

xground = xrange(1):0.1:xrange(2); 
yground = zeros(1, length(xground)); 
hground = plot(xground, yground, 'k', 'LineWidth', 3); 

%% ---------------


% ANIMATESIM Loads and plays back results from FPE_MODEL (saved to file).
%   Requires the state and time evolution information form a FPE_MODEL
%   output. 

% Course:       ECE 688
%               Nonlinear Systems
%
% Author:       Safwan Choudhury, MASc
%               University of Waterloo
%
% Date:         April 10, 2012
%
% Email:        schoudhu@uwaterloo.ca
% Website:      http://ece.uwaterloo.ca/~schoudhu

global B L
load animdata
HANIMFIG = 10; 

%% Load + Compute Biped Kinematics
if ~(exist('t', 'var') || exist('th', 'var'))
    error('Unable to load simulation results for animation'); 
end

%% Compute Kinematics
% Calculate Combined Model Angles: 
thA = th + B/2; 
thB = th - B/2; 

getangs = @(th) [th+B/2 th-B/2]; 

% Compute nominal foot position + COM height
f = L * sind(B/2); 
h = L * cosd(B/2);

% Compute the pivot points for each leg
pivA = -f; pivB = f; 


% Position Vector to COM (i.e. Stance Foot)
rstance = [L*sin(thA), L*cos(thA)]; 

% Position Vector from COM (i.e. Swing Foot)
rswing = ((-1 * [L*sin(thB), L*cos(thB)]) + rstance); 


%% Figure Initialization


figure(HANIMFIG); clf; xrange = [-(f+1) (f+1)]; yrange = [-0.5 (h+2)]; 
title('2DOF Compass Biped'); xlabel('X [m]'); ylabel('Y [m]'); 
axis([-0.6 0.6 -0.25 0.6]); axis equal; grid on; hold on

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
tic
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
toc
hold off
