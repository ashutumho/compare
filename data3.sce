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
// zero initial condition
//[yOE0,x0OE0] = predict(data,oeModel);
//[yBJ0,x0BJ0] = predict(data,bjModel);
////5 step ahead predictor
//[yOE5,x0OE5] = predict(data,oeModel);
//[yBJ5,x0BJ5] = predict(data,bjModel);
//                 

num = [0.   0.6224  -0.9477704   0.1033936   0.2218413];
den = [1.  -0.9595  -0.1601173   0.118221   0.0070707];

