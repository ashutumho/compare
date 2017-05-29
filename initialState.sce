loadmatfile('data.mat')
z = [data(:,1) data(:,2)];
A = 1
B = [0 0 0 2.6509 -2.0596];//[0 0 0 2.3057 -1.2170];
C = 1;
D = 1;
F = [1 -0.9448 0.5055];//[1 -1.1887 0.6424];
oeModel = idpoly(A,B,C,D,F,1)
[y1,x0] = pe(data,bjModel);
obMat = [];
//http://www.icm.tu-bs.de/NICONET/doc/IB01RD.html
A = [1.2992   -0.7834         0         0;
    1.0000         0         0         0;
         0         0    0.6273    0.5321;
         0         0    0.5000         0];
B = [1;0;0;0];

C = [1.3366   -0.3598    0.9232    0.5572] 
D = 0
//S=10;
//[R,N1,SVAL] = findR(S,data(:,1),data(:,2));
//N=N1+1;
//SYS1 = findABCD(S,N,1,R) ;SYS1.dt=1;
//A = SYS1.a
//C = SYS1.c
noSample = size(data(:,1),'r')
//disp(noSample)
for ii = 0:noSample-1
    obMat = [obMat;C*A^ii]
end
obMat = clean(obMat,0.00001);
[y x0] = pe(data,bjModel)
xo = obMat\y
//bMat = [z(1,1)]
//tempMat = []
//
//for ii = 2:noSample
//
//    for jj = ii-1:-1:1
//        //disp(jj)
//        aa = C*A^(jj-1)*B
//        tempMat = [tempMat aa]
//    end
//
////    pause
//    bMat = [bMat;tempMat*data(1:ii-1,2)]
////    disp(ii)
////    disp(tempMat)
////    disp(bMat)
////    pause
//    tempMat = []
//end
//y2 = data(:,1)-bMat
////disp(bMat)
////x0 = umfpack(obMat,"\",y2)
//x0 = obMat\y2
//
