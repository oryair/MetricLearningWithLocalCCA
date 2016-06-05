function [mPhi, mLam] = Diffusion_Maps(mEstimate_distance)

eps = 0.5 * median(mEstimate_distance(:));
mW  = exp( -mEstimate_distance / eps );
mL  = bsxfun(@rdivide, mW, sum(mW,1));

% [mPhi, vLam] = eig(mL);
[mPhi, mLam] = svd(mL);
mPhi = mPhi(:, 2:end);

end