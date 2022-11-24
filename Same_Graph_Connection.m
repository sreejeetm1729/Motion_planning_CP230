function uH = Same_Graph_Connection(uH,G,m,g)
    for i = 1:g
        idx = ismember(uH.Vertices,G(1).PG.Vertices,'rows');
        SG_Ver = uH.Vertices(idx,:);
        col_sz = size(SG_Ver,2);
        ti_sz = size(SG_Ver,1)/m;
        SG_Ver = reshape(SG_Ver,m,col_sz,ti_sz);
        Max_G_sub = Maximal_Connected_Subgraphs(G(i).PG);
        for j = 1:size(SG_Ver,3)-1
            for k = j+1:size(SG_Ver,3)
                valid = Signature_Check(Max_G_sub,SG_Ver(:,:,j),SG_Ver(:,:,k));
                if valid
                    uH.Edges = [uH.Edges ; SG_Ver(:,:,[j k]) ; SG_Ver(:,:,[k j])];
                end
            end
        end
    end
end