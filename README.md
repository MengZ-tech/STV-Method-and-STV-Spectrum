# STV-Method-and-STV-Spectrum
STV (Short-time variance) Method and STV Spectrum for Discovering Impulse Components in Rotating Machinery Vibration Signal

The Short-Time Variance (STV) method calculates the changes in data dispersion within a signal using a sliding step approach. In the presence of a fault in rotating machinery, there are abnormal impulse events in the vibration signal triggered by the fault. These transient sparse impulses will cause an increase in local dispersion, which is reflected in the STV signal.

The discrete Fourier transform of the STV signal produces the STV spectrum. In this case, the STV spectrum is compared with the classic envelope spectrum. A set of bearing vibration signals with inner race faults (from the CWRU dataset) were superimposed with noise at different SNRs, and spectrograms were generated using both methods. The comparison criterion was whether the spectral line at 161.8 Hz (fault frequency) could be observed.

The comparison results indicate that the STV spectrum not only has similar functionality to the envelope spectrum but also performs better in high noise environments.

For using this method please cite my accepted work as: Meng Zhang, Short-Time Variance Providing Evidential Reference Frequency for Lock-In Amplifier in Fault Diagnosis of Rolling Bearings, Journal of Vibration Engineering & Technologies, 2024.
