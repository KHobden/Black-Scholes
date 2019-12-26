%SDE Fitting - US Interest Rates
%Kieran Hobden
%26-Dec-'19

%Import US interest rate data from 2003 to present
%Resource at https://fred.stlouisfed.org/series/INTDSRUSM193N
interest_rates = importdata('US_interest_rates.csv');

%Determine r and dr for the data
r = interest_rates.data;
delta_r = zeros(1,length(r)-1);
for i=1:length(r)-1
    delta_r(i) = b(i+1)-b(i);
end

%Find the expectation value of r and dr over an interval of 10 months
r_expectation = zeros(1,10);
dr_expectation = zeros(1,10);
for i=1:10
    for j=1:20
        dr_expectation(i) = dr_expectation(i)+delta_r((i-1)*20+j).^2;
        r_expectation(i) = r_expectation(i)+r((i-1)*20+j);
    end
end
r_expectation = r_expectation/20;
dr_expectation = dr_expectation/20;

%Plot ln(E[dr^2]) against ln(E[r]) to determine the drift term of our SDE
%Accompanying literature shows the gradient is 2*beta where our drift term
%is of the form vr^beta
%Note we need to drop the 6th and 7th point in our scatter as these occur
%at infinity and prevent polyfit from working
%We also drop our outlier, the 4th point
x = log(r_expectation([1:3 5 8:10]));
y = log(dr_expectation([1:3 5 8:10]));
scatter(x,y), hold on
title('Finding the Drift Term')
xlabel('$$\ln(E[r])$$','interpreter','latex')
ylabel('$$\ln(E[dr^{2}])$$','interpreter','latex')
p = polyfit(x,y,1);
bestfit = -0.4:0.05:1.8;
plot(bestfit, p(1)*bestfit+p(2)), hold off

%We find beta = 0.8 which suggests interest rates follow a lognormal random
%walk (beta~1)
beta = p(1)/2

%This corresponds to the results in "The Market Price of Interest-rate Risk
%: Measuring and Modelling Fear and Greed in the Fixed-income Markets"
%where low interest rates corresponded to a smaller beta with the average
%centered on 1 and lognormal behaviour exhibited.