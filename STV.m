%% STV method and STV Spectrum  

% The Short-Time Variance (STV) method calculates the changes in data dispersion within a signal using a 
% sliding step approach. In the presence of a fault in rotating machinery, there are abnormal impulse 
% events in the vibration signal triggered by the fault. These transient sparse impulses will cause an 
% increase in local dispersion, which is reflected in the STV signal.

% The discrete Fourier transform of the STV signal produces the STV spectrum. In this case, the STV spectrum 
% is compared with the classic envelope spectrum. A set of bearing vibration signals with inner race faults 
% (from the CWRU dataset) were superimposed with noise at different SNRs, and spectrograms were generated 
% using both methods. The comparison criterion was whether the spectral line at 161.8 Hz (fault frequency) 
% could be observed.

% The comparison results indicate that the STV spectrum not only has similar functionality to the envelope 
% spectrum but also performs better in high noise environments.

% Now enjoy it!
% Meng Zhang 06.Jul.24       meng1.zhang@mail.polimi.it

load I0.mat
signal=X209_DE_time; %I0

% Define SNRs
SNRs = [-12, -8, -4, 0]; 

% Sample rate
Fs = 12000; % Hz

% time axis
time = (0:length(signal)-1) / Fs;

% STV window length and step size
window_size = 10; 
step_size = 1;


figure;

for idx = 1:length(SNRs)
    snr = SNRs(idx);

    % add noise
    noisy_signal = awgn(signal, snr, 'measured');

    % STV process
    num_windows = floor((length(noisy_signal) - window_size) / step_size) + 1; % number of windows
    variances = zeros(1, num_windows);
    window_times = zeros(1, num_windows); 

    for i = 1:num_windows
        window_data = noisy_signal((i-1)*step_size + 1 : (i-1)*step_size + window_size); 
        variances(i) = var(window_data); 
        window_times(i) = time((i-1)*step_size + window_size/2); 
    end

    % STV spectrum
    N = length(variances); 
    frequencies = (0:N-1) * Fs / N; 
    signal_spectrum = fft(variances)*2/N; 
    signal_spectrum = abs(signal_spectrum(1:N/2)); 

    % Envolope spectrum
    es = envspectrum(noisy_signal, Fs); 
    N2 = length(noisy_signal); 
    frequencies2 = (0:N2-1) * Fs / N2; 
    half_N2 = floor(N2/2);

    row = idx;
    
    subplot(length(SNRs), 4, (row-1)*4 + 1);
    plot(time, noisy_signal, 'LineWidth', 0.8);set(gca, 'LineWidth', 1.1); 
    set(gca, 'FontSize', 12, 'FontName', 'Times New Roman');
    title('Signal with Noise');
    
    subplot(length(SNRs), 4, (row-1)*4 + 2);
    plot(window_times, variances, 'LineWidth', 0.8);set(gca, 'LineWidth', 1.1); 
    xlim([0 1]);
    set(gca, 'FontSize', 12, 'FontName', 'Times New Roman');
    title('First 1s STV Signal');
    
    subplot(length(SNRs), 4, (row-1)*4 + 3);
    plot(frequencies(1:N/2), signal_spectrum, 'LineWidth', 0.8);set(gca, 'LineWidth', 1.1); 
    xlim([0 400]);
    ylim([0 0.3])
    set(gca, 'FontSize', 12, 'FontName', 'Times New Roman');
    title('STV Spectrum');
    
    subplot(length(SNRs), 4, (row-1)*4 + 4);
    plot(frequencies2(1:half_N2), es(1:half_N2), 'LineWidth', 0.8);set(gca, 'LineWidth', 1.1); 
    xlim([0 400]);
    title('Envolope Spectrum');
    set(gca, 'FontSize', 12, 'FontName', 'Times New Roman');
end
