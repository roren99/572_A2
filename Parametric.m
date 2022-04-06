load('lab2_2.mat');

% Compute sample mean and sample covariance of each cluster
m_al = mean(al);
m_bl = mean(bl);
m_cl = mean(cl);

cov_al = cov(al);
cov_bl = cov(bl);
cov_cl = cov(cl);

N_al = length(al);
N_bl = length(bl);
N_cl = length(cl);

figure;
hold on;
% Plot the cluster data
scatter(al(:,1), al(:,2), 'r');
scatter(bl(:,1), bl(:,2), 'b');
scatter(cl(:,1), cl(:,2), 'g');
% Calculate and plot ML classification boundaries
ML3(m_al,m_bl,m_cl, al,bl,cl, cov_al,cov_bl,cov_cl, N_al,N_bl,N_cl);
legend('Class al', 'Class bl', 'Class cl','ML Boundary');
title('al, bl, cl Cluster Data with ML Boundary');
xlabel('x1');
ylabel('x2');
hold off;


