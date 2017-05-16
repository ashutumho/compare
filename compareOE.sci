function varargout = compareOE(varargin)
    //varargin(1) -> idpoly data about oe
    //varargin(2) -> [y u] matrix of "nx2" dimension
    oeData = varargin(1)
    plantData = varargin(2)
    yData = plantData(:,1)
    uData = plantData(:,2)
    //storing the coefficient
    coeffB = oeData.b
    coeffF = oeData.f
    delay = max(size(coeffB,'*'),size(coeffF,'*'))
    ySys = zeros(delay-1,1)
    tempFCoeff = coeffF(2:length(coeffF))
    for ii = delay:size(yData,'*')+1
        uCal = 0
        for jj=1:length(coeffB)
            if ii-jj <= 0 then
                uCal = uCal + 0
            else
                uCal = uCal + coeffB(jj)*uData(ii-jj)
            end
        end
        yCal = 0
        for jj=1:length(tempFCoeff)
            if ii-jj <= 0 then
                yCal = yCal + 0
            else
                yCal = yCal + tempFCoeff(jj)*ySys(ii-jj)
            end
        end
        ySys = [ySys;-yCal+uCal]
    end
    tempStart = 0
    if size(ySys,'r')-size(yData,'r')>0 then
        tempStart = size(ySys,'r')-size(yData,'r') + 1 
    end
    ySys = ySys(tempStart:length(ySys))
    varargout(1) = ySys
//    fit = fitValue(yData,ySys)
//    plant  = 'plant : ' + string(fit)+ '% fit'
//    plot(yData)
//    plot(ySys,'m')
//    legend(['sys',plant])
//    pause
//    disp(fit)
endfunction
