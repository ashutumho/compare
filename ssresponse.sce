A = [   1.396  -0.8027
   0.5     0.  ]
B = [   1.
   0.];
C = [0.5721  -1.1484];
z = poly(0,'z')
x0 = [  -34.7671
  -17.8037];
  //x0 = zeros(2,1)
// loading the data file
    loadmatfile('data3.mat')
    
    sys = syslin(1,A,B,C,0)
    [y yy] = flts(data(:,2)',sys,x0)
//    nos = length(data(:,1))
//    x_1 = A*x0
//    y_1 = C*x0
//    for ii = 1 : nos
//        //disp(A*x_1(ii))
//        //disp(B*data(ii,2))
//        //pause
//        //disp(ii)
//        x_1 = [x_1 A*x_1(:,ii)+B*data(ii,2)]
//        y_1 = [y_1 C*x_1(:,ii)]
//    end
//    disp(y_1(1:5)')

//t =0 
//x1 = A*x0
//y1 = C*x0
////disp(x1)
//disp(y1)
////t = 1
//x2 = A*x1+B*data(1,2)
//y2 = C*x1
////disp(x2)
//disp(y2)
//disp(y1+y2)
//// t= 2
//x3 = A*x2+B*data(2,2)
//y2 = C*x2
//disp(y2)
////t=3
//x4 = A*x3+B*data(3,2)
//y3 = C*x3
//disp(y3)
