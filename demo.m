ee = 0.1;
f = @(x,y,t) ee*sin(omega*t).*x.^2 + (1-2*ee*sin(omega*t)).x;


u = @(x,y,t) 
