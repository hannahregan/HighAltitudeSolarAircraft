%Adapted from 'find_aero.m', Author: Chris Hann
%Adapted by Aidan Ogilvie
%Date: 7-05-2020

function [Xcp,Xcp_nose,Xcp_CB,Cn,Cn_nose,Cn_CB,Cd,L_total]=simplified_find_aero(params,M)

% nose cone
simplified_unpack_params

Aref=pi*(d_ref/2)^2;     %circle area: i.e. 0 aoa

%Bodytube%%%%%%%%%%%%%%%%%%%%
L_total_body=L_nose+L_body;
r=d_ref/2;
rho=(L_nose^2+r^2)/(2*r);

A_wet_nose=2*pi*rho*( (r-rho)*asin(L_nose/rho)+L_nose);

A_wet_body=pi*d_ref*(L_body);


% Conical Boattail

S1_CB=pi*d1_CB^2/4; S2_CB=pi*d2_CB^2/4;
Cn_CB=8/(pi*d_ref^2)*(S2_CB-S1_CB);
Xcp_CB=L_total_body+L_CB/3*(1+1/(1+d1_CB/d2_CB));
alpha=(d1_CB-d2_CB)/d1_CB; 
dX_CB=L_CB*((1-alpha)/(2-alpha)+0.92*(exp(0.17*alpha^3.73)-1));
Xcm_CB=L_total_body+dX_CB;
A_wet_CB=pi*(d1_CB+d2_CB)/2*L_CB;

L_total=L_total_body+L_CB;

%% Compute all of the Barrowman values including drag
Cn_nose=2; % all shapes of nose cones
Xcp_nose=0.466*L_nose;
Cn=Cn_nose+Cn_CB; 
Xcp=1/Cn*(Cn_nose*Xcp_nose+Cn_CB*Xcp_CB); 

% drag calculations

% boat tail considerations
A_b=pi*(d2_CB/2)^2; 
L_b=(L_total_body-L_nose)+2/3*L_nose;

Rs=60e-6; % roughness height
% base drag
%assume M<1
Cd_base=(d2_CB/d1_CB)^2*(0.12+0.13*M^2);
% Cd_base=0.2926*sqrt(d_ref./L_b)*(A_b/Aref)^2.5; % this is aerolab


% MM0=1;
% if M<MM0
%     Cd_base=(d2_CB/d1_CB)^2*(0.12+0.13*M^2);
%     % Cd_base=0.2926*sqrt(d_ref./L_b)*(A_b/Aref)^2.5; % this is aerolab
%     % formula for subsonic base drag
% else
%     Cd_base=(d2_CB/d1_CB)^2*0.25/M;
% end

%assume M<1
Cf=0.032*(Rs/d_ref)^0.2;
Cfc=Cf*(1-0.12*M^2); %assuming roughness
% if M<MM0
%     Cfc=Cf*(1-0.12*M^2); %assuming roughness
% else
%     Cfc=Cf/(1+0.18*M^2);
% end

fB=L_total/d_ref; % fineness ratio

Cd_nose=Cfc*(1+1/(2*fB))*A_wet_nose/Aref;
Cd_body=Cfc*(1+1/(2*fB))*A_wet_body/Aref;
Cd_CB=Cfc*(1+1/(2*fB))*A_wet_CB/Aref;
Cd_friction = Cd_body+Cd_nose+Cd_CB;
[Cd_base,Cd_CB];
Cd=Cd_base+Cd_friction;
%%

