import pandas as pd
from scipy.stats import norm
from math import sqrt


N = 31989
# y = 8.925 для n=200
z_alpha = norm.ppf(0.975)

# strata 1
df1 = pd.read_csv('s2_1.txt', delimiter=r'\s+')
N1 = 12325
n1 = 77

cable_var1 = df1['4'].var()
print("cable_var1 =", cable_var1)

y1 = df1['4'].mean()
print("y1 =", y1)


# strata 2
df2 = pd.read_csv('s2_2.txt', delimiter=r'\s+')
N2 = 19664
n2 = 123

cable_var2 = df2['4'].var()
print("cable_var2 =", cable_var2)

y2 = df2['4'].mean()
print("y2 =", y2)



D = ( (1 - n1/N1)*cable_var1*N1**2 )/(n1*N**2) + ( (1 - n2/N2)*cable_var2*N2**2 )/(n2*N**2)
print(D)



y = 8.925
lower_price = y - z_alpha * sqrt(D)
upper_price = y + z_alpha * sqrt(D)
print(f"95% довірчий інтервал для середньої ціни за кабельне ТБ: ({lower_price:.2f}, {upper_price:.2f})")




#################################################
print('-------------------------------------------')
#################################################


# neyman
S1 = sqrt(cable_var1)
S2 = sqrt(cable_var2)

n = 200

# nn1 = n*N1*S1/(N1*S1 + N2*S2)
# print("neyman n1 =", nn1)
nn1 = 76

# nn2 = n*N2*S2/(N1*S1 + N2*S2)
# print("neyman n2 =", nn2)
nn2 = 124

# strata 1
dfn1 = pd.read_csv('i2_1.txt', delimiter=r'\s+')

cable_varn1 = dfn1['4'].var()
print("neyman cable_var1 =", cable_varn1)

yn1 = dfn1['4'].mean()
print("neyman y1 =", yn1)



# strata 2
dfn2 = pd.read_csv('i2_2.txt', delimiter=r'\s+')

cable_varn2 = dfn2['4'].var()
print("neyman cable_var2 =", cable_varn2)

yn2 = dfn2['4'].mean()
print("neyman y2 =", yn2)


D_neyman = ( (1 - nn1/N1)*cable_varn1*N1**2 )/(nn1*N**2) + ( (1 - nn2/N2)*cable_varn2*N2**2 )/(nn2*N**2)
print(D_neyman)


y = 8.925
lower_price = y - z_alpha * sqrt(D_neyman)
upper_price = y + z_alpha * sqrt(D_neyman)
print(f"95% довірчий інтервал для середньої ціни за кабельне ТБ: ({lower_price:.2f}, {upper_price:.2f})")



#################################################
print('-------------------------------------------')
#################################################


# optimal
c0 = 0
c1 = 15
c2 = 75
C = 5157

# lambda1 = (C-c0)/(N1*S1*sqrt(c1) + N2*S2*sqrt(c2))
#
# no1 = lambda1*N1*S1/sqrt(c1)
# no2 = lambda1*N2*S2/sqrt(c2)
#
# print('optimal n1 =', no1)
# print('optimal n2 =', no2)

no1 = 74
no2 = 54


# strata 1
dfo1 = pd.read_csv('o2_1.txt', delimiter=r'\s+')

cable_varo1 = dfo1['4'].var()
print("optimal cable_var1 =", cable_varo1)

yo1 = dfo1['4'].mean()
print("optimal y1 =", yo1)



# strata 2
dfo2 = pd.read_csv('o2_2.txt', delimiter=r'\s+')

cable_varo2 = dfo2['4'].var()
print("optimal cable_var2 =", cable_varo2)

yo2 = dfo2['4'].mean()
print("optimal y2 =", yo2)


D_opt = ( (1 - no1/N1)*cable_varo1*N1**2 )/(no1*N**2) + ( (1 - no2/N2)*cable_varo2*N2**2 )/(no2*N**2)
print(D_opt)


y = 8.925
lower_price = y - z_alpha * sqrt(D_opt)
upper_price = y + z_alpha * sqrt(D_opt)
print(f"95% довірчий інтервал для середньої ціни за кабельне ТБ: ({lower_price:.2f}, {upper_price:.2f})")
