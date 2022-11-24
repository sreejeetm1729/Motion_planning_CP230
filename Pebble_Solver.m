function Path = Pebble_Solver(G,S,T)
% Given a graph G(V,E), Start(S) and Target(T) placement this function returns a
% path within the graph to reach from start to target

% |V| = n and |S|=|T|=m and m<=n also for this function to find a solution
% the start and target signature should be same.

    Max_G_sub = Maximal_Connected_Subgraphs(G);
    valid = Signature_Check(Max_G_sub,S,T);
    Path = [];
    if valid
        spath = Path_Finder(G,Max_G_sub,S,T);
        [~,occ_mat,~] = intersect(G.Vertices,S,'rows');
        Path = occ_mat;
        for i = 1:size(spath,2)
            cur_path = spath(i).path;
            [occ_path,idx,~] = intersect(cur_path,occ_mat,'stable');
            occ_path = [cur_path(end) ; flipud(occ_path)];
            idx = [numel(cur_path) ; flipud(idx)];
            for j = 1:numel(occ_path)-1
                idx_occ_mat = occ_mat == occ_path(j+1);
                sz = idx(j)-idx(j+1);
                Tpath = repmat(occ_mat,1,sz);
                Tpath(idx_occ_mat,:) = cur_path(idx(j+1)+1:idx(j));
                Path = [Path Tpath];
                occ_mat = Path(:,end);
            end
        end
    end
end