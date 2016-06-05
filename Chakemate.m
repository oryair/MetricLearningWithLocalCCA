close all;
clear;

load F.mat;

N = size(F, 3);

% F1 = F(:,1:200,:);
% F2 = F(:,101:300,:);

F1 = reshape(F(:,1:200,:),   [], N);
F2 = reshape(F(:,101:300,:), [], N);

%% Random Projections:
M  = 500;
mB1 = randn(M, size(F1, 1));
mB1 = bsxfun(@rdivide, mB1, sqrt( sum(mB1.^2, 2) ) );

mB2 = randn(M, size(F1, 1));
mB2 = bsxfun(@rdivide, mB2, sqrt( sum(mB2.^2, 2) ) );

F1 = bsxfun(@minus, F1, mean(F1, 1));
F2 = bsxfun(@minus, F2, mean(F2, 1));

mD1 = mB1 * F1;
mD2 = mB2 * F2;


%% CCA Video

mCCA_data1 = mD2;
mCCA_data2 = mD1;
mEstimate_distance = CCA_Reconstruction2(mCCA_data1, mCCA_data2, 1);
mPhi_CCA           = Diffusion_Maps(mEstimate_distance);

f = linspace(-pi, pi, 1025); f(end) = [];
PlotFreq(f, mPhi_CCA);
