%% Task 1.1
clear all;
s = tf('s');
close all;
m = 22000;
J = 700000;
c = 40000;
c1 = c;
c2 = c;
k = 600000;
k1 = k;
k2 = k;
L = 6;
L1 = L;
L2 = L;
c_z = -1;
c_X = -1;
exictation = 1;
f = 1.1792;
run_time = 6;


A = [0 1 0 0;
    -(k1+k2)/m -(c1+c2)/m 0 0;
    0 0 0 1;
    %0 0 -2*L/J -2*L/J];
(L1*k1+L2*k2)/J (L1*c1+L2*c2)/J 0 0];
B = [0 0 0 0;
    k1/m c1/m k2/m c2/m;
    0 0 0 0;
    %-L1*k1/J -L1*c1/J +L2*k2/J +L2*c2/J];
    -L1*k1/J -L1*c1/J -L2*k2/J -L2*c2/J];
C = [1 0 0 0;
    0 0 1 0];
D = [0 0 0 0
    0 0 0 0];


sim chassis_passive_sim

% 
% A = [0 1 0 0;
%     -(k1+k2)/m 0 0 0;
%     0 0 0 1;
% (L1*k1+L2*k2)/J 0 0 0];
% B = [0 0 0 0;
%     k1/m k2/m 1/m 1/m;
%     0 0 0 0;
%     -L1*k1/J -L2*k2/J -L1/J -L2/J];
% C = [0 1 0 0;
%     0 0 0 1];
% D = [0 0 0 0
%     0 0 0 0];
Ask=[0 1 0 0
    -2*k/m 0 0 0
    0 0 0 1
    0 0 -2*k*L^2/J 0];
Bsk=[0 0 0 0
    k/m k/m -1/m -1/m
    0 0 0 0
    -L*k/J L*k/J L/J -L/J];
Csk=[0 1 0 0
    0 0 0 1];
Dsk=zeros(2,4);



G_ss = ss(A,B,C,D);


sim chassis_skyhook_sim




plot(z_SH.Time,z_SH.Data,'Color','r','LineWidth',1.5,'DisplayName','Y1 for Skyhook');
hold on;
plot(z_pas.Time,z_pas.Data,'Color','b','LineWidth',1.5,'DisplayName','Y1 for passive');
legend('show','Location','NorthEast');
xlabel('Time [sec]');
ylabel('Displacement [m]');
grid on;
figure;
plot(X_SH.Time,X_SH.Data,'Color','r','LineWidth',1.5,'DisplayName','Y2 for Skyhook');
hold on;
plot(X_pas.Time,X_pas.Data,'Color','b','LineWidth',1.5,'DisplayName','Y2 for passive');
legend('show','Location','NorthEast');
xlabel('Time [sec]');
ylabel('Angle [rad]');
grid on;
%figure;
%bode(G_ss(1,1))
grid on;


%Fa1 Fa2
figure;
plot(Fa1.Time,Fa1.Data,'Color','r','LineWidth',1.5,'DisplayName','Fa1');
hold on;
plot(Fa2.Time,Fa2.Data,'Color','b','LineWidth',1.5,'DisplayName','Fa2');
legend('show','Location','NorthEast');
xlabel('Time [sec]');
ylabel('Force [N]');
grid on;
%figure;
%bode(G_ss(1,1))
grid on;