% Power consumption based on XFLR5 and Open Rocket
Power_from_complex = [0    1.3701    4.9406   12.1782   21.5741   36.6458   57.6338...
     82.5134  118.6952  162.6358  214.3570  273.6799  355.311 432.5526  540.2476  634.9943];

 % Power Consumption of the Body
 Body_Power = [0    0.0072    0.0481    0.1478    0.3265    0.6069    1.0200    1.6029...
     2.3923    3.4094    4.6762    6.2233    8.0799    10.2730   12.8305   15.7807];
 
 % Power Consumption of the Wing
 Wing_Power = [0    1.3629    4.8926   12.0304   21.2477   36.0389   56.6138   80.9106...
     116.3030  159.2264  209.6808  267.4566  347.2314   422.2797  527.4171  619.2136];
 
 % Power consumption based on standard values and simple calculations
 Power_from_simple = 1000 * [ 0    0.0004    0.0032    0.0108    0.0256    0.0500    0.0864...
     0.1371    0.2047    0.2914    0.3998    0.5321    0.6908 0.8783    1.0970    1.3492];
 
 % Velocitys that they are plotted over
 Velocitys = [0     2     4     6     8    10    12    14    16    18    20    22    24    26    28    30];