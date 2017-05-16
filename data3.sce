loadmatfile('data3.mat')
z = [data(:,1) data(:,2)];
                 a = 1
                 b = [0 0.5721 -0.5742]
                 c = 1
                 d = 1
                 f = [1 -1.3960 0.4014]
                 oeModel3 = idpoly(a,b,c,d,f,1)
