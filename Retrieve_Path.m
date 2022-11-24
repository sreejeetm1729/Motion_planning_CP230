function P = Retrieve_Path(G,H,S,T)
    con_mat = gen_path_con_mat(G,H,S,T);
    act_way = way_finder(con_mat);
    Is = find(ismember(H.Edges(:,:,1),S,'rows'));
    P(:,:,1) = S;
    for i = 1:size(act_way,2)
        [~,I1,~] = intersect(H.Edges(Is,:,2),G(act_way(i)).PG.Vertices,'rows','stable');
        I1 = Is(I1);
        [~,~,I2] = intersect(P(:,:,i),H.Edges(I1,:,1),'rows','stable');
        ch = H.Edges(I1,:,2);
        P(:,:,i+1) = ch(I2,:);
        Is = find(ismember(H.Edges(:,:,1),P(:,:,i+1),'rows'));
    end
    [~,I1,~] = intersect(H.Edges(Is,:,2),T,'rows','stable');
    I1 = Is(I1);
    [~,~,I2] = intersect(P(:,:,i+1),H.Edges(I1,:,1),'rows','stable');
    ch = H.Edges(I1,:,2);
    P(:,:,i+2) = ch(I2,:);
end