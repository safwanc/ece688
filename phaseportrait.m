%% Init
clc 
clear all
close all

%% Compute phase portrait 
params;

N = 100; 

x1 = linspace(-90, 90, N); 
x2 = linspace(-500, 500, N); 

[dx1, dx2] = meshgrid(x1, x2); 

u = zeros(size(dx1));
v = zeros(size(dx2));

for i = 1:numel(dx1)
    dx = fpeode([dx1(i); dx2(i)]); 
    u(i) = dx(1); 
    v(i) = dx(2); 
end

%% Plotting
global B
close all

streamslice(dx1, dx2, u, v, 20); figure(gcf); hold on; 

title(['FPE Phase Portrait for \beta = ' num2str(B) ]); 
xlabel('\theta [deg]'); ylabel('d\theta [deg/s]'); 
axis([-90 90 -90 90]); axis square
% grid on; 

%% Save
saveas(gcf, 'phaseportrait.eps'); 