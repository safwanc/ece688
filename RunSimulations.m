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

HTimePlot   = 1;    % Figure handle for 'Time Evolution Plots'
HPhasePlot  = 2;    % Figure handle for 'Phase Portrait Plots'
HAnimPlot   = 3; 

fprintf(1,'\nECE 688: Course Project Simulation\n');

%% Init + Simulate 
Initialize2DOF; Simulate(Biped, [-29; 0]); 

%% Produce Plots

% Display time evolution of uniform state variable
TimeEvolution(Biped, HTimePlot); 

% Display phase portrait with stable regions outlined. 
PhasePortrait(Biped, HPhasePlot); 

% @TODO: Display state trajectories overlaid 

% Animate Biped Motion
Animate(Biped, HAnimPlot); 

%% Clean
clear H*; 