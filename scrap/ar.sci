// ARX model parameter estimation
// Computes Covariance matrix
// Computes Noisevariance of a process
//
// Authors: 
//        Inderpreet Arora
//        Ashutosh Kumar
function sys = ar(varargin)
    data = varargin(1)
    n = varargin(2)
    sizeData = size(data,'r')
    data = [data zeros(sizeData,1)]
    sys = arx(data,[n,0,0])
endfunction
