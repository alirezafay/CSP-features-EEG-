%X   32-channel data
load('Electrodes') ;

% Plot Data
% Use function disp_eeg(X,offset,feq,ElecName)
%offset = max(abs(X(:))) ;%max(abs(X(:))) ;
feq = 200 ;
ElecName = Electrodes.labels ;

[sig1,sig2] = getSignal(X_org,X_noise_3);
[sig3,sig4] = getSignal(X_org,X_noise_4);

offset = max(abs(sig1(:)));
disp_eeg(sig1,offset,feq,ElecName,['SNRdB = ' int2str(-10) ', Noise = X-noise-3']);
offset = max(abs(sig2(:)));
disp_eeg(sig2,offset,feq,ElecName,['SNRdB = ' int2str(-20) ', Noise = X-noise-3']);
offset = max(abs(sig3(:)));
disp_eeg(sig3,offset,feq,ElecName,['SNRdB = ' int2str(-10) ', Noise = X-noise-4']);
offset = max(abs(sig4(:)));
disp_eeg(sig4,offset,feq,ElecName,['SNRdB = ' int2str(-20) ', Noise = X-noise-4']);
offset = max(abs(X_org(:)));
disp_eeg(X_org,offset,feq,ElecName,'X-org');

