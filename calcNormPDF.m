function y = calcNormPDF(x,mean,stdev)
	y = 1/(stdev*sqrt(2*pi))*exp(-0.5*((x-mean)/stdev).^2);
end