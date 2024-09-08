clc; close all; clear all; 
sig = load('Ex3.mat');
C_leg_movement = zeros(30,30);
C_mind_subtract = zeros(30,30); 
for i=1:165
    if sig.TrainLabel(i) == 1 %For Accessing the label of training data
        C_primary = sig.TrainData(:,:,i) * transpose(sig.TrainData(:,:,i));
        C_leg_movement = C_primary + C_leg_movement;
    elseif sig.TrainLabel(i) == 0 
        C_primary2 = sig.TrainData(:,:,i) * transpose(sig.TrainData(:,:,i));
        C_mind_subtract = C_primary2 + C_mind_subtract;
    end
end
[W,landa] = eig(C_leg_movement,C_mind_subtract);
W_CSP = [W(:,1) W(:,30)]; 
%W_CSP = [W(:,1) W(:,2) W(:,3) W(:,28) W(:,29) W(:,30)];   %Spatial Filters according to first and last GEVD Vector
Y_TrainData = zeros(2,256,165);
for i=1:165
    Y_TrainData(:,:,i) = transpose(W_CSP) * sig.TrainData(:,:,i); % Exerting Spatial Filters on Training Data
end
 Os = Y_TrainData(:,:,15);
 offset = max(abs(Os(:)));
 feq = 256;
 ElecName = ['Top CSP Filter' , 'Bottom CSP Filter'];
 titre = 'CSP Filtered Signal';
 disp_eeg(Y_TrainData(:,:,15),offset,feq,ElecName,titre);