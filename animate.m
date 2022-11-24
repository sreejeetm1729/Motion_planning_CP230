function animate(Path,Traj,sl,el,r,m,obs_node_s)
    %% Settings
    colors = [1 0 0];
    
    %% Create link shape
    shape = disc(r);
    
    %% Objects
    clf
    animationfig = figure(3);
    set(animationfig,'color','w','paperpositionmode','auto','position',[461   145   701   414]);
    AxesHandle = axes('Parent',animationfig,  'Position',[0 0 1 1]);
    
    robot = [];
    for i = 1:m
        robot(i) = patch('Parent',AxesHandle, 'FaceColor',colors(1,:),'facealpha',0.7);
%        path(i) = line('Parent',AxesHandle,'linestyle','--','Color',[0 0.2 0]);
    end
    
    if(~isempty(Path))
        Start_Vertices = line('Parent',AxesHandle,'MarkerFaceColor',[0 1 0],'Marker','o','MarkerSize',5,'linestyle','none');
        Terminal_Vertices = line('Parent',AxesHandle,'MarkerFaceColor',[0 0 1],'Marker','o','MarkerSize',5,'linestyle','none');
    end
    
    box on;
    axis off;
    axis([sl(1)-r el(1)+r sl(2)-r el(2)+r])
    %% Obstacles
    obstacles = [];
    if(~isempty(obs_node_s))
        for i=1:size(obs_node_s,2)
            obstacles(i) = patch('Parent',AxesHandle, 'FaceColor','m','facealpha',0.7);
        end
    end
    %% Animation
    
    p1=[];
    p2=[];

    if(~isempty(Path))
        xs = Path(:,1,1);
        ys = Path(:,2,1);
        xt = Path(:,1,size(Path,3));
        yt = Path(:,2,size(Path,3));
        set(Start_Vertices,'Xdata',xs,'Ydata',ys);
        set(Terminal_Vertices,'Xdata',xt,'Ydata',yt);
    end
    
    % obstacle positions
    if(~isempty(obs_node_s))
        for i=1:size(obs_node_s,2)
            set(obstacles(i),'Xdata',obs_node_s(i).shape(:,1),'Ydata',obs_node_s(i).shape(:,2));
        end
    end
    
    
    n=0;
    while n<size(Traj,3)
    n=n+1;    
        
        % state vector
        p1 = Traj(:,1,n);
        p2 = Traj(:,2,n);
        
        % bot positions
        for i = 1:m
            pos = move(shape,[p1(i) p2(i)]);
            set(robot(i),'Xdata',pos(:,1),'Ydata',pos(:,2));
        end
        
        drawnow
        axis equal
        pause(0.1);
    end
end


function shape = disc(r) %creates an arm/link with the ends being semi-circles
    n   = linspace(0,2*pi,20);
    shape = r*[cos(n);sin(n)]';
end

% function rot = R(phi)
% rot = [cos(phi)  -sin(phi);
%        sin(phi)   cos(phi)];
% end
   
function c = move(a, b)
    c(:,1) = a(:,1) + b(1);
    c(:,2) = a(:,2) + b(2);
end