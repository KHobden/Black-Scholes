#European Call Option
#Kieran Hobden
#18-Jun-'20

import numpy as np
import matplotlib.pyplot as plt
import math
from scipy.integrate import quad

"""This programme produces the profit/loss diagram for a European Long Call Option as well as the value at maturation and
prior by using the solution to the Black-Scholes equation"""

#Set the strike price, asset price, expiry, interest rate, volatility and option cost
E = 1000
S = np.linspace(900, 1100, 100)
t = 0; T = 0.4
r = 0.05
sigma = 0.05
cost = 20

#Value the option
h  = np.maximum(S-E,0)

#Plotting the Black-Scholes value of the option
#Probability density function for normal distribution
def dN(x):
    return math.exp(-0.5*x**2)/math.sqrt(2*math.pi)
#Cumulative density function solved with quadrature rules
def N(d):
    return quad(lambda x: dN(x), -20, d, limit=50)[0]
#Define d1
def d1f(St, E, t, T, r, sigma):
    d1 = (math.log(St/E)+(r+0.5*sigma**2)*(T-t))/(sigma*math.sqrt(T-t))
    return d1
#Define Black_Scholes value of the option
def Black_Scholes_Value(St, E, t, T, r, sigma):
    d1 = d1f(St, E, t, T, r, sigma)
    d2 = d1-sigma*math.sqrt(T-t)
    value = St*N(d1)-math.exp(-r*(T-t))*E*N(d2)
    return value
#Evaluate
BS_values = [Black_Scholes_Value(i,E,t,T,r,sigma) for i in S]

#Setup subplot structure
fig = plt.figure('European Long Call Option')
ax1 = fig.add_subplot(211)
ax2 = fig.add_subplot(212)

#Produce a profit/ loss graph
ax1.plot(S, h-cost)
ax1.grid(True)
ax1.set_title('European Long Call Option')
ax1.set_xlabel(r'$S_{T}$ - Share price at expiry')
ax1.set_ylabel('Profit/ Loss')

#Produce a plot for the BS value 1 day before maturation and the value at expiry
ax2.plot(S,BS_values, label='B-S evaluation at T-t=0.4')
ax2.plot(S,h, label='Value at expiry')
ax2.set_xlabel(r'$S_{T}$ - Share price at expiry')
ax2.set_ylabel('Call Price C(S)')
ax2.legend()
ax2.grid(True)
plt.tight_layout()
plt.show()

