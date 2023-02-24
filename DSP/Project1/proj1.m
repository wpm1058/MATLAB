clear all; %Clear all variable in memory
Trep=1e-6; %Define the time interval that will make singals look continuous
t1=0:Trep:.01; %Define a vector representing time
f_tone1=1000; %frequency for tone 1
xt=cos(2*pi*f_tone1*t1); %will show xt for 0 to .01 continuous

signal1_sp=fft(signal1); %fast fourier transform
signal1_sp_sf=fftshift(signal1_sp)
%Comments for comprehension: fft will calculate the FT with the
%frequencies bein in the range of -1/2 trep to 1.2 trep 
%fft treats trep as the sampling period 
%to obtain a vector of frequencies we can use to plot the spectrum use the following command
f_axis=linspace(-1/Trep/2,1/Trep/2,length(signal1_sp)); %this will be the x axis
%next plot the signal using plot
plot(f_axis,abs(signal1_sp_sf));

