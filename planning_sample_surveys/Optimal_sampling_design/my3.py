import pandas as pd
from scipy.stats import norm
from math import sqrt


N = 31989
z_alpha = norm.ppf(0.975)

# strata 1
df1 = pd.read_csv('mf1.txt', delimiter=r'\s+')
N1 = 9089
n1 = 57

cable_var1 = df1['4'].var()
print("cable_var1 =", cable_var1)

y1 = df1['4'].mean()
print("y1 =", y1)


# strata 2
df2 = pd.read_csv('mf2.txt', delimiter=r'\s+')
N2 = 3236
n2 = 20

cable_var2 = df2['4'].var()
print("cable_var2 =", cable_var2)

y2 = df2['4'].mean()
print("y2 =", y2)


# strata 3
df3 = pd.read_csv('mf3.txt', delimiter=r'\s+')
N3 = 19664
n3 = 123

cable_var3 = df3['4'].var()
print("cable_var3 =", cable_var3)

y3 = df3['4'].mean()
print("y3 =", y3)


D = ( (1 - n1/N1)*cable_var1*N1**2 )/(n1*N**2) + ( (1 - n2/N2)*cable_var2*N2**2 )/(n2*N**2) + ( (1 - n3/N3)*cable_var3*N3**2 )/(n3*N**2)
print(D)



y = 9.74
lower_price = y - z_alpha * sqrt(D)
upper_price = y + z_alpha * sqrt(D)
print(f"95% довірчий інтервал для середньої ціни за кабельне ТБ: ({lower_price:.2f}, {upper_price:.2f})")





# print('-------------------------------------------')
#
#
# # neyman
# S1 = sqrt(cable_var1)
# S2 = sqrt(cable_var2)
# S3 = sqrt(cable_var3)
#
# n = 200
#
# nn1 = n*N1*S1/(N1*S1 + N2*S2 + N3*S3)
# print("neyman n1 =", nn1)
# # nn1 = 76
#
# nn2 = n*N2*S2/(N1*S1 + N2*S2 + N3*S3)
# print("neyman n2 =", nn2)
# # nn2 = 124
#
# # strata 1
# dfn1 = pd.read_csv('i2_1.txt', delimiter=r'\s+')
#
# cable_varn1 = dfn1['4'].var()
# print("neyman cable_var1 =", cable_varn1)
#
# yn1 = dfn1['4'].mean()
# print("neyman y1 =", yn1)
#
#
#
# # strata 2
# dfn2 = pd.read_csv('i2_2.txt', delimiter=r'\s+')
#
# cable_varn2 = dfn2['4'].var()
# print("neyman cable_var2 =", cable_varn2)
#
# yn2 = dfn2['4'].mean()
# print("neyman y2 =", yn2)
#
#
# D_neyman = ( (1 - nn1/N1)*cable_varn1*N1**2 )/(nn1*N**2) + ( (1 - nn2/N2)*cable_varn2*N2**2 )/(nn2*N**2)
# print(D_neyman)
#
#
# y = 8.925
# lower_price = y - z_alpha * sqrt(D_neyman)
# upper_price = y + z_alpha * sqrt(D_neyman)
# print(f"95% довірчий інтервал для середньої ціни за кабельне ТБ: ({lower_price:.2f}, {upper_price:.2f})")
#
