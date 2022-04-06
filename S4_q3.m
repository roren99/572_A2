load('lab2_3.mat')

curr_classifier = 1;

% 20 rounds, first 5 classifier for each round
error_log = zeros(20,5);

while curr_classifier <= 20
    discriminant_points = zeros(0,4);
    
    errors = zeros(0,1);

    a_data = a;
    b_data = b;
            
    size_a = size(a_data,1);
    size_b = size(b_data,1);
    
    % keep looping while there are still points left in a and b
    while size(a_data,1) > 0 || size(b_data,1) > 0
        
        size_a = size(a_data,1);
        size_b = size(b_data,1);
        
        a_idx = randi(size_a);
        b_idx = randi(size_b);
        
        a_rand = a_data(a_idx,:);
        b_rand = b_data(b_idx,:);
    
        n_aB = 0;
        n_bA = 0;
        
        aB = zeros(0,2);
        bA = zeros(0,2);
            
        % loop through all the points in A
        [n_aB, aB] = MED(n_aB, aB, a_data, a_rand, b_rand, 1);
    
        % loop through all the points in B
        [n_bA, bA] = MED(n_bA, bA, b_data, a_rand, b_rand, 0);
    
        % go back to step 2 if there are misclassified points.
        loop_condition = (n_aB ~= 0 && n_bA ~= 0);
        
        if ~loop_condition
            if n_aB == 0 && n_bA == 0 
                correct_pts = (size(b_data,1)-size(bA,1)) + (size(a_data,1)-size(aB,1));
                errors = [errors; correct_pts]; 
                a_data = aB;
                b_data = bA;
            elseif n_aB > 0
                correct_pts = size(a_data,1)-size(aB,1);
                errors = [errors; correct_pts]; 
                a_data = aB;
            elseif n_bA > 0 
                correct_pts = size(b_data,1)-size(bA,1);
                errors = [errors; correct_pts]; 
                b_data = bA;
            end
        end
    end
    
    num_pts = 400;
    for J = 1:5
        correct_points = sum(errors(1:J,1));
        error_log(curr_classifier, J) = (1/num_pts)*(num_pts - correct_points);
    end

    curr_classifier = curr_classifier + 1;
end

avg_err_rate = mean(error_log,1)
min_err_rate = min(error_log)
max_err_rate = max(error_log)
std_err_rate = std(error_log)

x_points = [1:5];

figure(1)
plot(x_points, avg_err_rate, '-o','LineWidth', 2)
title("a) Avg. Error Rate of Jth Sequential Classifier Limit")
xlabel("Jth Sequential Classifier Limit")
ylabel("Avg. Error Rate")

figure(2)
plot(x_points, min_err_rate, '-o','LineWidth', 2)
title("b) Minimum Error Rate of Jth Sequential Classifier Limit")
xlabel("Jth Sequential Classifier Limit")
ylabel("Minimum Error Rate")

figure(3)
plot(x_points, max_err_rate, '-o','LineWidth', 2)
title("c) Maximum Error Rate of Jth Sequential Classifier Limit")
xlabel("Jth Sequential Classifier Limit")
ylabel("Maximum Error Rate")

figure(4)
plot(x_points, std_err_rate, '-o','LineWidth', 2)
title("d) Standard Deviation of Error Rate of Jth Sequential Classifier Limit")
xlabel("Jth Sequential Classifier Limit")
ylabel("Standard Deviation of Error Rate")

function [n_X, X] = MED(n_X, X, data, a_rand, b_rand, a_flag)
    for i = 1:size(data,1)
        x = data(i,1);
        y = data(i,2);
        dis_a = sqrt((x - a_rand(1))^2 + (y - a_rand(2))^2);
        dis_b = sqrt((x - b_rand(1))^2 + (y - b_rand(2))^2);
        if a_flag
            if dis_a > dis_b
                n_X = n_X + 1;
                X = [X; data(i,:)];
            end
        else
            if dis_a < dis_b
                n_X = n_X + 1;
                X = [X; data(i,:)];
            end

        end
    end
end
