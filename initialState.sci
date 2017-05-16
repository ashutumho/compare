function varargout = initialState(varargin)
    tempData = varargin(1)
    sysData = varargin(2)
    yData = tempData(:,1)
    uData = tempData(:,2)
    if typeof(sysData) == 'rational' then
        sysData = tf2ss(sysData)
    end
    // finding the observability  of the system
    obvs = obsv_mat(sysData)
    Rank = rank(obvs)
    if size(obvs,'r') ~= Rank then
        error(msprintf(gettext("%s:System is not observable.\n"),"initialState"))
    end
    disp(obvs)
    //pause
    yDataTemp = yData(1:Rank)
    uDataTemp = uData(1:Rank)
    b = []
    for ii = 1:Rank
         b(ii,1) = yDataTemp(ii,1)
    end
    disp(b)
    varargout(1) = 1
endfunction
