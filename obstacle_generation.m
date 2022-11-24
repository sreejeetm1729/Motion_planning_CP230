function [obs_nodes ,obs_node_s] = obstacle_generation(shape,sl,el,r,sm)
    obs_nodes = [];
    obs_node_s = [];
    nsl = 0.8*sl;
    nel = 0.8*el;
    osl = 0.125*sl;
    oel = 0.125*el;
    shift = [1 1;-1 1;-1 -1;1 -1].*unifrnd(nsl,nel);
    shift_idx = 1:size(shift,1);
    if(shape(1))
        sz = fix(((oel(1) - osl(1))*2)/(r+sm))+1;
        x_side = linspace(osl(1),oel(1),sz)';
        y_side = linspace(osl(2),oel(2),sz)';
        square = [repelem(osl(1),sz,1) y_side;
                  x_side repelem(oel(2),sz,1);
                  repelem(oel(1),sz,1) flip(y_side);
                  flip(x_side) repelem(osl(2),sz,1)];
        rotate = unifrnd(0,2*pi);
        square = square*R(rotate);
        sh = randi(numel(shift_idx));
        square = move(square,shift(shift_idx(sh),:));
        shift_idx(sh) = [];
        obs_nodes = [obs_nodes ; square];
        obs_node_s(1).shape = square;
    end
    if(shape(2))
        sz = fix(4*pi*oel(2)/(r+sm))+1;
        n   = linspace(0,2*pi,sz);
        circle = oel(2)*([cos(n);sin(n)]');
        sh = randi(numel(shift_idx));
        circle = move(circle,shift(shift_idx(sh),:));
        shift_idx(sh)=[];
        obs_nodes = [obs_nodes ; circle];
        obs_node_s(2).shape = circle;
    end
    if(shape(3))
        sz = fix(((oel(1) - osl(1))*2)/(r+sm))+1;
        x_side_left = linspace(osl(1),(oel(1)-(oel(1)-osl(1))/2),sz)';
        x_side_right = linspace((oel(1)-(oel(1)-osl(1))/2),oel(1),sz)';
        x_side = linspace(osl(1),oel(1),sz)';
        y_side = linspace(osl(2),oel(2),sz)';
        triangle = [x_side_left y_side;
                    x_side_right flip(y_side);
                    flip(x_side) repelem(osl(2),sz,1)];
        rotate = unifrnd(0,2*pi);
        triangle = triangle*R(rotate);
        sh = randi(numel(shift_idx));
        triangle = move(triangle,shift(shift_idx(sh),:));
        shift_idx(sh) = [];
        obs_nodes = [obs_nodes ; triangle];
        obs_node_s(3).shape = triangle;
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

