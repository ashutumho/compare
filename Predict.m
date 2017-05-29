close all,clear all
load('data3.mat')
nb = 2;
nf = 2;
nk = 1;
oeModel = oe(data,[nb nf nk]);
nb = 2;
nc = 2;
nd = 2;
nf = 2;
nk = 1;
bjModel = bj(data,[nb nc nd nf nk]);
opt = predictOptions('InitialCondition','z');
[yOE,x0] = pe(data,oeModel);
[yBJ,x0] = pe(data,bjModel);

rBJ = xcorr(yBJ,25,'coeff');
%original resid plot
figure;resid(oeModel,data)
% figure;resid(bjModel)
%resid for oe model with non zero initial conditions
rOE = xcorr(yOE,25,'coeff');
[A,I] = max(rOE);
rOE = rOE(I:length(rOE));
xcor = xcorr(yOE,data(:,2),25,'coeff');
figure;
subplot(2,1,1),stem(rOE)
subplot(2,1,2),stem(-25:25,xcor)

%resid for oe model with zero initial conditions
[yOE,x0] = pe(data,oeModel,opt);
rOE = xcorr(yOE,25,'coeff');
[A,I] = max(rOE);
rOE = rOE(I:length(rOE));
xcor = xcorr(yOE,data(:,2),25,'coeff');
figure;
subplot(2,1,1),stem(rOE)
subplot(2,1,2),stem(-25:25,xcor)
%for bj models
figure;resid(bjModel,data)

%resid for bj model with non zero initial conditions
rBJ = xcorr(yBJ,25,'coeff');
[A,I] = max(rBJ);
rBJ = rBJ(I:length(rBJ));
xcor = xcorr(yBJ,data(:,2),25,'coeff');
figure;
subplot(2,1,1),stem(rBJ)
subplot(2,1,2),stem(-25:25,xcor)

%resid for bj model with zero initial conditions
[yBJ,x0] = pe(data,bjModel,opt);
rBJ = xcorr(yBJ,25,'coeff');
[A,I] = max(rBJ);
rBJ = rBJ(I:length(rBJ));
xcor = xcorr(yBJ,data(:,2),25,'coeff');
figure;
subplot(2,1,1),stem(rBJ)
subplot(2,1,2),stem(-25:25,xcor)

