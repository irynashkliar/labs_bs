import pandas as pd
from scipy.stats import norm
from math import sqrt


N = 31989
z_alpha = norm.ppf(0.975)

# strata 1
df1 = pd.read_csv('new1.txt', delimiter=r'\s+')
N1 = 9089
n1 = 57

cable_var1 = df1['4'].var()
y1 = df1['4'].mean()
print("y1 =", y1)


# strata 2
df2 = pd.read_csv('new2.txt', delimiter=r'\s+')
N2 = 22900
n2 = 143

cable_var2 = df2['4'].var()
y2 = df2['4'].mean()
print("y2 =", y2)



D = ( (1 - n1/N1)*cable_var1*N1**2 )/(n1*N**2) + ( (1 - n2/N2)*cable_var2*N2**2 )/(n2*N**2)
print(D)



y = 10.648
lower_price = y - z_alpha * sqrt(D)
upper_price = y + z_alpha * sqrt(D)
print(f"95% довірчий інтервал для середньої ціни за кабельне ТБ: ({lower_price:.2f}, {upper_price:.2f})")
