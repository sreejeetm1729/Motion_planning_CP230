function G = Pebble_Graph(n,sl,el,r,sm,ds,obs_nodes)
    V = Pumped_Configuration(n,sl,el,r,sm,obs_nodes);
    E =[];
    for i = 1:n-1
        for j = i+1:n
            path_check = Edge_Planner(V(i,:),V(j,:),V,r,sm,ds,obs_nodes);
            if path_check == true
                E = [E ; [i j]];
            end
        end
    end
    G = struct('Vertices',V,'Edges',E);
end