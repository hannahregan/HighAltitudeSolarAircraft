%Adapted from 'unpack_params.m', Author: Chris Hann
%Adapted by Aidan Ogilvie
%Date: 7-05-2020

d_ref=params(1); d1_CB=params(2); d2_CB=params(3); 
L_nose=params(4); L_body=params(5); L_CB=params(6);
aoa=params(7);

% L_nose - length of nose cone
% d_ref - rocket reference diameter
% L_body1 - length of main body                                       
% L_body2 - length of end body tube
% L_CB - length of conical boattail   
% d1_CB, d2_CB - initial and final diameter of the conical tail
% aoa - Angle of attack