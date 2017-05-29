loadmatfile('data3.mat')
z = [data(:,1) data(:,2)];
 a = 1
 b = [0 0.5721 -0.5742]
 c = 1
 d = 1
 f = [1 -1.3960 0.4014]
 oeModel = idpoly(a,b,c,d,f,1)
 a = 1
 b = [0 0.6224 -0.6235]
 c = [1 0.3991 0.0195]
 d = [1 -0.5210 -0.3558]
 f = [1 -1.3586 0.3626]
 bjModel = idpoly(a,b,c,d,f,1)
 figure;resid(data,oeModel)
 figure;resid(data,bjModel)
