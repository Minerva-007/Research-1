clear
clc

Vb=input('Enter the battery Voltage');
Vc=input('Enter the potential to which the capacitor will be charged');
C=input('Enter capacitance of the capacitor');
Rb=input('Enter internal resistance of the battery');
Rc=input('Enter internal resistance of the capacitor');
R=input('Enter the Resistance of the external load');

t=0:(Rb+2*Rc+R)*C/1000:(Rb+2*Rc+R)*C;   %Time of simulation, take 1000 samples
figure
hold on
%Current in a battery: Always nearly constant as given by R+r=dV/dI
plot([0,(Rb+2*Rc+R)*C],[Vb/(Rb+R),Vb/(Rb+R)]);
%Current in a capacitor: Varies with if it is charging or discharging.
%Q=Q0*e^(-t/(R+r)C); Q0=CVc is maximum charge storable.
%Q=CVc*e^(-t/(R+r)C); Take time derivative.
%I=dQ/dt=Vc/(R+r)*e^(-t/(R+r)C);
%Ic=Vc/(Rb+Rc) * 2.718.^(-t/(Rb+Rc)/C);
%plot(t,Ic);
Ic=Vc/(R+Rc) * 2.718.^(-t/(R+Rc)/C);
plot(t,Ic);
title('Current-time graphs');
legend('Case I', 'Case II discharging');
fprintf('Time constant for Charging is %f and for Discharging is %f\n',(Rb+Rc)*C, (R+Rc)*C);
fprintf('Time taken to reach given voltage in charging=%f\n;',-log(1-Vc/Vb)*(Rb+Rc)*C);

figure
%Voltage of a battery= Depends on the current drawn from it, as E=V+Ir
plot([0,(Rb+2*Rc+R)*C],[Vb-Vb*Rb/(Rb+R),Vb-Vb*Rb/(Rb+R)]);
hold on
%Voltage of a capacitor= Varies if it is charging or discharging.
Vt=Vb*(1-2.718.^(-t/(Rb+Rc)/C));
plot(t,Vt);
Vt=Vc*2.718.^(-t/(Rc+R)/C);
plot(t,Vt);
title('Voltage-time graphs');
legend('Case I', 'Case II charging', 'Case II Discharging');

figure
hold on
%Power output is same for both scenarios: P(t)=I(t)*V(t)
%In case of batteries, it is nearly constant.
plot([0,(Rb+2*Rc+R)*C],[Vb.^2*R/(R+Rb).^2,Vb.^2*R/(R+Rb).^2]);
%For a capacitor, power output varies with time.
Pt=Ic.*Vt;
plot(t,Pt);
title('Power output graphs');
legend('Case I', 'Case II');
