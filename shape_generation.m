function [shape_nodes, shape_node_s] = shape_generation(sl,el,m,r,sm,shape)
    spsl = 0.4*sl;
    spel = 0.4*el;
    shape_nodes = [];
    shape_node_s = [];
    if(shape(1))
        if(m==10 && (0<=r)&&(r<2) && (0<=sm)&&(sm<0.25))
            x_side_left = linspace(spsl(1),(spel(1)-(spel(1)-spsl(1))/2),5)';
            x_side_right = linspace((spel(1)-(spel(1)-spsl(1))/2),spel(1),5)';
            y_side = linspace(spsl(2),spel(2),5)';
            centre = [(spel(1)+spsl(1))/2 (spel(2)+spsl(2))/2];
            shape_A = [x_side_left y_side; 
                       setdiff(x_side_right,x_side_left) flip(y_side(1:4)); 
                       centre];
%             rotate = unifrnd(0,2*pi);
%             shape_A = shape_A*R(rotate);
            shape_nodes = [shape_nodes ; shape_A];
            shape_node_s(1).shape = shape_A;
        else
            disp('UNABLE TO FORM')
        end
    end
    if(shape(2))
        if(m==11 && (0<=r)&&(r<2) && (0<=sm)&&(sm<0.25))
            x_side_left = linspace(spsl(1),(spel(1)-(spel(1)-spsl(1))/2),3)';
            x_side_right = linspace((spel(1)-(spel(1)-spsl(1))/2),spel(1),3)';
            y_side = linspace(spsl(2),spel(2),4)';
            y_side_up = linspace((spel(2)+spsl(2))/2,spel(2),3)';
            shape_M = [repelem(spsl(1),4,1) y_side; 
                       setdiff(x_side_left,repelem(spsl(1),4,1)) flip(y_side_up(1:2));
                       setdiff(x_side_right,x_side_left) y_side_up(2:3);
                       repelem(spel(1),3,1) flip(y_side(1:3))];
            rotate = unifrnd(0,2*pi);
            shape_M = shape_M*R(rotate);
            shape_nodes = [shape_nodes; shape_M];
            shape_node_s(2).shape = shape_M;
        else
            disp('UNABLE TO FORM')
        end
    end
    if(shape(3))
         if(m==7 && (0<=r)&&(r<2) && (0<=sm)&&(sm<0.25))
            x_side = linspace(spsl(1),spel(1),5)';
            y_side = linspace(spsl(2),spel(2),5)';
            shape_lambda = [x_side flip(y_side);
                            x_side(1:2) y_side(1:2)];
            rotate = unifrnd(0,2*pi);
            shape_lambda = shape_lambda*R(rotate);
            shape_nodes = [shape_nodes; shape_lambda];
            shape_node_s(2).shape = shape_lambda;
        else
            disp('UNABLE TO FORM')
        end
    end
    if(shape(4))
         if(m==10 && (0<=r)&&(r<2) && (0<=sm)&&(sm<0.25))
            x_side = linspace(spsl(1),spel(1),4)';
            y_side = linspace(spsl(2),spel(2),4)';
            shape_N = [repelem(spsl(1),4,1) y_side; 
                       setdiff(x_side,repelem(spsl(1),4,1)) flip(y_side(1:3));
                       repelem(spel(1),3,1) y_side(2:4)];
            rotate = unifrnd(0,2*pi);
            shape_N = shape_N*R(rotate);
            shape_nodes = [shape_nodes; shape_N];
            shape_node_s(2).shape = shape_N;
        else
            disp('UNABLE TO FORM') 
        end
    end
end

function rot = R(phi)
 rot = [cos(phi)  sin(phi);
       -sin(phi)  cos(phi)];
end

function c = move(a, b)
    c(:,1) = a(:,1) + b(1);
    c(:,2) = a(:,2) + b(2);
end

