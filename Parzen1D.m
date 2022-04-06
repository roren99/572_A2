function Parzen1D()	
	load('lab2_1.mat');
	X_A = 0:0.01:10;
	X_B = 0:0.01:7;
	N_A = length(a);
	N_B = length(b);
	% True values
	true_mean_a = 5;
	true_var_a = 1;
	Y_A = calcNormPDF(X_A, true_mean_a, sqrt(true_var_a));
	true_lambda_b = 1;
	Y_B = calcExpPDF(X_B, true_lambda_b);

	% stdev = 0.1
	% Class a
	% Estimated values
	h = 0.1;
	y1_a = zeros(1,length(X_A));
	for i = 1:N_A
		phi = calcNormPDF(X_A,a(i),h);
		y1_a = y1_a + phi/N_A;
	end
	% Plot
	figure;
	hold on;
	plot(X_A,Y_A);
	plot(X_A,y1_a);
	legend('True p(x) a','Estimated p(x) a');
	title('Class a: Parzen Estimated p(x) vs True p(x), stdev = 0.1');
	xlabel('x');
	ylabel('p(x)');
  grid on;
	hold off;
	
	% Class b
	% Estimated values
	h = 0.1;
	y1_b = zeros(1,length(X_B));
	for i = 1:N_B
		phi = calcNormPDF(X_B,b(i),h);
		y1_b = y1_b + phi/N_B;
	end
	% Plot
	figure;
	hold on;
	plot(X_B,Y_B);
	plot(X_B,y1_b);
	legend('True p(x) b','Estimated p(x) b');
	title('Class b: Parzen Estimated p(x) vs True p(x), stdev = 0.1');
	xlabel('x');
	ylabel('p(x)');
  grid on;
	hold off;
	
	% stdev = 0.4
	% Class a
	% Estimated values
	h = 0.4;
	y2_a = zeros(1,length(X_A));
	for i = 1:N_A
		phi = calcNormPDF(X_A,a(i),h);
		y2_a = y2_a + phi/N_A;
	end
	% Plot
	figure;
	hold on;
	plot(X_A,Y_A);
	plot(X_A,y2_a);
	legend('True p(x) a','Estimated p(x) a');
	title('Class a: Parzen Estimated p(x) vs True p(x), stdev = 0.4');
	xlabel('x');
	ylabel('p(x)');
  grid on;
	hold off;
	
	% Class b
	% Estimated values
	h = 0.4;
	y2_b = zeros(1,length(X_B));
	for i = 1:N_B
		phi = calcNormPDF(X_B,b(i),h);
		y2_b = y2_b + phi/N_B;
	end
	% Plot
	figure;
	hold on;
	plot(X_B,Y_B);
	plot(X_B,y2_b);
	legend('True p(x) b','Estimated p(x) b');
	title('Class b: Parzen Estimated p(x) vs True p(x), stdev = 0.4');
	xlabel('x');
	ylabel('p(x)');
  grid on;
	hold off;
end