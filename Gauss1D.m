function Gauss1D()	
	load('lab2_1.mat');

	% Class a
	% True values
	true_mean_a = 5;
	true_var_a = 1;
	% Estimated values
	N_A = length(a);
	est_mean_a = (1/N_A) * sum(a);
	est_var_a = (1/N_A) * sum((a-est_mean_a).^2);
	% Plot
	x1 = 0:0.01:10;
	y1 = calcNormPDF(x1, true_mean_a, sqrt(true_var_a));
	y2 = calcNormPDF(x1, est_mean_a, sqrt(est_var_a));
	figure;
	hold on;
	plot(x1,y1);
	plot(x1,y2);
	legend('True p(x) a','Estimated p(x) a');
	title('Class a: Gaussian Estimated p(x) vs True p(x)');
	xlabel('x');
	ylabel('p(x)');
  grid on;
	hold off;
	
	% Class b
	% True values
	true_lambda_b = 1;
	% Estimated values
	N_B = length(b);
	est_mean_b = (1/N_B) * sum(b);
	est_var_b = (1/N_B) * sum((b-est_mean_b).^2);
	% Plot
	x2 = 0:0.01:7;
	y3 = calcExpPDF(x2, true_lambda_b);
	y4 = calcNormPDF(x2, est_mean_b, sqrt(est_var_b));
	figure;
	hold on;
	plot(x2,y3);
	plot(x2,y4);
	legend('True p(x) b','Estimated p(x) b');
	title('Class b: Gaussian Estimated p(x) vs True p(x)');
	xlabel('x');
	ylabel('p(x)');
  grid on;
	hold off;
end