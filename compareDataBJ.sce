
loadmatfile('data.mat')
z = [data(:,1) data(:,2)];
a = 1;
b = [0 0.3969 0.6848];
c = [1 0.2917 0.0840];
d = [1 -0.6917 -0.1866];
f = [1 -1.3438 0.7749];
bjModel = idpoly(a,b,c,d,f,1)
compare(z,bjModel)
