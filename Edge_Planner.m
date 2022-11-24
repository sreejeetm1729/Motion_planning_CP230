function path_check = Edge_Planner(v1,v2,V,r,sm,ds,obs_nodes)
    path_check = false;
    dis_edge = [linspace(v1(1),v2(1),ds) ; linspace(v1(2),v2(2),ds)];
    obs_dis = dist(obs_nodes,dis_edge);
    V = setdiff(V,[v1;v2],'rows');
    dis_mat = dist(V,dis_edge);
    if(isempty(find(dis_mat<=2*r+sm, 1)) && isempty(find(obs_dis<=r+sm, 1)))
        path_check = true;
    end
end
