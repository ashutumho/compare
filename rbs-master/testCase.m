sample = input('Enter number of samples = ');
channel = input('Enter number of channels = ');
band = input('Enter band [0 1] = ');
uData = rand(sample,channel);
test = idfilt(uData,8,band);
save('RBS','test','uData','band','channel')