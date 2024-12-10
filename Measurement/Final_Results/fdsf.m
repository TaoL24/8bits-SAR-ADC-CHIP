% Used for calculating ENOB for ADC
clc;
clear;
% Load data file
filename = '1205.csv';
table = csvread(filename, 1, 0);  % Read data from the file, skipping the first row (header)
% Extract data
x = table(:, 1);  % The first column is time
A = table;
B = size(A, 2);  % Determine the number of columns
vout = [A(:, 1) A(:, B)];  % Assume the signal is in the last column
% Set sampling parameters
fs = 6.25e6;  % Sampling frequency
Ts = 1 / fs;  % Sampling period
%Ts = 2.8e-8;
%fs = 1 / Ts;
N = length(vout);  % Signal length (number of samples)
t = 0:Ts:(N-1)*Ts;  % Time vector
% Compute spectrum
vout_signal = vout(:, 2);  % Extract the signal data from the second column (analog signal)
vout_signal = vout_signal - mean(vout_signal);
vof = abs(fft(vout_signal, N)) / N;  % Normalized spectrum
vof = vof / max(vof);  % Normalize to maximum amplitude
vof_db = db(vof);  % Convert to dB
% Compute signal peak
vofh = vof(1:N/2);  % Use only the first half (positive frequency part)
[vs, is] = max(vofh(1:N/2));  % Peak frequency
Ps = sum(vofh.^2);  % Signal power (using the power of the entire spectrum)
% Compute harmonic power (Phar)
Phar = sum(vofh(2:is-1).^2) + sum(vofh(is+1:N/2).^2);  % Harmonic power
% Compute noise power (Pnoise)
noise_value = -60;  % Set noise threshold (dB)
Pnoise = sum(vofh(db(vofh) < noise_value).^2);  % Find noise components below the threshold
% Compute SQNR, SNDR, SINAD, ENOB
SQNR = 10 * log10(Ps / Pnoise);  % Signal-to-noise power ratio
SNDR = 10 * log10(Ps / Phar);  % Signal-to-noise-and-distortion ratio
SINAD = 10 * log10(Ps / (Pnoise + Phar));  % Signal-to-noise-and-distortion including harmonics
ENOB = (SINAD - 1.76) / 6.02;  % Calculate ENOB
% Output results
disp(['SQNR = ', num2str(SQNR), ' dB']);
disp(['SNDR = ', num2str(SNDR), ' dB']);
disp(['SINAD = ', num2str(SINAD), ' dB']);
disp(['ENOB = ', num2str(ENOB), ' bits']);
% Plot the spectrum
freq = fs/N:fs/N:(fs/2-fs/N);  % Frequency vector

figure;
plot(freq * 1e-3, vof_db(2:N/2), 'b-');  % Plot the spectrum (dB)
title('FFT of ADC Output');
xlabel('Frequency (MHz)');
ylabel('Magnitude (dB)');
grid on;

% Add annotation in the top-right corner
annotation_text = {
    ['SQNR = ', num2str(SQNR, '%.2f'), ' dB'];
    ['SNDR = ', num2str(SNDR, '%.2f'), ' dB'];
    ['SINAD = ', num2str(SINAD, '%.2f'), ' dB'];
    ['ENOB = ', num2str(ENOB, '%.2f'), ' bits']
};
text(0.8 * max(freq) * 1e-3, max(vof_db(2:N/2)) - 5, annotation_text, ...
    'HorizontalAlignment', 'right', 'VerticalAlignment', 'top', 'FontSize', 10, 'BackgroundColor', 'w', 'EdgeColor','k');