
loadmatfile('data.mat')
z = [data(:,1) data(:,2)];
A = 1
B = [0 0 0 2.6509 -2.0596];//[0 0 0 2.3057 -1.2170];
C = 1;
D = 1;
F = [1 -0.9448 0.5055];//[1 -1.1887 0.6424];
oeModel = idpoly(A,B,C,D,F,1)


              a = 1
              b = [0 1.3366 -0.3598]
              c = [1 0.2959 0.0126]
              d = [1 -0.6273 -0.2661]
              f = [1 -1.2992 0.7834]
        bjModel = idpoly(a,b,c,d,f,1)

loadmatfile('arxData.mat')
                 a = [1 -1.1884 0.4196]
                 b = [0 0.8726 0.8444]
                 c = 1
                 d = 1
                 f = 1
                 arxModel = idpoly(a,b,c,d,f,0.1)

//          aPoly = poly(oeModel.a,'q','coeff');
//          bPoly = poly(oeModel.b,'q','coeff');
//          cPoly = poly(oeModel.c,'q','coeff');
//          dPoly = poly(oeModel.d,'q','coeff');
//          fPoly = poly(oeModel.f,'q','coeff');
//             qG = bPoly/(aPoly*fPoly);
//             qH = cPoly/(aPoly*dPoly);
//        invqHqG = qG/qH;
//         invqH1 = 1-1/qH; 
////------------------------------------------------------------------------------
//         uCoeff = invqHqG.num*invqH1.den;
//         yCoeff = invqHqG.den*invqH1.num;
//      yCapCoeff = invqHqG.den*invqH1.den;
////--------------------------------------------------------------------------------
//   lengthuCoeff = length(coeff(uCoeff));
//   lengthyCoeff = length(coeff(yCoeff));
//lengthyCapCoeff = length(coeff(yCapCoeff));
////------------------------------------------------------------------------------
//         uCoeff = coeff(uCoeff);
//         yCoeff = coeff(yCoeff);
//      yCapCoeff = coeff(yCapCoeff);
//      yCapCoeff = -yCapCoeff(2:lengthyCapCoeff);
////------------------------------------------------------------------------------
////initial conditions
//          uData = zeros(lengthuCoeff,1);
//          yData = zeros(lengthyCoeff,1);
//       yCapData = zeros(lengthyCapCoeff-1,1);
//          uData = [uData;data(:,2)];
//          yData = [yData;data(:,1)];
//          
////------------------------------------------------------------------------------
//sampleData = size(data,'r');
//uCoeff = uCoeff(lengthuCoeff:-1:1);
//yCoeff = yCoeff(lengthyCoeff:-1:1);
//yCapCoeff = yCapCoeff(lengthyCapCoeff-1:-1:1);
//for ii = 1:sampleData+1
//     //pause
//     tempu = uCoeff*uData(ii:ii+lengthuCoeff-1);
//     tempy = yCoeff*yData(ii:ii+lengthyCoeff-1);
//     tempyCap = yCapCoeff*yCapData(ii:ii+lengthyCapCoeff-2);
//     yCapData = [yCapData;tempu+tempy+tempyCap];
//     //pause
//end
//
