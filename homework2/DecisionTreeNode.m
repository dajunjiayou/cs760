classdef DecisionTreeNode
    properties
        IsLeaf
        Class
        Feature
        Threshold
        Left
        Right
    end

    methods (Static)
        function tree = build_decision_tree(X, y)
             tree = DecisionTreeNode();
             if isempty(X) || isempty(y)
                tree.IsLeaf = true;
                tree.Class = mode(y);
                 if isempty(tree.Class)
                    tree.Class = 1;  % Default class
                    end
                return;
             end

            if all(y == 1)
                tree.IsLeaf = true;
                tree.Class = 1;
                return;
            elseif all(y == 0)
                tree.IsLeaf = true;
                tree.Class = 0;
                return;
            end

         [best_feature, best_threshold] = DecisionTreeNode.find_best_split(X, y);
%   best_feature
%   best_threshold
            if isnan(best_feature)
                tree.IsLeaf = true;
                tree.Class = mode(y);
                if isempty(tree.Class)
                    tree.Class = 1;  % Default class
                end
                return;
            end

            tree.IsLeaf = false;
            tree.Feature = best_feature;
            tree.Threshold = best_threshold;
            left_mask = X(:, best_feature) >= best_threshold;
            right_mask = ~left_mask;                                        % not
            tree.Left =  DecisionTreeNode.build_decision_tree(X(left_mask, :), y(left_mask));
            tree.Right =  DecisionTreeNode.build_decision_tree(X(right_mask, :), y(right_mask));
        
        end

         % Function to find the best feature and threshold to split on
        function [best_feature, best_threshold] = find_best_split(X, y)
            n = size(X, 1);
            m = size(X, 2);
            best_gain = -inf;
            best_feature = NaN;
            best_threshold = NaN;
            entropy_parent = DecisionTreeNode.calculate_entropy(y);

            for feature = 1:m
                unique_values = unique(X(:, feature));

                for i = 1:length(unique_values)
                    threshold = unique_values(i);
                    left_mask = X(:, feature) >= threshold;
                    right_mask = ~left_mask;

                    if sum(left_mask) == 0 || sum(right_mask) == 0
                        continue;
                    end
                    gain = DecisionTreeNode.calculate_information_gain(entropy_parent, y(left_mask), y(right_mask));

                    if gain > best_gain
                        best_gain = gain;
                        best_feature = feature;
                        best_threshold = threshold;

                    end
                end
        
            end

        end
 
        % Function to calculate the entropy
        function entropy = calculate_entropy(y)
            if isempty(y)
                entropy = 0;
                return;
            end
            p1 = sum(y) / length(y);
            p0 = 1 - p1;
            if p1 == 0 || p0 == 0
                entropy = 0;
            else
                entropy = -p0 * log2(p0) - p1 * log2(p1);
            end
        end
        
        % Function to calculate the information gain
        function gain = calculate_information_gain(entropy_parent, y_left, y_right)

            p_left = length(y_left) / (length(y_left) + length(y_right));
            p_right = 1 - p_left;
            gain = entropy_parent - p_left * DecisionTreeNode.calculate_entropy(y_left) - p_right * DecisionTreeNode.calculate_entropy(y_right);
        end

    end

end

% dataruns = importdata('Druns.txt');
% 
% X = dataruns(:, 2);  % Assuming the first two columns are features
% 
% y = dataruns(:, 3);   % Assuming the third column is the label
% 
% tree =DecisionTreeNode.build_decision_tree(X, y);

