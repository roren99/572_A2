function ML3(muA,muB,muC, X_A,X_B,X_C, SigmaA,SigmaB,SigmaC, n_A,n_B,n_C)
    % Define points
    XX = [X_A(:,1); X_B(:,1); X_C(:,1)];
    YY = [X_A(:,2); X_B(:,2); X_C(:,2)];
    xmin = min(XX);
    ymin = min(YY);
    xmax = max(XX);
    ymax = max(YY);
    
    % Make 1d grid positions
    step = 1;
    x1 = xmin:step:xmax;
    x2 = ymin:step:ymax;
    
    % Make 2D coordinates grid
    [X1, X2] = meshgrid(x1, x2);
    classes = zeros(length(x1)*length(x2),1);
    
    n_total = n_A + n_B + n_C;
    p_A = n_A / n_total;
    p_B = n_B / n_total;
    p_C = n_C / n_total;
    log_theta_1 = log(1);
    log_theta_2 = log(1);
    log_theta_3 = log(1);

    Z_1 = Gauss2d(x1, x2, muA', SigmaA');
    Z_2 = Gauss2d(x1, x2, muB', SigmaB');
    Z_3 = Gauss2d(x1, x2, muC', SigmaC');

    for i = 1:length(X1(:))
        p_x_A = Z_1(ceil(i / length(x2)), (i - ((ceil(i / length(x2)) - 1) * length(x2))));
        p_x_B = Z_2(ceil(i / length(x2)), (i - ((ceil(i / length(x2)) - 1) * length(x2))));
        p_x_C = Z_3(ceil(i / length(x2)), (i - ((ceil(i / length(x2)) - 1) * length(x2))));
        log_i_x_1 = log(p_x_A / p_x_B);
        log_i_x_2 = log(p_x_C / p_x_A);
        log_i_x_3 = log(p_x_B / p_x_C);

        if (log_i_x_1 > log_theta_1 && log_i_x_2 < log_theta_2)
            classes(i) = 1;
        elseif (log_i_x_1 < log_theta_1 && log_i_x_3 > log_theta_3)
            classes(i) = 2;
        elseif (log_i_x_3 < log_theta_3 && log_i_x_2 > log_theta_2)
            classes(i) = 3;
        else
            classes(i) = 0;
        end
    end
    classes = reshape(classes,length(x2),length(x1));
    contour(x1, x2, classes, 'Color', 'm');
end