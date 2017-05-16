// ARX model parameter estimation
// Computes Covariance matrix
// Computes Noisevariance of a process
// Updated(28-9-16)

function [thetaN,covt,nvar,res] = arx(data,na,nb,nk)

[lhs,rhs] = argn();

if ( rhs < 4 ) then
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

n = [na nb nk]
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
// thetaN = inv(m1)*m2;
// thetaN = m1\m2;

[r1,c1] = size(thetaN);
a = thetaN(1:na); b = thetaN(na+1:r1);

// Sum of squared residuals
yhat = phit'*thetaN;
res = zd(:,1) - yhat;
N = length(res);
q = rank(phit);
ssr = res'*res;
sig2 = ssr/(N-q);
nvar = sqrt(sig2);
covn = inv(m1);
covt = diag(covn);

a = thetaN(1:na); b = [repmat(0,nk,1); thetaN(na+1:r1)]; 
cova = covt(1:na); covb = covt(na+1:r1); 
x = poly(0,'x');
disp('Discrete time model: A(x)y(t) = B(x)u(t) + e(t)');

cov_b1 = abs(covb')
cov_a1 = abs(cova')

bpol = poly([repmat(0,nk,1);thetaN(1+na:na+nb)]',"q","coeff");
apol = poly([1; thetaN(1:na)]',"q","coeff");
bCov = poly([repmat(0,nk,1);cov_b1']',"q","coeff");
aCov = poly([cov_a1]',"q","coeff");
p = struct('B',bpol,'F',apol);
pCov = struct('Bcov',bCov,'Acov',aCov);
thetaN = struct("value",p,"covariance",pCov);
    bstr = []
    for ii = nk+1:length(b)
         if ii > nk+1 & b(ii) > 0 then
            bstr = bstr + "+ "
         end
         bstr = bstr + string(b(ii))+" (+-"+string(cov_b1(ii-nk)) +")*q^" + string(ii-1)
         bstr = bstr + "  "
    end
    disp('B(q) = ');
    disp(bstr)
    if a(1) < 0 then
        astr = "1 "
    else
        astr = "1 +"
    end
    for ii = 1:length(a)
         if ii > 1 & a(ii) > 0 then
            astr = astr + "+ "
         end
         astr = astr + string(a(ii))+" (+-"+string(cov_a1(ii)) +")*q^" + string(ii)
         astr = astr + "  "
    end
    disp('A(q) = ');
    disp(astr)

endfunction;

