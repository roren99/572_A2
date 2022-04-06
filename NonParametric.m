load('lab2_2.mat');

% Estimate PDF for each cluster using a Gaussian Parzen window with var = 400
var = 400;
stdev = sqrt(var);
res = 0.5;
ksize = round(12*stdev/res);
t = res.*(-ksize:(ksize+1));
win = exp(-res.*t.*t/(var));

xmax = max([al(:,1); bl(:,1); cl(:,1)]);
ymax = max([al(:,2); bl(:,2); cl(:,2)]);
[pA, xA, yA] = parzen(al, [res, 0, 0, xmax, ymax], win);
[pB, xB, yB] = parzen(bl, [res, 0, 0, xmax, ymax], win);
[pC, xC, yC] = parzen(cl, [res, 0, 0, xmax, ymax], win);
classes = zeros(ymax, xmax);
for i = 1:ymax
	for j = 1:xmax
		a_val = pA(find(yA==i),find(xA==j));
		b_val = pB(find(yB==i),find(xB==j));
		c_val = pC(find(yC==i),find(xC==j));

	 if a_val >= b_val && a_val >= c_val
			 classes(i, j) = 1;
	 elseif b_val >= c_val && b_val > a_val
			 classes(i, j) = 2;
	 elseif c_val > b_val && c_val > a_val
			 classes(i, j) = 3;
	 end
	end
end

figure;
hold on;
scatter(al(:,1), al(:,2), 'r');
scatter(bl(:,1), bl(:,2), 'b');
scatter(cl(:,1), cl(:,2), 'g');
contour(classes, 'Color', 'm');
legend('Class al', 'Class bl', 'Class cl',  'ML Boundary');
title('al, bl, cl Cluster Data with ML Boundary');
xlabel('x1');
ylabel('x2');


