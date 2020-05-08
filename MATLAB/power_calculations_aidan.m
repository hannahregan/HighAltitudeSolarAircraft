%% %Author: Aidan Ogilvie
%% %Date: 7-05-2020
%% %Purpose: to calculate the minimum speed and power requirements of the
%% %         glider configuration defined for our FYP

clear all; close all; clc;

%% %%%% DEFINE GLIDER GEOMETRY %%%%
d_ref=0.090; %main diameter of body
d1_CB=d_ref; %start diameter of conical boattail (likely same as d_ref)
d2_CB=0.012; %end diameter of CB
L_nose=0.300; %lengths
L_body=0.300; 
L_CB=0.282;
aoa=0; %angle of attack %CURRENTLY UNUSED%
wingspan = 6;
wing_depth = 0.3; %dist. from front of wing to back
weight = 7;

Aref_body=pi*(d_ref/2)^2;

%%%% FLIGHT CONDITIONS %%%%
rho_air = 1.225;
v_range=[0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30]; %velocity, m/s
v_sound=340.3;

%% %%%% AERODYNAMICS CALCULATOR OUTPUT %%%%
Mach_range = v_range/v_sound;
Cd_body_values = zeros(1,length(Mach_range));
for i=1:1:length(Mach_range)
    % only using 'Cd_body_values' at this time
    [Xcp,Xcp_nose,Xcp_CB,Cn,Cn_nose,Cn_CB,Cd_body_values(i),L_total]=simplified_find_aero([d_ref,d1_CB,d2_CB,L_nose,L_body,L_CB,aoa],Mach_range(i));
end

%% %%%% SET WING VALUES FROM XFLR5 %%%%
Cd_wing_values = [0,0.12,0.084,0.055,0.044,0.034,0.030,0.028,0.026,0.024,0.023,0.023,0.022,0.022,0.021,0.021];
Aref_wing=wingspan*wing_depth;
Cl = 0.804;

%%%% MINIMUM VELOCITY CALCULATION %%%%
v_min = sqrt(weight*9.81*2/(Cl*rho_air*Aref_wing));

% from XFLR5 again
Cd_wing_min = 0.040;
% only using 'Cd_body_min' at this time
[Xcp,Xcp_nose,Xcp_CB,Cn,Cn_nose,Cn_CB,Cd_body_min,L_total]=simplified_find_aero([d_ref,d1_CB,d2_CB,L_nose,L_body,L_CB,aoa],v_min/v_sound);

Power_min = (0.5*Cd_body_min*rho_air.*Aref_body*v_min^3)+(0.5*Cd_wing_min*rho_air*Aref_wing*v_min^3);

%% %%%% DRAG FORCE CALCULATION %%%%

Fd_body = 0.5.*Cd_body_values.*rho_air.*Aref_body.*v_range.^2;
Power_req_body = Fd_body.*v_range;

Fd_wing = 0.5.*Cd_wing_values.*rho_air.*Aref_wing.*v_range.^2;
Power_req_wing = Fd_wing.*v_range;

Power_req_total = Power_req_wing+Power_req_body;


%% %%%% PLOT POWER OVER VELOCITY %%%%
figure
hold on
%legend placeholder
ph=plot(0,0,'k-',0,0,'k--',0,0,'k-.');
% plot Aidan's values
p_Aidan=plot(v_range, Power_req_total,'-','Color','#70BC30');
plot(v_range,Power_req_wing,'--','Color','#70BC30')
plot(v_range,Power_req_body,'-.','Color','#70BC30')
plot(v_min,Power_min,'*','Color','#70BC30')

%%%% LOAD TEAMMATES' VALUES %%%%
%plot George's values
GeorgeValues
p_George=plot(Velocitys,Power_from_complex,'b',Velocitys,Wing_Power,'b--',Velocitys,Body_Power,'b-.');
%plot Hannah's values
hannahsResults
p_Hannah=plot(velocity,Power_hannah,'-','Color','#DDB120');
plot(velocity,Power_wing_hannah,'--','Color','#DDB120')
plot(velocity,Power_body_hannah,'-.','Color','#DDB120')
%plot Luke's values
Luke

legend([p_Aidan p_George(1) p_Luke(1) p_Hannah ph(1) ph(2) ph(3)],...
    {'Aidan','George','Luke','Hannah','Total','Wing','Body'})
title('Power Requirements of our glider for level flight, calculated by each group member. AoA=0 degrees')
xlabel('Velocity (m/s)')
ylabel('Power (W)')
xlim([0,15]) % advised by client that likely only up to 15m/s is relevant

%% %%%% PLOT DIFFERENCE TO AVERAGE %%%%
hold off
figure
hold on
% remove Luke's interpolation
total_P_short=total_P(1:200:3001);
wing_P_short=wing_P(1:200:3001);
body_P_short=body_P(1:200:3001);


%%%% CALCULATE AVERAGES AND DIFFERENCES
t_avg=(Power_hannah+total_P_short+Power_req_total+Power_from_complex)./4; % total average
w_avg=(Power_wing_hannah+wing_P_short+Power_req_wing+Wing_Power)./4; % wing average
b_avg=(Power_body_hannah+body_P_short+Power_req_body+Body_Power)./4; % body average
t_diff_h=((Power_hannah-t_avg)./t_avg)*100;         % total percentage difference % hannah's differences
w_diff_h=((Power_wing_hannah-w_avg)./w_avg)*100;    % wing percentage difference
b_diff_h=((Power_body_hannah-b_avg)./b_avg)*100;    % body percentage difference
t_diff_a=((Power_req_total-t_avg)./t_avg)*100;      % aidan's differences
w_diff_a=((Power_req_wing-w_avg)./w_avg)*100;
b_diff_a=((Power_req_body-b_avg)./b_avg)*100;
t_diff_g=((Power_from_complex-t_avg)./t_avg)*100;   % george's differences
w_diff_g=((Wing_Power-w_avg)./w_avg)*100;
b_diff_g=((Body_Power-b_avg)./b_avg)*100;
t_diff_l=((total_P_short-t_avg)./t_avg)*100;        % luke's differences
w_diff_l=((wing_P_short-w_avg)./w_avg)*100;
b_diff_l=((body_P_short-b_avg)./b_avg)*100;


%plot percentage differences
%legend placeholder for average graph
ph_a=plot(0,0,'k-',0,0,'k--',0,0,'k-.');
plot([0,30],[0,0],'Color','#AAAAAA')
% plot Aidan's values
p_A_a=plot(v_range, t_diff_a,'-','Color','#70BC30');
plot(v_range,w_diff_a,'--','Color','#70BC30')
plot(v_range,b_diff_a,'-.','Color','#70BC30')
% plot George's values
p_G_a=plot(v_range, t_diff_g,'b-');
plot(v_range,w_diff_g,'b--')
plot(v_range,b_diff_g,'b-.')
% plot Hannah's values
p_H_a=plot(v_range, t_diff_h,'-','Color','#DDB120');
plot(v_range,w_diff_h,'--','Color','#DDB120')
plot(v_range,b_diff_h,'-.','Color','#DDB120')
% plot Luke's values
p_L_a=plot(v_range, t_diff_l,'r-');
plot(v_range,w_diff_l,'r--')
plot(v_range,b_diff_l,'r-.')

legend([p_A_a p_G_a p_L_a p_H_a ph_a(1) ph_a(2) ph_a(3)],...
    {'Aidan','George','Luke','Hannah','Total','Wing','Body'})
title('Percentage difference to average values for power consumption split by component')
xlabel('Velocity (m/s)')
ylabel('Power Difference to Average (%)')