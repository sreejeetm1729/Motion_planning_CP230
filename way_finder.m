function act_way = way_finder(con_mat)
    [rows,cols] = find(con_mat==1);
    way = size(con_mat,2);
    while(isempty(find(way == 1, 1)))
        t_way = [];
        for i = 1:size(way,1)
            par = rows(cols == way(i,1));
            t_way = [t_way ;[par repelem(way(i,:),size(par,1),1)]];
            if(~isempty(find(par == 1, 1)))
                break;
            end
        end
        way = t_way;
    end
    [~,way_ind] = min(way(:,1));
    act_way = way(way_ind,2:size(way,2)-1)-1;
end