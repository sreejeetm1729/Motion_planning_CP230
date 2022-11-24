function V = Pumped_Configuration(n,sl,el,r,sm,obs_nodes)
    V = [];
    while(size(V,1) ~= n)
        if(~isempty(obs_nodes))
            v = unifrnd(sl,el);
            obs_dis = dist(obs_nodes,v');
            if(~isempty(find(obs_dis<=r+sm, 1)))
                continue;
            end
        end
        valid = true;
        if ~isempty(V)
            for i = 1:size(V,1)
                if dist(V(i,:),v') <= 2*r+sm
                    valid = false;
                    break;
                end
            end
        end
        if valid
            V = [V ; v];
        end
    end
end