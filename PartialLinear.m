close all;
clear;

set(0, 'DefaultAxesFontSize',   30);
% set(0, 'DefaultTextInterpreter','Latex')

%% Mapping Functions:
A  = [2,1;
      2,3];
f1 = @(mX) A * mX([1,2], :);
f2 = @(mX) [(mX(1,:) + mX(3,:) / 5) .* cos(20 * mX(1,:));
            (mX(1,:) + mX(3,:) / 5) .* sin(20 * mX(1,:))];


%% Generate Data:
N  = 500;
mX = 1 * rand(3, N); % Latent variable

mY1 = f1(mX); % Observation 1
mY2 = f2(mX); % Observation 2

mReal_distance = squareform( pdist(mX(1, :)') );

%% Plot Views
figure;
subplot(1,2,1); hold on; axis square;
title('$\mathcal{X}$', 'Interpreter', 'Latex');
scatter(mY1(1,:), mY1(2,:), 200, mX(1,:), '.', 'LineWidth', 5);
xlabel('x_1'); ylabel('x_2'); colorbar;
axis([0, 3, 0, 5]);

subplot(1,2,2); hold on; axis square;
title('$\mathcal{Y}$', 'Interpreter', 'Latex');
scatter(mY2(1,:), mY2(2,:), 200, mX(1,:), '.', 'LineWidth', 5);
xlabel('y_1'); ylabel('y_2'); colorbar;
axis([-1, 1, -1, 1]);

%% Euclid:
mEuclid_Y = squareform( pdist(mY1') );

%% CCA Hard:
mEstimate_distance = CCA_Burst_Reconstruction(mX, mY1, mY2, f1, f2, 1);

%%
vX = mReal_distance(triu(true(size(mReal_distance))));
vY = mEstimate_distance(triu(true(size(mEstimate_distance))));

figure; hold on; axis square; grid on;
scatter(vX, vY, 5, 'Fill'); 
xlabel('$\left\Vert {z}_{i}-{z}_{j}\right\Vert ^{2}$', 'Interpreter', 'Latex');
ylabel('$D_{ij}$', 'Interpreter', 'Latex');

