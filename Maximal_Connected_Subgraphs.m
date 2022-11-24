function Max_G_sub = Maximal_Connected_Subgraphs(G)

% This function finds all the maximal connected subgraphs of G(V,E)

% G is a structure with fields Vertices and Edges
% Vertices contains the single robot configuration in the form of a matrix
% with each row containing the configuration of a single robot
% Row of Vertices array is the number ID for that vertex
% Edges contains pairs of Vertices(in form of number ID) and each edge is 
% valid transition from one vertex to another in the graph

    %maximum vertices array
    Mv = 1; 
    %temporary vertices array
    Tv = 1; 
    %remaining vertices array
    Rv = (1:size(G.Vertices,1))';
    % starting index for maximal graphs
    j = 1;
    while(1)
        Max_G_sub(j).Vertices = [];
        Max_G_sub(j).Edges = [];
        while(~isempty(Tv))
            TTv = Mv;
            for i = 1:numel(Rv)
            % Each vertex in Rv forms an edge temporarily with vertices in Mv
                edge = [Tv repelem(Rv(i),numel(Tv),1)];
                edge = [edge;fliplr(edge)];
            % obtaining valid edges 
                edge = intersect(G.Edges,edge,'rows');
                if(~isempty(edge))
                    Mv = [Mv ; Rv(i)];
                    Max_G_sub(j).Edges = [Max_G_sub(j).Edges ; edge];
                end
            end
            Tv = setdiff(Mv,TTv);
        end
        Mv = unique(Mv,'stable');
        Max_G_sub(j).Vertices = G.Vertices(Mv,:);
        Max_G_sub(j).Edges = unique(Max_G_sub(j).Edges,'rows','stable');
        Rv = setdiff(Rv,Mv);
        if(isempty(Rv))
            break;
        end
        Mv = Rv(1);
        Tv = Mv;
        j = j+1;
    end
end