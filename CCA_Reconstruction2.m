function mEstimate_distance = CCA_Reconstruction2(mY1, mY2, flag)

%%
N                  = size(mY1, 2);
mEstimate_distance = zeros(N, N);
M                  = 6;

tCCA1 = zeros(size(mY1, 1), size(mY1, 1), N);
tCCA2 = zeros(size(mY2, 1), size(mY2, 1), N);
for ii = 1 : N
    ii
    if ii < M
        mBurst_idx = ii : ii + M;
    elseif ii < size(mY1, 2) - M / 2 
        mBurst_idx = ii - M / 2 : ii + M / 2;
    else
        mBurst_idx = ii - M : ii;
    end
    mBurst_Y   = mY1(:, mBurst_idx);
    mBurst_Z   = mY2(:, mBurst_idx);

    [mU1, mU2, vP] = canoncorr(mBurst_Y', mBurst_Z');
    if nargin < 3
        dim = length(vP);
    else
        dim = flag;
    end
    
    tCCA1(:,:,ii) = mU1(:, 1 : dim) * diag(vP(1:dim)) * mU1(:, 1 : dim)';
    tCCA2(:,:,ii) = mU2(:, 1 : dim) * diag(vP(1:dim)) * mU2(:, 1 : dim)';
     
end

for ii = 1 : N
    ii
    vX1 = mY1(:,ii);
    vY1 = mY2(:,ii);
    
    for jj = ii + 1 : N
        vX2     = mY1(:,jj);
        vY2     = mY2(:,jj);
        vDiff_X = vX1 - vX2;
        vDiff_Y = vY1 - vY2;
        
        Cx = 0.5 * tCCA1(:,:,ii) + tCCA1(:,:,jj);
        Cy = 0.5 * tCCA2(:,:,ii) + tCCA2(:,:,jj);
        mEstimate_distance(ii,jj) = vDiff_X' * Cx * vDiff_X + ...
                                    vDiff_Y' * Cy * vDiff_Y;
    end
end

mEstimate_distance = mEstimate_distance + mEstimate_distance';
mEstimate_distance = sqrt(mEstimate_distance);

end