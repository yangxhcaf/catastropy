mu=1/50;
R=16;
gamma = 365/13; 
b = R*(mu+gamma);
k = 500;
delta = 5e-4;
w = @(t) t*delta/25;

step = 0.0025;
T0 = 0; TF = 25;
T = T0:step:TF;


system =@(t,y)...
    [mu*(1-y(3))-b*y(1)*y(2)-mu*y(1);... %S
     b*y(1)*y(2)-gamma*y(2)-mu*y(2);... %I
     k*y(3)*(1-y(3))*(-w(t)+y(2)+delta*(2*y(3)-1))]; %x
 
y0 = [0.010 0.0000 0.9900];

sigma = 0.01;
G = @(t,y) sigma*[1;1e-4;1];

ops = sdeset('SDEType','Ito','ConstGFUN','yes','NonNegative','yes','randseed',0);

y = sde_euler_bounded(system,G,T,y0,ops);

plot(T,y(:,3) )

ylim([0.8,1])

data = [T',y(:,3)];

csvwrite('data.csv',data)


