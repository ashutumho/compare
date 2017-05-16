clear;
close all;
clc

uData = idinput(2000,'rbs',[0 0.1],[-1 1]);
uData = [(0:1999)' uData(:)];
s = tf('s');
sysc = 1/(s+1);%1/(s^2+s+1);%(s^2+3*s+2)/(s^3+2*s^2+s+1);
sysd = c2d(sysc,1);
sysd.Variable = 'z^-1';
num = cell2mat(sysd.num);
den = cell2mat(sysd.den);
Ts = sysd.Ts;
R = input('Now execute  and hit the return key ');
plantData = iddata(yData.Data,uData(:,2),Ts);
figure(1)
nb = 2;
nf = 2;
nk = 1;
oeModel = oe(plantData,[nb nf nk]);
opt = compareOptions('InitialCondition','z');
compare(oeModel,plantData,opt)
YData = yData.Data;
UData = uData(:,2);
% T = table(YData,UData);
%filename = 'oeModel.xlsx';
%writetable(T,filename,'Sheet',1)
figure(2)
nb = 2;
nc = 2;
nd = 2;
nf = 2;
nk = 1;
bjModel = bj(plantData,[nb nc nd nf nk]);
compare(bjModel,plantData,opt)

data = [plantData.OutputData plantData.InputData];
save('data3','data');
% bOE = oeModel.b;
% fOE = oeModel.f;
% save('oeCoeff','bOE','fOE')
% bBJ = bjModel.b;
% cBJ = bjModel.c;
% dBJ = bjModel.d;
% fBJ = bjModel.f;
% save('bjCoeff','bBJ','cBJ','dBJ','fBJ');
%opt = residOptions('InitialCondition','z');

figure(3)
resid(data,oeModel)
figure(4)
resid(data,bjModel)