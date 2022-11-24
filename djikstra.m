function path = djikstra(start,goal,D)
    visited_vertex = [];
    unvisited_vertex = (1:size(D,1));
    cost = (1:size(D,1))*inf;
    pre_vertex = (1:size(D,1))*NaN;
    cost(start) = 0;
    path = [];
    while(isempty(intersect(visited_vertex,goal)))
        [min_cost, min_cost_vertex] = min(cost(unvisited_vertex));
        N = findnearestneighbour(unvisited_vertex(min_cost_vertex),D);
        unvisited_N = setdiff(N,visited_vertex);
        for i = 1:length(unvisited_N)
            if(cost(unvisited_N(i))>(D(unvisited_vertex(min_cost_vertex),unvisited_N(i)) + min_cost))
                cost(unvisited_N(i)) = (D(unvisited_vertex(min_cost_vertex),unvisited_N(i)) + min_cost);
                pre_vertex(unvisited_N(i)) = unvisited_vertex(min_cost_vertex);
            end
        end
        visited_vertex(end+1) = unvisited_vertex(min_cost_vertex);
        unvisited_vertex(unvisited_vertex == unvisited_vertex(min_cost_vertex)) = [];
    end
    path = visited_vertex(end);
    while(isempty(intersect(path,start)))
        path = [pre_vertex(path(1)) path];
    end
end