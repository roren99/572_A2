curr_classifier = 1;

while curr_classifier <= 3
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
    
    XX = [a(:,1); b(:,1)];
    YY = [a(:,2); b(:,2)];
    xmin = min(XX);
    ymin = min(YY);
    xmax = max(XX);
    ymax = max(YY);
    
    step = 1;
    x1 = xmin:step:xmax;
    x2 = ymin:step:ymax;
    
    [X1, X2] = meshgrid(x1, x2);
    classes = zeros(length(x1)*length(x2),1);
    XGrid = [X1(:) X2(:)];
    
    max_discriminants = size(discriminant_points, 1);
    
    for i = 1:length(XGrid)
        j = 1;
        while true
            a_x = discriminant_points(j,1);
            a_y = discriminant_points(j,2);
            b_x = discriminant_points(j,3);
            b_y = discriminant_points(j,4);
            distance_a = sqrt((a_x - XGrid(i,1))^2 + (a_y - XGrid(i,2))^2);
            distance_b = sqrt((b_x - XGrid(i,1))^2 + (b_y - XGrid(i,2))^2);
            n_bA = errors(j,2);
            n_aB = errors(j,1);
    
            if distance_a < distance_b && (j == max_discriminants || n_bA == 0)
                % CLASS A
                classes(i) = 0; 
                break;
            end
            if distance_a >= distance_b && (j == max_discriminants || n_aB == 0)
                % CLASS B
                classes(i) = 1;
                break;
            end
            % if no conditions are met, append j
            j = j+1;
        end
    end
   
    figure(curr_classifier)
    hold on

    xlabel('x1') 
    ylabel('x2')
    title('Data sets a and b with Sequential Classifier Boundary')
    plot(a(:,1), a(:,2), 'ro')
    plot(b(:,1), b(:,2), 'bo')
    x2_len = length(x2);
    x1_len = length(x1);
    z = reshape(classes, x2_len, x1_len);
    contour(X1,X2,z)
    legend('Data set "a"','Data set "b"', 'Sequential Classifier Boundary')

    curr_classifier = curr_classifier + 1;
end

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
