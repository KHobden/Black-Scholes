%Fractional and Geometric Brownian Motion
%Kieran Hobden
%04-Nov-'19

clear all

%As variable names are re-used in code blocks, each block must be cleared

%% Wiener Process (standard Brownian process)

x = linspace(-5,5);

for t=0.25:0.25:5
   y = exp(-x.^2/(2*t))/sqrt(2*pi*t);
   plot(x,y,'b'), hold on
end

title('Wiener Process')
xlabel('x'); ylabel('f(t,x)');
hold off
pause(2)

clear
%% Brownian Motion (with drift)
%Initialise constants
mu = 0.15;
sigma = 0.2;
x0 = 0;

x = linspace(-0.5,2,200);

for t=0.25:0.25:5
   y = exp(-((x-x0-mu*t).^2)/(2*(sigma^2)*t))/(sigma*sqrt(2*pi*t));
   plot(x,y,'b'), hold on
end

title('Brownian Motion')
xlabel('x'); ylabel('f(t,x)');
xlim([-0.5 2]);
hold off
pause(2)

clear
%% Geometric Brownian Motion
%Initialise constants
mu = 0.15;
sigma = 0.2;
x0 = 1;
x = linspace(0,4,200);

for t=0.25:0.25:5
    for i=1:length(x)
        y(i) = exp(-((log(x(i))-log(x0)-(mu-0.5*sigma^2)*t)^2)/(2*(sigma^2)*t))/(sigma*x(i)*sqrt(2*pi*t));
    end
    plot(x,y,'b'), hold on
end

title('Geometric Brownian Motion')
xlabel('x'); ylabel('f(t,x)');
xlim([0 4]);
hold off
pause(2)

clear
%% Fractional Brownian motion - A faster approach
%Simulation shows the use of the wfbm function

%Set length of simulation
L = 1000;

%For Brownian motion, use a Hurst exponent of 0.5
fbm05 = wfbm(0.5,L,'plot');
pause(2)

%For fBm set H=[0,1] w/ H=/0.5
%H>0.5 => positive correlation
%H<0.5 => negative correlation

fbm03 = wfbm(0.3,L,'plot');
pause(2)
fbm07 = wfbm(0.7,L,'plot');