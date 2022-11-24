function [H,G] = Pre_Process(uH,g,q,n,mu,m,sl,el,r,sm,ds,obs_nodes)
    for i = 1:g
        Graph_PC = Pebble_Graph(n,sl,el,r,sm,ds,obs_nodes);
        G(i).PG = Graph_PC;
    end
    for j = 1:g
        for k = 1:g
            if(j~=k)
                uH = Connect(G(j).PG,G(k).PG,uH,q,mu,m,r,sm,ds,obs_nodes);
            end
        end
    end
    H = uH;
    %H = Same_Graph_Connection(uH,G,m,g);
end