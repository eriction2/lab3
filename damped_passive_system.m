%% Task 1.1

s = tf('s');

damping_opt = 1;
excitation_opt = 3;
m_p = 0.16;
%c_p = 0.4; % underdamped
%c_p = 0; % no damping
k_p = 6.32;

switch(damping_opt)
    case 1
        c_p = 0.4;
    case 2
        c_p = 2*sqrt(k_p*m_p);
    case 3
        c_p = 2*2*sqrt(k_p*m_p);
end


zeta = c_p/(2*sqrt(k_p*m_p));
omega_n =  sqrt(k_p/m_p);


G_dis = (2*zeta*omega_n*s+omega_n^2)/(s^2 + 2*zeta*omega_n*s+omega_n^2);
%figure(1);
%bode(G_dis)
%grid on
figure(2);

switch(excitation_opt)
    case 1
        use_step = 1;
        sim damped_sys1
    case 2
        use_step = 0;
        sim damped_sys1
    case 3
        
end
if excitation_opt < 3
    plot(z_p.Time,z_p.Data,'Color','r','LineWidth',1.5,'DisplayName','Output');
    hold on
    plot(ref.Time,ref.Data,'Color','k','LineWidth',1.1,'DisplayName','Input');
    legend('show','Location','NorthEast');
    xlabel('Time [sec]');
    ylabel('Displacement [m]');
    grid on;
else
    n = 1000;
    omega = linspace(0,25,n);%logspace(-3,3,n);%linspace(0.001,100,10000);
    Sw_spatial = 4.028*10^(-7)./(2.88*10^(-4)+0.68.*omega.*omega+omega.*omega.*omega.*omega);
    Sw = 1/50*Sw_spatial;
    H = abs(((2*zeta*omega_n*1i.*omega+omega_n^2)./(1i.*omega.*1i.*omega + 2*zeta*omega_n*1i.*omega+omega_n^2)));
    Sp = H.^2.*Sw;
    loglog(omega,Sp,'DisplayName','S_p');
    xlim([omega(1) omega(n)])
    grid on;
    legend('show','Location','NorthEast');
    xlabel('Frequency [rad/s]');
    ylabel('Energy ');
end
