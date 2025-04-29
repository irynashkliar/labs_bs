import pandas as pd
from scipy.stats import norm
from math import sqrt

# Завантажуємо дані з файлу txt
df = pd.read_csv('addr200.txt', delimiter=r'\s+')


tv_var1 = 0.80
cable_var1 = 24.93
y = 9.75

# 2(а)
N = 31989
z_alpha = norm.ppf(0.975)  # 1.959963984540054


# з минулого пункту
d = 2000  # Абсолютна точність
n_tvs = (N**2 * tv_var1)/((d ** 2)/(z_alpha**2) + N*tv_var1)
print(f"Необхідний розмір вибірки для оцінки загальної кількості телевізорів: {int(n_tvs)}")

# 2(б)
e = 0.02  # Відносна точність
# n_price = (cable_var1 * (z_alpha**2))/((e ** 2) + (z_alpha ** 2) * cable_var1 / N)
n_price = (cable_var1 * z_alpha**2)/((y**2)*(e ** 2) + (z_alpha ** 2) * cable_var1 / N)
print(f"Необхідний розмір вибірки для оцінки середньої ціни за кабельне ТБ: {int(n_price)}")


# Чи достатньо вибірки розміру 200?
if n_tvs and n_price <= 200:
    print("Достатньо")
else:
    print("Недостатньо")

print("----------------------------------------")


# 3(а) Довірчий інтервал для загальної кількості телевізорів
N = 31989
n = 200

total_tvs = df['3'].sum()  # Сума телевізорів у вибірці
t = N * total_tvs / n
print(int(t))

y = df['4'].mean()
print("y(200) =", y)

tv_var = df['3'].var()
print(tv_var)


D_tvs = sqrt((N**2 * (1 - n/N) * tv_var) / n)
lowerDI_tvs = t - z_alpha * D_tvs
upperDI_tvs = t + z_alpha * D_tvs
print(f"({int(lowerDI_tvs)}, {int(upperDI_tvs)})")


# 3(б) Довірчий інтервал для середньої ціни за кабельне ТБ

cable_var = df['4'].var()
print("cable_var = ", cable_var)

D_price = sqrt(((1 - n/N) * cable_var) / n)
print("D_price = ", D_price**2)
lower_price = y - z_alpha * D_price
upper_price = y + z_alpha * D_price
print(f"95% довірчий інтервал для середньої ціни за кабельне ТБ: ({lower_price:.2f}, {upper_price:.2f})")


# 3(в) Довірчий інтервал для пропорції домогосподарств, які погоджуються платити >= $10
print((df['4'] >= 10).sum())
# pay = (df['4'] >= 10).sum() / n
pay = (df['4'] >= 10).sum() * (1-n/N) / (n-1)

print(pay)
D_prop = sqrt(pay * (1 - pay) / n)
lower_prop = pay - z_alpha * D_prop
upper_prop = pay + z_alpha * D_prop
print(f"95% довірчий інтервал для пропорції домогосподарств, які погоджуються платити >= $10: ({lower_prop:.2f}, "
      f"{upper_prop:.2f})")


# Найбільш популярні передачі в області Стефенс

# Підрахунок кількості переглянутих годин для кожного типу передач
news_hours = df['6'].sum()
print(news_hours)
sports_hours = df['7'].sum()
print(sports_hours)
kids_hours = df['8'].sum()
print(kids_hours)
movies_hours = df['9'].sum()
print(movies_hours)

# Знаходження максимальної кількості переглянутих годин
max_hours = max(news_hours, sports_hours, kids_hours, movies_hours)
print(max_hours)


# print(f"Найпопулярніша передача в області Стефенс: {most_popular}")

print('------------------')
# 4
suma = df['VALUE'].sum()
print(suma)

V = suma / n
print(V)

S_V = df['VALUE'].var()
print(S_V)

D_V = sqrt(((1 - n/N) * S_V) / n)
print(D_V)
lower_V = V - z_alpha * D_V
upper_V = V + z_alpha * D_V
print(f"95% довірчий інтервал для середньої вартості будинків: ({lower_V:.2f}, {upper_V:.2f})")

