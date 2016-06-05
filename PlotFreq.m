function PlotFreq(f, mPhi)

T1 = 40 * (2*pi) / 360;

for ii = 1 : 1
    subplot(1,1,ii); hold on; grid on; set(gca, 'FontSize', 24);
    
    M  = max( abs( fft(mPhi(:,ii), length(f)) ) );
    h1 = stem(T1,   M, '-.r', 'LineWidth', 2);
    h2 = stem(2*T1, M, '-.r', 'LineWidth', 2);
    h3 = stem(3*T1, M, '-.r', 'LineWidth', 2);

    plot(f, fftshift( abs( fft(mPhi(:,ii), length(f)) ) ), 'LineWidth', 6);
    xlabel('$\theta$', 'Interpreter', 'Latex');
    ylabel(['$\mathcal{F}\left\{ \psi_{', num2str(ii), '}\right\}$'], 'Interpreter', 'Latex', 'FontSize', 30);
    ylim([0, M]);
    
    legend([h1, h2, h3], {'1st harmony', '2nd harmony', '3rd harmony'});
    
end

end