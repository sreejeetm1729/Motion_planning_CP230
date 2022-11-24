%% Team 8
% main code for k-color robot motion planning problem in this version we
% are only considering translating disc robots and k = 1 case.
%% Initializations
clc,clear;
m = 7;                         % # of robots
n = 7;                         % # of nodes in pumped configuration
M = 10;
g = 2;                          % # of pumped graphs
q = 500;
mu = 150;                       % maximum # of single robot configurations
start_lim = [-30 -30];
end_lim = [30 30];
Start = [linspace(start_lim(1)+4,end_lim(1)-4,M)' repelem(sl(2)+4,M,1)];
Terminal = [linspace(start_lim(1)+4,end_lim(1)-4,M)' repelem(el(2)+4,M,1)];
robot_radius = 1;
safety_margin = 0.1;
[obs_nodes ,obs_node_s] = obstacle_generation([1 1 1],start_lim,end_lim,robot_radius,safety_margin);
ds = numel(min(start_lim):(2*robot_radius+safety_margin):max(end_lim))+1;
% un_Roadmap_Graph = struct('Vertices',[],'Edges',[]); % unconnected roadmap
% Start = [unifrnd(start_lim(1),end_lim(1),m,1) unifrnd(start_lim(2),end_lim(2),m,1)];
% Terminal = [unifrnd(start_lim(1),end_lim(1),m,1) unifrnd(start_lim(2),end_lim(2),m,1)];
% [Start, ~] = shape_generation(start_lim,end_lim,m,robot_radius,safety_margin,[0 0 0 1]);
% Start = Start - [24 0];
% [Terminal, ~] = shape_generation(start_lim,end_lim,m,robot_radius,safety_margin,[0 0 1 0]);
% Terminal = Terminal+[24 0];
%% Generating Pumped Configuration Graphs
[Roadmap_Graph, Pebble_Graph] = Pre_Process(un_Roadmap_Graph,g,q,n,mu,m,start_lim,end_lim,robot_radius,safety_margin,ds,obs_nodes);
Path = Query(Start,Terminal,Pebble_Graph,Roadmap_Graph,q,mu,m,robot_radius,safety_margin,ds,obs_nodes);
%% Trajectory Generation
if(~isempty(Path))
    disc_steps = 100;
    intervals = size(Path,3)-1;
    Traj = [];
    for i = 1:intervals
        step_array = (Path(:,:,i+1)-Path(:,:,i))/(disc_steps-1);
        j = (i-1)*disc_steps + 1;
        for k = j:j+disc_steps-1
            Traj(:,:,k) = Path(:,:,i) + (k-j)*step_array;
        end
    end
end
%% Visualization
if(~isempty(Path))
   animate(Path,Traj,start_lim,end_lim,robot_radius,m,obs_node_s);
end