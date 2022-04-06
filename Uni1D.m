function Uni1D()	
	load('lab2_1.mat');

	% Class a
	% True values
	true_mean_a = 5;
	true_var_a = 1;
	% Estimated values
	N_A = length(a);
	est_a_a = min(a);
	est_b_a = max(a);
	% Plot
	x1 = 0:0.01:10;
	y1 = calcNormPDF(x1, true_mean_a, sqrt(true_var_a));
	x2 = est_a_a:0.01:est_b_a;
	y2 = calcUniPDF(x2, est_a_a, est_b_a);
	figure;
	hold on;
	plot(x1,y1);
	plot(x2,y2);
	legend('True p(x) a','Estimated p(x) a');
	title('Class a: Uniform Estimated p(x) vs True p(x)');
	xlabel('x');
	ylabel('p(x)');
  grid on;
	hold off;
	
	% Class b
	% True values
	true_lambda_b = 1;
	% Estimated values
	N_B = length(b);
	est_a_b = min(b);
	est_b_b = max(b);
	% Plot
	x3 = 0:0.01:7;
	y3 = calcExpPDF(x3, true_lambda_b);
	x4 = est_a_b:0.01:est_b_b;
	y4 = calcUniPDF(x4, est_a_b, est_b_b);
	figure;
	hold on;
	plot(x3,y3);
	plot(x4,y4);
	legend('True p(x) b','Estimated p(x) b');
	title('Class b: Uniform Estimated p(x) vs True p(x)');
	xlabel('x');
	ylabel('p(x)');
  grid on;
	hold off;
end