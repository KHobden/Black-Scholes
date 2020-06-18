# Quantitative-Finance
Quantitative Finance Basics

Begin by reading the paper "The Market Price of Interest-Rate Risk" by Ahmad and Wilmott which shows the behaviour of US interest rates follows a lognormal random walk between 1982 and 2006.
Using the same analysis, we show in US_interest_rates.m the lognormal behviour has pertained until the current date (late 2019).
We have attached the file US_interest_rates.csv containing interest rate data although this can be downloaded as in US_interest_rates.m

Observing the large range in beta implies a need to understand Fractional Brownian Motion (fBm) and this is done in fractional_brownian_motion.m

Next, we follow the Black-Scholes methodology and derive an Option Pricing algorithm which is implemented in Black_Scholes_Option_Pricing.m although the derivation is not yet included.
Results are shown in black_scholes_option_pricing.txt including the corresponding Greeks.

The repository is currently incomplete but should be completed by February 2020.
