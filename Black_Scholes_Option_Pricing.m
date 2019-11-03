%Option Pricing
%Kieran Hobden
%03-Nov-'19

%Option pricing from the Black-Scholes formula

%Initialise variables
K = 1;    %Strike price
S = 1.1;    %Spot price of the underlying asset
t = 0;      %Current date
T = 1;    %Expiration Date
r = 0.01;   %Risk free rate
sigma = 0.05;%Volatility of reutrns of the underlying asset

%Compute random component
d_1 = (log(S/K)+(r+sigma^2/2)*(T-t))/(sigma*sqrt(T-t));
d_2 = d_1-sigma*sqrt(T-t);

N = @(x) normcdf(x);

%Call Option C(S,t)
C = N(d_1)*S-N(d_2)*K*exp(-r*(T-t));

%Put Option P(S,t)
P = N(-d_2)*K*exp(-r*(T-t))-N(-d_1)*S;

%The Greeks
delta_call = N(d_1);
delta_put = -N(-d_1);
gamma = normpdf(d_1)/(S*sigma*sqrt(T-t));
vega = S*normpdf(d_1)*sqrt(T-t);
theta_call = -S*normpdf(d_1)*sigma/(2*sqrt(T-t))-r*K*exp(-r(T-t))*N(d_2);
theta_put = -S*normpdf(d_1)*sigma/(2*sqrt(T-t))+r*K*exp(-r(T-t))*N(-d_2);
rho_call = K*(T-t)*exp(-r(T-t))*N(d_2);
rho_put = -K*(T-t)*exp(-r(T-t))*N(-d_2);

%Output results
output = fopen('black_scholes_option_pricing.txt', 'w');
fprintf(output, '%13s %9s\n', 'Call', 'Put');
fprintf(output, '%s    ', 'Price');
fprintf(output, '%1.3e  %1.3e\n\n', C, P);
fprintf(output, '%s    ', 'Delta');
fprintf(output, '%1.3e  %1.3e\n', delta_call, delta_put);
fprintf(output, '%s    ', 'Gamma');
fprintf(output, '%1.3e  %1.3e\n', gamma, gamma);
fprintf(output, '%s     ', 'Vega');
fprintf(output, '%1.3e  %1.3e\n', vega, vega);
fprintf(output, '%s    ', 'Theta');
fprintf(output, '%1.3e  %1.3e\n', theta_call, theta_put);
fprintf(output, '%s      ', 'Rho');
fprintf(output, '%1.3e  %1.3e\n', rho_call, rho_put);
fclose(output);