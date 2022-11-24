function path = Query(S,T,G,H,q,mu,m,r,sm,ds,obs_nodes)
    Gs = struct('Vertices',S,'Edges',[]);
    Gt = struct('Vertices',T,'Edges',[]);
    for i = 1:size(G,2)
        H = Connect(Gs,G(i).PG,H,q,mu,m,r,sm,ds,obs_nodes);
        H = Connect(G(i).PG,Gt,H,q,mu,m,r,sm,ds,obs_nodes);
    end
    Start = intersect(H.Vertices,S,'rows');
    Terminal = intersect(H.Vertices,T,'rows');

    if (isempty(Start) || isempty(Terminal))
        disp('FAILURE')
        path = [];
    else
        path =Retrieve_Path(G,H,S,T);
    end
end