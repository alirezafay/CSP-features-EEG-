clc; close all; clear all; 
sig = load('Ex3.mat');
E = load('AllElectrodes_main30_system.mat');
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
X = [57.5510633930990;49.8713779489202;30.9552849531915;3.86812533613566e-15;5.17649253748256e-15;-30.9552849531915;-59.9127302448179;-57.5510633930990;-54.0378881132511;-49.8713779489202;-76.1527667684845;-80.7840137690914;-60.7384809484625;-32.9278836352560;80.7840137690914;79.0255388591416;60.7384809484625;57.5840261068105;49.9265268118817;30.9552849531915;32.9278836352560;5.20474889637625e-15;3.86788221025119e-15;-30.9552849531915;-59.8744127660117;-57.5840261068105;-54.0263340465386;-49.9265268118817;-76.1527667684845;-80.7840137690914];
Y = [48.2004273175388;68.4233350269540;59.2749781760892;63.1712807125907;84.5385386396573;59.2749781760892;26.0420933899754;48.2004273175389;63.0582218645482;68.4233350269539;31.4827967984807;26.1330144040702;-7.43831862786072e-15;-4.03250272966127e-15;-26.1330144040702;0;0;-48.1425964684523;-68.3835902976096;-59.2749781760892;0;0;-63.1673101655785;-59.2749781760892;-26.0254380421476;-48.1425964684523;-63.0447391225751;-68.3835902976096;-31.4827967984807;-26.1330144040702];
Labels = {'F3';'F7';'FC3';'C3';'T7';'CP3';'P1';'P3';'P5';'P7';'PO3';'O1';'Pz';'CPz';'Fp2';'AFz';'Fz';'F4';'F8';'FC4';'FCz';'Cz';'C4';'CP4';'P2';'P4';'P6';'P8';'PO4';'O2'};
 plottopomap(X,Y,Labels,W(:,30));