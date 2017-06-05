// ARX model parameter estimation
// Computes Covariance matrix
// Computes Noisevariance of a process
//
// Authors: 
//        Inderpreet Arora
//        Ashutosh Kumar

function [sys] = arx(varargin)

[lhs,rhs] = argn();
data = varargin(1)
if ( rhs < 2 ) then
		errmsg = msprintf(gettext("%s: Unexpected number of input arguments : %d provided while should be 4"), "arx", rhs);
		error(errmsg)
end

if ((~size(data,2)==2) & (~size(data,1)==2)) then
	errmsg = msprintf(gettext("%s: input and output data matrix should be of size (number of data)*2"), "arx");
	error(errmsg);
end

if (~isreal(data)) then
	errmsg = msprintf(gettext("%s: input and output data matrix should be a real matrix"), "arx");
	error(errmsg);
end

n = varargin(2)
//pause
na = n(1);nb = n(2);nk = n(3)
if (size(find(n<0),"*") | size(find(((n-floor(n))<%eps)== %f))) then
	errmsg = msprintf(gettext("%s: values of order and delay matrix [na nb nk] should be nonnegative integer number "), "arx");
	error(errmsg);
end

    az = max(na,nb+nk-1);
    zer = zeros(az,1);
    zd = data;
    // Zeros appended
    zd1(:,1) = [zer; zd(:,1)];
    zd1(:,2) = [zer; zd(:,2)];
    [r,c] = size(zd1);
    t = az+1:r;
    yt = zd1(:,1); ut = zd1(:,2);
    yt1 = yt'; ut1 = ut'; // row vector
    len1 = length(yt1);
    yt2 = zeros(1,len1-az); ut2 = zeros(1,len1-az);
    
    // arx(Data,[na nb nk]) 
    for i=1:na
        yt2 = [yt2; -yt1(t-i)];
    end;
    for i=nk:nb+nk-1
        ut2 = [ut2; ut1(t-i)];
    end;
    [r1_a,c1_a] = size(yt2); [r2_a,c2_a] = size(ut2);
    phit = [yt2(2:r1_a,:); ut2(2:r2_a,:)];
    m1 = phit*phit';
    [qm,rm] = qr(m1);
    m2 = phit*zd(:,1);
    thetaN = inv(rm)*qm'*m2;
    [r1,c1] = size(thetaN);
    a = thetaN(1:na); b = thetaN(na+1:r1);

    bpol = poly([repmat(0,nk,1);thetaN(1+na:na+nb)]',"q","coeff");
    apol = poly([1; thetaN(1:na)]',"q","coeff");

    sys = idpoly(coeff(apol),coeff(bpol),1,1,1,1)

endfunction;
