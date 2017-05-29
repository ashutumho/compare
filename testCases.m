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
% without zero initial conditions
[yOE x0OE] = predict(oeModel,data);
[yBJ x0BJ] = predict(bjModel,data);
% with zero initial conditions
% [yOE0 x0OE0] = predict(oeModel,data,opt);
% [yBJ0 x0BJ0] = predict(bjModel,data,opt);
% % without zero initial conditions five step ahead predictor
% [yOE5 x0OE] = predict(oeModel,data,5);
% [yBJ5 x0BJ] = predict(bjModel,data,5);
% % with zero initial conditions
% [yOE05 x0OE0] = predict(oeModel,data,5,opt);
% [yBJ05 x0BJ0] = predict(bjModel,data,5,opt);