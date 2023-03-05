clear all; %Clear all variable in memory
Trep=1e-6; %Define the time interval that will make singals look continuous
t1=0:Trep:.01; %Define a vector representing time
f_tone1=1000; %frequency for tone 1
smpf = 3000;
A=1e-3;
raiseindex=max(find(t1<A));
decayindex=max(find(t1<2*A));
xt=zeros(size(t1)); %will show xt for 0 to .01 continuous
xt(1:raiseindex)=t1(1:raiseindex)/A;
xt(raiseindex+1:decayindex)=1-t1(1:raiseindex)/A;
xjw=fft(xt); %fast fourier transform
xjw = fftshift(xjw);
f_axis=linspace(-1/Trep/2,1/Trep/2,length(xjw)); %this will be the x axis

tiledlayout(3,2);
%%
%Part 1 Plot the continuous time signal
nexttile
plot(t1,xt);
title("Cont. Time Signal");
ylabel("x(t)");
xlabel("t");

%%
%Part 2 Calculate and Plot the Fourier Transform
nexttile
plot(f_axis,abs(xjw));
title("x(j\omega)");
ylabel("x(j\omega)");
xlabel("\omega");
xlim([-4000 4000]);

%%
%Part 3 Sample x(t) using p(t)
pt = zeros(size(t1));
pt(1:floor(1/smpf/Trep):end)=1;
xst = xt .* pt;
nexttile
plot(t1,xst);
title("Cont. Time Signal Sample");
ylabel("xs(t)");
xlabel("t");

%%
%Part 4 Calculate and Plot Xs(jw) from xs(t)
xsjw = fftshift(fft(xst));
nexttile
plot(f_axis,abs(xsjw));
title("xs(j\omega)");
ylabel("xs(j\omega)");
xlabel("\omega");
xlim([-4000 4000]);

%%
%Part 5 Ideally filter xst with lowpass filter.
fil = zeros(size(f_axis));
range = ((size(f_axis)-1)/2 + smpf/2)/2;
fil(abs(f_axis)<(smpf/2)) = 1/smpf;
xrjw = xsjw .* fil;
xrjw(find(abs(xrjw)<max(xrjw)/5))=0;
scaleo = max(xjw)/max(xrjw)*xrjw;
nexttile
plot(f_axis,abs(scaleo));
title("xr(j\omega)");
ylabel("xr(j\omega)");
xlabel("\omega");
xlim([-4000 4000]);

%%
%Part 6 Reconstruct the Signal from the filtered signal
xrt = ifft(ifftshift(scaleo));
nexttile
plot(t1,real(xrt));
title("Reconsstructed Cont. Time Signal");
ylabel("xr(t)");
xlabel("t");