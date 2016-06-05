function mEstimate_distance = CCA_Burst_Reconstruction(mX, mY1, mY2, f1, f2, flag)

N                  = size(mY1, 2);
mEstimate_distance = zeros(N, N);
M                  = 300;
dT                 = 0.001;

tCCA = zeros(size(mY1, 1), size(mY1, 1), N);
for ii = 1 : N
    mBurst_X   = bsxfun(@plus, dT * randn(size(mX, 1), M), mX(:,ii));
    mBurst_Y   = f1(mBurst_X);
    mBurst_Z   = f2(mBurst_X);

    [mU, ~, vP] = canoncorr(mBurst_Y', mBurst_Z');
if nargin < 6
    dim = length(vP);
else
    dim = flag;
end
    vP  = vP(1 : dim);
    vP  = vP / sum(vP);
    tCCA(:,:,ii) = mU(:, 1 : dim) * diag(vP(1:dim)) * mU(:, 1 : dim)';
end

for ii = 1 : N
    vY1 = mY1(:,ii);
    
    for jj = ii + 1 : N
        vY2   = mY1(:,jj);
        vDiff = vY1 - vY2;
        
        mEstimate_distance(ii,jj) = ...
            0.5 * vDiff' * (tCCA(:,:,ii) + tCCA(:,:,jj)) * vDiff;
    end
end

mEstimate_distance = mEstimate_distance + mEstimate_distance';
mEstimate_distance = sqrt(mEstimate_distance) * dT;

end