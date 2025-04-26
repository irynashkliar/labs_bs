import pandas as pd
from scipy.stats import norm
from math import sqrt

df = pd.read_csv('mainfinal.txt', delimiter=r'\s+')

df9 = pd.read_csv('f9.txt', delimiter=r'\s+')
df22 = pd.read_csv('f22.txt', delimiter=r'\s+')
df37 = pd.read_csv('f37.txt', delimiter=r'\s+')
df41 = pd.read_csv('f41.txt', delimiter=r'\s+')
df54 = pd.read_csv('f54.txt', delimiter=r'\s+')
df34 = pd.read_csv('f34.txt', delimiter=r'\s+')
df5 = pd.read_csv('f5.txt', delimiter=r'\s+')
df32 = pd.read_csv('f32.txt', delimiter=r'\s+')
df64 = pd.read_csv('f64.txt', delimiter=r'\s+')
df3 = pd.read_csv('f3.txt', delimiter=r'\s+')


# y = df['4'].mean()
# print(y)

n9 = 296
n22 = 254
n37 = 174
n41 = 152
n54 = 585
n34 = 135
n5 = 110
n32 = 141
n64 = 968
n3 = 135

# N0 = [n9, n22, n37, n41, n54, n34, n5, n32, n64, n3]

N = 31989
NI = 75
nI = 10
n = 20

# print(df9['4'])
t9 = float(df9['4'].sum() * n9/n)
t22 = float(df22['4'].sum() * n22/n)
t37 = float(df37['4'].sum() * n37/n)
t41 = float(df41['4'].sum() * n41/n)
t54 = float(df54['4'].sum() * n54/n)
t34 = float(df34['4'].sum() * n34/n)
t5 = float(df5['4'].sum() * n5/n)
t32 = float(df32['4'].sum() * n32/n)
t64 = float(df64['4'].sum() * n64/n)
t3 = float(df3['4'].sum() * n3/n)

t = [t9, t22, t37, t41, t54, t34, t5, t32, t64, t3]
# print(sum(t))
# print(t)


# 1(б)
y_pi = NI * sum(t) / (N*nI)
print("Оцінка середньої ціни =", y_pi)


i = 0
S2_T = 0
for i in range(0, 9):
    suma = (t[i] - sum(t)/nI)**2
    S2_T += suma
    i += 1

S2_T = S2_T/(nI-1)
# print(S2_T)


S9 = df9['4'].var()
S22 = df22['4'].var()
S37 = df37['4'].var()
S41 = df41['4'].var()
S54 = df54['4'].var()
S34 = df34['4'].var()
S5 = df5['4'].var()
S32 = df32['4'].var()
S64 = df64['4'].var()
S3 = df3['4'].var()


suma9 = ((1 - n/n9)*S9*n9**2) / n
suma22 = ((1 - n/n22)*S22*n22**2) / n
suma37 = ((1 - n/n37)*S37*n37**2) / n
suma41 = ((1 - n/n41)*S41*n41**2) / n
suma54 = ((1 - n/n54)*S54*n54**2) / n
suma34 = ((1 - n/n34)*S34*n34**2) / n
suma5 = ((1 - n/n5)*S5*n5**2) / n
suma32 = ((1 - n/n32)*S32*n32**2) / n
suma64 = ((1 - n/n64)*S64*n64**2) / n
suma3 = ((1 - n/n3)*S3*n3**2) / n

sumD0 = suma9+suma22+suma37+suma41+suma54+suma34+suma5+suma32+suma64+suma3

D_PVDVE = ( ((1-nI/NI)*S2_T*NI**2)/nI + sumD0*NI/nI ) / N**2
print("Оцінка дисперсії для оцінки середнього =", D_PVDVE)


z_alpha = norm.ppf(0.975)  # 1.959963984540054
# y = df['4'].mean()
# print(y)
y = 9.525

lower_price = y - z_alpha * sqrt(D_PVDVE)
upper_price = y + z_alpha * sqrt(D_PVDVE)
print(f"95% довірчий інтервал для середньої ціни за кабельне ТБ: ({lower_price:.2f}, {upper_price:.2f})")





# y9 = df9['4'].mean()
# print("y9 =", y9)
#
# y22 = df22['4'].mean()
# print("y22 =", y22)
#
# y37 = df37['4'].mean()
# print("y37 =", y37)
#
# y41 = df41['4'].mean()
# print("y41 =", y41)
#
# y54 = df54['4'].mean()
# print("y54 =", y54)
#
# y34 = df34['4'].mean()
# print("y34 =", y34)
#
# y5 = df5['4'].mean()
# print("y5 =", y5)
#
# y32 = df32['4'].mean()
# print("y32 =", y32)
#
# y64 = df64['4'].mean()
# print("y64 =", y64)
#
# y3 = df3['4'].mean()
# print("y3 =", y3)


# a = 1/4 - (0.9**(1/8) - 0.9**(1/16))/0.10536 - (0.9**(3/8) - 0.9**(1/4))/0.10536 - (0.9**(3/4) - 0.9**(9/16))/0.10536
# print(a*35000)