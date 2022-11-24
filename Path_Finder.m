function spath = Path_Finder(G,Max_G_sub,S,T)
    k = 1;
    for i = 1:size(Max_G_sub,2)
        Ms = intersect(Max_G_sub(i).Vertices,S,'rows');
        Mt = intersect(Max_G_sub(i).Vertices,T,'rows');
        [~,sta_mat,~] = intersect(G.Vertices,Ms,'rows');
        [~,tar_mat,~] = intersect(G.Vertices,Mt,'rows');
        un_sta_mat = setdiff(sta_mat,tar_mat);
        un_tar_mat = setdiff(tar_mat,sta_mat);
        if(~isempty(un_tar_mat))
            D = gen_edge_con_mat(size(G.Vertices,1),Max_G_sub(i).Edges);
            for j = k:k+numel(un_sta_mat)-1
                spath(j).path = djikstra(un_sta_mat(j-k+1),un_tar_mat,D);
                un_tar_mat = setdiff(un_tar_mat,spath(j).path(end));
            end
            k = j+1;
        end
    end
end