
function [theta_ar,opt_err,resid] =  ar(varargin)
//
	[lhs , rhs] = argn();	
	if ( rhs < 2 ) then
			errmsg = msprintf(gettext("%s: Unexpected number of input arguments : %d provided while should be 2"), "ar", rhs);
			error(errmsg)
	end

	z = varargin(1)
	if ~iscolumn(z) then
		errmsg = msprintf(gettext("%s: time series output data only"), "ar");
		error(errmsg);
	end

	if (~isreal(z)) then
		errmsg = msprintf(gettext("%s: input and output data matrix should be a real matrix"), "ar");
		error(errmsg);
	end

	n = varargin(2)
	if (size(n,"*") ~=1 )then
		errmsg = msprintf(gettext("%s: order should be nonnegative integer number "), "ar");
		error(errmsg);
	end

	if (size(find(n<0),"*") | size(find(((n-floor(n))<%eps)== %f))) then
		errmsg = msprintf(gettext("%s: values of order and delay matrix [na] should be nonnegative integer number "), "ar");
		error(errmsg);
	end

	na = n; nb = 0; nk = 0; 
    // storing U(k) , y(k) and n data in UDATA,YDATA and NDATA respectively 
    YDATA = z(:,1);
    UDATA = zeros(size(z,1),1)
    NDATA = size(UDATA,"*");
    function e = G(p,m)
        e = YDATA - _objfun(UDATA,YDATA,p,na,nb,nk);
    endfunction
    tempSum = na+nb
    p0 = linspace(0.1,0.9,tempSum)';
    [var,errl] = lsqrsolve(p0,G,size(UDATA,"*"));
    err = (norm(errl)^2);
    opt_err = err;
	resid = G(var,[]);
    a = 1-poly([var(nb+1:nb+na)]',"q","coeff");
    b = poly([repmat(0,nk,1);var(1:nb)]',"q","coeff");
    a = (poly([1,-coeff(a)],'q','coeff'))
//    disp(a)
//    disp(b)
    p = struct('A',a);
    theta_ar = p;
endfunction

function yhat = _objfun(UDATA,YDATA,x,na,nb,nk)
    x=x(:)
     q = poly(0,'q')
    tempSum = nb+na
    // making polynomials
    b = poly([repmat(0,nk,1);x(1:nb)]',"q","coeff");
    a = 1 - poly([x(nb+1:nb+na)]',"q","coeff")
    aSize = coeff(a);bSize = coeff(b)
    maxDelay = max([length(aSize) length(bSize)])
    yhat = [YDATA(1:maxDelay)]
    for k=maxDelay+1:size(UDATA,"*")
        tempB = 0
        for ii = 1:size(bSize,'*')
            tempB = tempB + bSize(ii)*UDATA(k-ii+1)
        end
        tempA = 0
        for ii = 1:size(aSize,"*")
            tempA = tempA + aSize(ii)*YDATA(k-ii)
        end
        yhat = [yhat; [ tempA+tempB ]];
    end
endfunction
