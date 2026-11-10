%% Q1
subplot(3,1,1)
plot (data1(: , 1) , data1(: , 2))
title('Step Response of the Transfer Function with Proportional Gain')
xlabel('Time')
ylabel('Amplitude')
grid minor 
subplot(3,1,2)
plot(data2(: , 1), data2(:,2))
title('Step Response of the Transfer Function with PI controller')
xlabel('Time')
ylabel('Amplitude')
grid minor 
subplot(3,1,3)
plot(data3(: , 1), data3(: , 2))
title('Step Response of the Transfer Function with PID Controller')
xlabel('Time')
ylabel('Amplitude')
grid minor 
%% Q1-SISOTOOL
s = tf('s');
H = (0.049*s^2+0.0067*s+2.991)*exp(-5*s)/(s^3+0.343*s^2+17.65*s+1.009);

%% Q2
s=tf('s');
G=(6.1943*(s+0.2107)*(s+0.01504)*(s^2+0.8979*s+33.21)*(s^2+2.04*s+129.3))/((s+0.02543)*(s+0.5913)*(s+86.25)*(s^2+0.3491*s+15.61)*(s^2+1.47*s+81.23));
s = tf('s');
r = rand(3,100);
Kp = 5*r(1,:);
Ti = 7*r(2,:);
Td = 2*r(3,:);

for i = 1:100
   Gs(i)=Kp(i)*(1 + 1/(Ti(i)*s) + (Td(i)*s));
   H(i) = (Gs(i)*G) / (1 + Gs(i)*G);
   [y t] = step(H(i));
   Y = length(y);
   e(i) = 1 - y(i);
   for j = 1:Y
    IAE(i) = sum(abs(e(i)));
    ISE(i) = sum(abs(e(i)) ^ 2);
    ITAE(i) = sum(t( i) * abs(e(i)));
    ITSE(i) = sum(t( i) * abs((e(i)) ^ 2));
   end
end
[value1, index1] = min(IAE);
[value2, index2] = min(ISE);
[value3, index3] = min(ITAE);
[value4, index4] = min(ITSE);
figure
step(H(index1))
title('the best PID controller considering the IAE minimum value')
grid minor
figure
step(H(index2))
title('the best PID controller considering the ISE minimum value')
grid minor
figure 
step(H(index3))
title('the best PID controller considering the ITAE minimum value')
grid minor 
figure
step(H(index4))
title('the best PID controller considering the ITSE minimum value')
grid minor 

%% Q4
plot (data(: , 1) , data(: , 2))
title('The Transfer Function with the Acquired PID Parameters')
xlabel('Time(s)')
ylabel('Amplitude')
grid minor 

%% Q5
subplot (2,2,1)
plot (dataout1(: , 1), dataout1(: , 2))
title('First Case Output')
xlabel('Time(s)')
ylabel('Amplitude')
xlim([-1 100])
ylim([0 1.5])
grid minor 
subplot(2,2,2)
plot(control1(: , 1), control1(:, 2))
title('First Case Control')
xlabel('Time(s)')
ylabel('Amplitude')
xlim([0 100])
ylim([0 15])
grid minor 
subplot(2,2,3)
plot(dataout2(:,1),dataout2(:,2))
title('Second Case Output')
xlabel('Time(s)')
ylabel('Amplitude')
xlim([-1 100])
ylim([0 1.5])
grid minor 
subplot(2,2,4)
plot(control2(:,1),control2(:,2))
title('Second Case Control')
xlabel('Time(s)')
ylabel('Amplitude')
xlim([-1 50])
ylim([0 300])
grid minor 