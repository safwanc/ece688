% RUNSIMULATIONS Executes simulations to produce all plots/results
%
% Course:       ECE 688
%               Nonlinear Systems
%
% See also:     BIPED2DOF

% Author:       Safwan Choudhury, MASc
%               University of Waterloo
%
% Date:         April 10, 2012
%
% Email:        schoudhu@uwaterloo.ca
% Website:      http://ece.uwaterloo.ca/~schoudhu



%% Workspace
close all; clear all; clc
global Biped HTimePlot HPhasePlot HAnimPlot

SavePlots = false; 

HTimePlot   = 1;    % Figure handle for 'Time Evolution Plots'
HPhasePlot  = 2;    % Figure handle for 'Phase Portrait Plots'
HAnimPlot   = 3; 


fprintf(1,'\nECE 688: Course Project Simulations\n');

%% Init + Simulate 
X0 = [-17; 5];

% System Parameters + Init
Beta    = 60;   % Biped Leg Spread      [deg]
Length  = 0.2;  % Biped Leg Length      [m]
Mass    = 2.0;  % Total Mass at COM     [kg]
Inertia = 0.1;  % Inertia about Pivot   [kg m^2]

Biped = Biped2DOF(Mass, Inertia, Length, Beta);

SimCases = struct(...
    'PerfectStepping', 60, ...
    'UnderStepping',   30, ...
    'OverStepping',    90  ...
    );

%% Produce Plots

CaseTitles = fieldnames(SimCases); 
n = length(CaseTitles); 

for i = 1 : n

    close all; disp(' '); SimCase = char(CaseTitles(i));
    disp(['> [' num2str(i) '/' num2str(n) ']: Running simulation ' ...
        ' `' SimCase '`']); 
    
    % Update biped configuration and run simulation. 
    Biped.B = SimCases.(SimCase); Simulate(Biped, X0); 
    
    % Display time evolution of uniform state variable
    TimeEvolution(Biped, HTimePlot); 

    % Display phase portrait with stable regions outlined. 
    PhasePortrait(Biped, HPhasePlot); 
    
    % Overlay phase trajectory 
    PhaseEvolution(Biped, HPhasePlot); 

    % Animate Biped Motion
    Animate(Biped, HAnimPlot); 
    
    if (SavePlots)
        BipedUtil.SavePlot(SimCase); 
    end
    
    disp(['> [' num2str(i) '/' num2str(n) ']: Simulation complete. ' ...
        'Press any key to continue']); input(''); 
    
end

%% Clean
clear Beta Length Mass Inertia
% clear H*; 