function P = Retrieve_Path_Dummy(G,H,S,T)
    con_mat = gen_path_con_mat(G,H,S,T);
    act_way = way_finder(con_mat);
    sz = size(act_way,2);
    m = size(S,1);
    P(:,:,1) = S;
    if(sz > 1)
        for i = 1:sz-1
            Igi = find(ismember(H(:,:,1).Edges,G(act_way(i)).Vertices),'rows');
            Igj = find(ismember(H(Igi,:,2).Edges,G(act_way(i+1)).Vertices),'rows');
            connections(i).Edges = H(Igj,:,:).Edges;
        end
        for j = 1:size(connections,2)-1
            g1 = connections(j).Edges(:,:,2);
            g2 = connections(j+1).Edges(:,:,1);
            check = 0;
            for k = 1:m:size(g1,1)
                for l = 1:m:size(g2,1)
                     if(isempty(setdiff(g1(k:(k+m-1),:),g2(l:(l+m-1),:),'rows')))
                         check = 1;
                         break;
                     end
                end
                if(check)
                    break;
                end
            end
            if(~check)
            end
        end
    end
end