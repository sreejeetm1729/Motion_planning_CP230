function D = gen_edge_con_mat(num_nodes,edge_weight_mat)
    curr_node = edge_weight_mat(:,1);
    end_node = edge_weight_mat(:,2);
    weight = ones(size(edge_weight_mat,1),1);
    num_elements_mat = (num_nodes^2 - num_nodes)/2;
    index_mat = (end_node - curr_node) + (num_nodes - curr_node/2).*(curr_node - 1);
    d = (1:num_elements_mat)*inf;
    d(index_mat) = weight;
    D = squareform(d);
end