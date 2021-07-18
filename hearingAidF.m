function y = hearingAidF(input,g,Psat,transitionV,newfile);
% y = hearingAidF(input,g,Psat,transitionV,newfile)
% Combines the filters of our digital hearing aid system.
% Returns a Matlab sound file of filtered signal.
% input - the input signal to the system. Should be a wave file.
% g - the maximum gain that will be applied to the signal
% Psat - the cut off power.  The output power will not be higher than this
% transitionV - 4 element vector that has the values of where the gain changes
%               to the next piecewise function
% newfile - desired name for the output sound file.  It will be in .au format
[x,fs,nbits] = wavread(input);
xc = denoiseEm(x);                             % denoising filter
xf = applySkiSlope(xc,g,transitionV,fs);       % frequency shaping filter
y = powerCompress(xf, Psat,fs);                % amplitude shaping filter
x_length = length(x);
t=[0:1/fs:(x_length-1)/fs];


% plots the input and output signals

figure;
subplot(2,1,1);
plot(t,x,'b');
axis tight;
xlabel('Time (sec)');
ylabel('Relative Magnitude');
Title('Time Profile for Data in Signal 2');


subplot(2,1,2);
plot(t,y,'r');
axis tight;
xlabel('Time (sec)');
ylabel('Relative Magnitude');
Title('Time Profile for Data in Adjusted Signal 2');

figure;
subplot(2,1,1);
specgram(x);
title('Spectrogram of Original Signal 2');

subplot(2,1,2);
specgram(y);
title('Spectrogram of Adjusted Signal 2');


%soundsc(input, fs);
sound(y,fs);
auwrite(y,fs,nbits,'linear',newfile);