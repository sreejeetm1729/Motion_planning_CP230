function valid = Signature_Check(M,S,T)
% This function checks whether the start and target placement is realizable
% M is maximal connected subgraphs, S is the start placement , T is the
% target placement 
% the placement pairs are unrealizable if any M there are unequal number of
% start and target vertices
    
    valid = true;
    for i = 1:size(M,2)
        Ns = size(intersect(M(i).Vertices,S,'rows'),1);
        Nt = size(intersect(M(i).Vertices,T,'rows'),1);
        if Ns~=Nt
            valid = false;
            break;
        end
    end
end