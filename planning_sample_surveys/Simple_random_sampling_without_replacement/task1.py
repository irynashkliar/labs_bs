import pandas as pd

df = pd.read_csv('addr.txt', delimiter=r'\s+')

# total_tvs = df['3']
# print(total_tvs)

N = 31989
n = 20
# 1(а)
total_tvs = df['3'].sum()
t = N * total_tvs / n
print(total_tvs)
print(t)
# 70376

# 1(б)
y = df['4'].mean()
print(y)

# 1(в)
# по характеристиці y – «кількість телевізорів»
# tv_counts = df['3']
tv_variance = df['3'].var()
print(f"Дисперсія генеральної сукупності по кількості телевізорів: {tv_variance}")

# по характеристиці z – «ціна за послуги кабельного ТБ»
# cable_prices = df['4']
cable_variance = df['4'].var()
print(f"Дисперсія генеральної сукупності по ціні за кабельне ТБ: {cable_variance}")
# print({cable_variance:.5f})
