function y = denoiseEm(x);
% y = denoiseEm(x);
% method to denoise a given signal using wavelets
% x is the input Matlab sound file

%THR is the threshold, SORH is for soft or hard thresholding, KEEPAPP allows you to keep 
%approximation coefficients
[thr,sorh,keepapp]=ddencmp( 'den' , 'wv' ,x);  

% returns a de-noised version xc of input signal x (our one-dimensional speech signal) 
%obtained by wavelet coefficients thresholding using global positive threshold THR
%PERF0 and PERFL2 are L2-norm recovery and compression score in percentage.
[y, cxc, lxc, perf0, perfl2]=wdencmp( 'gbl' ,x, 'db3' ,2,thr,sorh,keepapp);  