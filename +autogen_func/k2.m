function k2 = k2(qN)
%K2
%    K2 = K2(QB1,QB2,QN)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    27-Nov-2018 18:23:13

t2 = qN.^2;
t3 = t2.^2;
k2 = sin(qN.*4.09989700010116e-2+t2.*3.708933218415968e-1+t3.*1.313290086870686e-1-qN.*t2.*2.112513582720696+qN.*t3.*1.018662501650811e1-t2.*t3.*2.093315400356285e1+qN.*t2.*t3.*1.141188754230027e1-2.628405923403671).*-4.905e1+sin(qN.*1.463462098583827+t2.*3.193962441550849-t3.*2.438075235510159-qN.*t2.*4.832990550014584+qN.*t3.*1.073891286138702e1-t2.*t3.*2.338261548689675e1+qN.*t2.*t3.*6.948663464297745-3.486139163252662e-1).*2.4525e1+sin(qN).*3.18825e2;