C = {1:10, [2; 4; 6], []};
temp = []
for ii = 1:length(C)
    temp = [temp,mean(C{ii})]
end
disp(temp)
