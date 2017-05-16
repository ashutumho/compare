close all; clc
load data
Ts = 1;
plantData = iddata(data(:,1),data(:,2),Ts);
figure(1)
nb = 2;
nf = 2;
nk = 3;
oeModel = oe(plantData,[nb nf nk]);
opt = compareOptions('InitialCondition','z');
%compare(oeModel,plantData,opt)
%YData = data(:,1);%yData.Data;
%UData = data(:,2);
%T = table(YData,UData);
%filename = 'oeModel.xlsx';
%writetable(T,filename,'Sheet',1)
% figure(2)
nb = 2;
nc = 2;
nd = 2;
nf = 2;
nk = 1;
bjModel = bj(plantData,[nb nc nd nf nk]);
% compare(bjModel,plantData,opt)
% 
% figure(3)
optpe = peOptions('InitialCondition','z');
[y x0] = predict(bjModel,data);
% predict(bjModel,data,2,optpe)
% 
% figure(4)
% pe(bjModel,data,optpe)
% figure(2)
% resid(data,bjModel)

% figure(3)
% [y,fit,x0] = compare(data,oeModel);
% error = data(:,1)-y;
% plot(error)
%autocorr(error,[],0)
