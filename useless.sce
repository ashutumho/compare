//C = {1:10, [2; 4; 6], []};
//temp = []
//for ii = 1:length(C)
//    temp = [temp,mean(C{ii})]
//end
//disp(temp)

days = {'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'};
abbrev= cell()
for ii = 1:length(days)
    temp = days{ii}
    temp=(strsplit(temp,3))
    abbrev{ii} = temp(1)
end
disp(abbrev{:})
disp(typeof(abbrev))
