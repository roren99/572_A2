

curr_classifier = 1;

% 20 rounds, first 5 classifier for each round
error_log = zeros(20,5);

while curr_classifier <= 20
    % keep track of strong points used to build discriminants
    discriminant_points = zeros(0,4);
    
    % keep track of the errors for those discriminants
    errors = zeros(0,2);

    % make a copy of original data
    a_data = a;
    b_data = b;
            
    % get array length
    size_a = size(a_data,1);
    size_b = size(b_data,1);
    
    % keep looping while there are still points left in a and b
    while size(a_data,1)>0 || size(b_data,1)>0
        % get array length
        size_a = size(a_data,1);
        size_b = size(b_data,1);
        
        % generate a random number
        a_idx = randi(size_a);
        b_idx = randi(size_b);
        
        % index the array
        a_rand = a_data(a_idx,:);
        b_rand = b_data(b_idx,:);
    
        % count mislabelled points
        n_aB = 0;
        n_bA = 0;
        
        % keep track of certain points
        aB = zeros(0,2);
        bA = zeros(0,2);
            
        % loop through all the points in A
        [n_aB, aB] = MED(n_aB, aB, a_data, a_rand, b_rand, 1);
    
        % loop through all the points in B
        [n_bA, bA] = MED(n_bA, bA, b_data, a_rand, b_rand, 0);
    
        % go back to step 2 if there are misclassified points.
        loop_condition = (n_aB ~= 0 && n_bA ~= 0);
       
        % successful! let's save this data.
        if ~loop_condition
            discriminant_points = [discriminant_points; a_rand b_rand];
            errors = [errors; n_aB n_bA]; 
            if n_aB == 0
                b_data = bA;
            end
            if n_bA == 0
                a_data = aB;
            end
        end
    end
    
    % now, calculate the errors 
    num_pts = 400;
    for J = 1:5
        cum_errors = sum(errors(1:J,2));
        error_log(curr_classifier, J) = (1/num_pts)*(num_pts - cum_errors);
    end
    curr_classifier = curr_classifier + 1;
end

error_log

avg_err_rate = mean(error_log,1)
min_err_rate = min(error_log)
max_err_rate = max(error_log)
std_err_rate = std(error_log)

x_points = [1:5];

figure(1)
plot(x_points, avg_err_rate, '-o','LineWidth', 2)
title("a) Avg. Error Rate of Jth Sequential Classifier")
xlabel("Jth Sequential Classifier")
ylabel("Avg. Error Rate")

figure(2)
plot(x_points, min_err_rate, '-o','LineWidth', 2)
title("b) Minimum Error Rate of Jth Sequential Classifier")
xlabel("Jth Sequential Classifier")
ylabel("Minimum Error Rate")

figure(3)
plot(x_points, max_err_rate, '-o','LineWidth', 2)
title("c) Maximum Error Rate of Jth Sequential Classifier")
xlabel("Jth Sequential Classifier")
ylabel("Maximum Error Rate")

figure(4)
plot(x_points, std_err_rate, '-o','LineWidth', 2)
title("d) Standard Deviation of Error Rate of Jth Sequential Classifier")
xlabel("Jth Sequential Classifier")
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
