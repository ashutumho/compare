loadmatfile('RBS.mat')
testSci = filt(uData,band,channel)
disp(testSci)
disp(test-testSci)
