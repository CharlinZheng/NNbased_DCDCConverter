clear all; close all; clc; format compact; 

filename = 'error20k_load.xlsx';
a = xlsread(filename)
a_series=a'                                         % 500행 입력을 1행 500열로 sequential로 전치한다.       
filename = 'duty20k_load.xlsx';
b = xlsread(filename)
b_series=b'
inputs=a_series;                                  % in case of voltage mode control, single input should be applied into the network
outputs=b_series;

net=network( ...
    1,            ...                                   % numInputs, number of element in input vector
    2,            ...                                   % numLayers, number of layers
    [1;0],        ...                                   % biasConnect, numLayers-by-1 Boolean vector
    [1; 0],        ...                                  % inputConnect, numLayers-by-numInputs Boolean matrix
    [0 0; 1 0],  ...                                   % layerConnect, numLayers-by-numLayers Boolean matrix
    [0 1]        ...                                   % outputConnect, 1-by-numLayers Boolean vector
    );
 %number of hidden layer(1st layer) neurons
 net.layers{1}.size=5;
 %hidden layer transfer function
 net.layers{1}.transferFcn='logsig';
 %configure network
 net=configure(net,inputs,outputs);
 view(net);
 %network training
 net.trainFcn='trainlm';                         % trainlm : training by levenberg-marquardt back-propagation algorithm
 net.performFcn='mse';                        % mean-square error
 net=train(net,inputs,outputs);
 gensim(net)                                     % generate automatically to SIMULINK model 
 
 
 