#Euler-Maruyama Method
#Kieran Hobden
#28-Oct-'19

#In Ito calculus, the E-M method provides an approximate numerical solution for an SDE.
#We implement it here to solve the Ornstein-Uhlenbeck process (a temporally homogenous Markov and Gaussian process)
#dx_t = -theta*x_t*dt + sigma*dW_t

import numpy as np
import matplotlib.pyplot as plt

#Initialise variables
num_trials = 5
x_0 = 0
t_0, t_N  = 3, 7
N = 1000
dt = float(t_N - t_0) / N 

 #Constants for Ornstein-Uhlenbeck process
theta = 0.7
mu = 1.5
sigma = 0.06

#Define the Ornstein-Uhlenbeck SDE incl. random component
def sde(x_t, dt):
    dW = np.random.normal(loc = 0.0, scale = np.sqrt(dt))
    return x_t + theta * (mu - x_t) * dt + sigma * dW
 
ts    = np.arange(t_0, t_N, dt)
xs    = np.zeros(N)
xs[0] = x_0

 #Run algorithm
for _ in range(num_trials):
    for i in range(1, ts.size):
        t = (i-1) * dt
        x_t = xs[i-1]
        xs[i] = sde(x_t,dt)
    plt.plot(ts, xs)

plt.title("Ornstein-Uhlenbeck Process (theta={theta}, mu={mu}, sigma={sigma})".format(theta=theta, mu=mu, sigma=sigma))
plt.xlabel("t")
plt.ylabel("x")
plt.show()
