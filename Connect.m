function H = Connect(G1,G2,uH,q,mu,m,r,sm,ds,obs_nodes)
    path_row = 1;
    for i = 1:size(G1.Vertices,1)
        for j = 1:size(G2.Vertices,1)
            path_check = Edge_Planner(G1.Vertices(i,:),G2.Vertices(j,:),G1.Vertices,r,sm,ds,obs_nodes);
            if path_check == true
                path_edges(path_row,:,1) = G1.Vertices(i,:);
                path_edges(path_row,:,2) = G2.Vertices(j,:);
                path_row = path_row + 1;
            end    
        end
    end
    step_array = (path_edges(:,:,2)-path_edges(:,:,1))/(ds-1);
    int_edg = [1 1];
    int_edg(1,:) = [];
    traj = [];
    for k = 1:ds
        traj(:,:,k) = path_edges(:,:,1) + (k-1)*step_array;
        [rows,cols] = find(dist(traj(:,:,k)')<(2*r+sm));
        valid_indices = find((rows>=cols)==1);
        int_edg = union(int_edg,[rows(valid_indices) cols(valid_indices)],'rows','stable');
    end
    All_C = 1:m;
    All_C(1,:) = [];
    for i = 1:q
        vertex_perm = randperm(size(path_edges,1));
        C = [vertex_perm(1)];
        j = 2;
        while numel(C)~=m
            nxtC = vertex_perm(j);
            nc = repelem(nxtC,numel(C),1);
            edge_to_check = [nc C];
            check = (nc<C)==1;
            edge_to_check(check,:) = fliplr(edge_to_check(check,:));
            if(isempty(intersect(int_edg,edge_to_check,'rows')))
                C = [C ;nxtC];
            end
            if j == size(path_edges,1)
                break;
            end
            j = j+1;
        end
        if numel(C) == m
            mem_array = ismember(All_C,C');
            check_array = intersect(mem_array,ones(1,m),'rows');
            if(isempty(check_array))
                uH.Vertices = [uH.Vertices ; path_edges(C,:,1)];
                uH.Vertices = [uH.Vertices ; path_edges(C,:,2)];
                uH.Edges = [uH.Edges ; path_edges(C,:,:)];
                All_C = [All_C ; C'];
            end
        end
    end
    H = uH;
end