function con_mat = gen_path_con_mat(G,H,S,T)
    con_mat = zeros(size(G,2)+2);
    Is = find(ismember(H.Edges(:,:,1),S,'rows'));
    It = find(ismember(H.Edges(:,:,2),T,'rows'));
    g = size(G,2);
    for i = 1:g
        [~,Ia,~] = intersect(H.Edges(Is,:,2),G(i).PG.Vertices,'rows');
        if ~isempty(Ia)
            con_mat(1,i+1) = 1;
        end
        [~,Ib,~] = intersect(H.Edges(It,:,1),G(i).PG.Vertices,'rows');
        if ~isempty(Ib)
            con_mat(i+1,end) = 1;
        end
    end
    for j = 1:g
        for k = 1:g
            if(k~=j)
                Ig = find(ismember(H.Edges(:,:,1),G(j).PG.Vertices,'rows'));
                [~,Ic,~] = intersect(H.Edges(Ig,:,2),G(k).PG.Vertices,'rows');
                if ~isempty(Ic)
                    con_mat(j+1,k+1) = 1;
                end
            end
        end
    end
end