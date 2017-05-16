function resid(varargin)
    [lhs rhs] = argn(0)
    //Checking the number of inputs
    if rhs <> 2 then
        error(msprintf(gettext("%s:Wrong number of input arguments.\n"),"resid"))
    end
    //Checking the type of first argument
    if typeof(varargin(1)) <> 'constant' && typeof(varargin(1)) == 'iddata' then
        error(msprintf(gettext("%s:Incompatible model data.\n"),"resid"))
    end
    //checking the type of second argument
    if typeof(varargin(2)) <> 'idpoly' then
        error(msprintf(gettext("%s:Wrong type for second argument,""idpoly"" type expected.\n"),"resid"))
    end
    //checking the input dimensions
    yData = []
    uData = []
    tempData = varargin(1)
    if typeof(varargin(1)) == 'iddata' then
        yData = tempData.OutputData
        uData = tempData.InputData
        if ~size(yData,'*') || ~size(uData,'*') then
            error(msprintf(gettext("%s:Model input and output numbers must be equal to the plant data.\n"),"resid"))
        end
    elseif typeof(varargin(1)) == 'constant'then
        if isrow(tempData) || iscolumn(tempData) || length(size(tempData)) <> 2 || size(tempData,'c') <> 2 then
            error(msprintf(gettext("%s:Model input and output numbers must be equal to the plant data.\n"),"resid"))
        end
        yData = tempData(:,1)
        uData = tempData(:,2)
        tempData = iddata(yData,uData,varargin(2).Ts)
    end
    
    //[a,b,c] = compare(tempData,varargin(2))
    [a,x0] = pe(tempData,varargin(2))
//------------------------------------------------------------------------------
    errorData = a
    eAutoCorr = xcorr(errorData,25,'biased')
    uAutoCorr = xcorr(uData,25,'biased')
    eAutoCorrMax = max(eAutoCorr)
    eAutoCorr = eAutoCorr/eAutoCorrMax
//------------------------------------------------------------------------------
    
    //confidence interval
    coi1 = 2.58/sqrt(length(yData))
    rect = [0;coi1;25;2*coi1];
    //disp(rect)
    subplot(2,1,1);
    xrects(rect,7)
    stem([0:25]',eAutoCorr(26:length(eAutoCorr)),5)
    xrect(rect)
    coi2 = 2.58*sqrt(eAutoCorrMax+2*(eAutoCorr(27:50)'*uAutoCorr(27:50)*eAutoCorrMax))/sqrt(length(yData))
    rect = [-25;coi2;50;2*coi2];
    euCrossCorr = xcorr(errorData,uData,25,'biased')
    //pause
    xtitle('Autocorrelation of Residuals','lag')
    subplot(2,1,2);
    xrects(rect,7)
    //disp(rect)
    stem([-25:25]',euCrossCorr,5)
    xrect(rect)
    xtitle('Crosscorrelation of Residuals and Input','lag')
    //figure
    //plot2d3(euCrossCorr)
endfunction
