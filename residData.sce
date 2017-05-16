getd('/home/ashutosh/Desktop/compare/')
exec compare.sci
exec compareDataOE.sce
[a b c] = compare(data,oeModel);
yy = a.OutputData;
errorData = yy-data(:,1);
crossResid = xcorr(errorData);
crossResid = crossResid/abs(max(crossResid));
[a,b]=max(crossResid);
//plot2d3(crossResid(b+1:b+25))
//------------------------------------------------------------------------------
euCrossCorr = xcorr(errorData,data(:,2),25,'biased');
