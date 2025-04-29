import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# Функція, що обчислює вартість лінійної регресії для даного сегмента Х
def linear_regression_cost(X):
    n = len(X)
    X_matrix = np.column_stack([np.ones(n), np.arange(n)])
    y = np.array(X)
    A = np.linalg.pinv(X_matrix.T @ X_matrix) @ X_matrix.T @ y
    residuals = y - X_matrix @ A
    cost = np.sum(residuals ** 2)

    return cost

# Функція, що реалізує алгоритм сегментації часового ряду
def segment_time_series(X, max_segments=10):
    T = len(X)
    optimal_segmentations = []

    # Ініціалізація для K=1
    c = np.zeros(T + 1)
    z = np.zeros(T + 1, dtype=int)
    for t in range(1, T + 1):
        c[t] = linear_regression_cost(X[:t])

    optimal_segmentations.append((c[T], [0, T]))

    # Динамічне програмування для K > 1
    for K in range(2, max_segments + 1):
        c_new = np.zeros(T + 1)
        z_new = np.zeros(T + 1, dtype=int)
        for s in range(1, T + 1):
            min_cost = float('inf')
            best_t = 0
            for t in range(s):
                cost = c[t] + linear_regression_cost(X[t:s])
                if cost < min_cost:
                    min_cost = cost
                    best_t = t
            c_new[s] = min_cost
            z_new[s] = best_t

        c, z = c_new, z_new

        # Знаходження оптимальної сегментації
        segmentation = [0]
        s = T
        for k in range(K):
            s = z[s]
            segmentation.append(s)
        segmentation.append(T)

        optimal_segmentations.append((c[T], segmentation))

    # Обчислення J(k) для кожної сегментації за формулою BIC
    jk = []
    for i, (cost, segmentation) in enumerate(optimal_segmentations):
        K = i + 1
        p = 2 * K
        bic = len(X) * np.log(cost / len(X)) + p * np.log(len(X))
        jk.append(bic)

    # Знаходження оптимальної кількості сегментів за BIC
    best_k = np.argmin(jk) + 1
    best_cost, best_segmentation = optimal_segmentations[best_k - 1]

    print(f"Оптимальна кількість сегментів за BIC: {best_k}")
    print(f"Вартість для оптимальної сегментації: {best_cost}")
    print(f"Оптимальна сегментація: {best_segmentation}")

    return optimal_segmentations, best_k, best_cost, best_segmentation

# 2. Створення великого часового ряду з лінійною регресією
np.random.seed(0)
slope = 0.5
intercept = 2.0
X = [slope * i + intercept + np.random.normal(0, 5) for i in range(100)]

# 3. Задання реальних даних
df = pd.read_csv('sales1.csv')
X = df['SALES'].tolist()

# Розбиття часового ряду на сегменти
optimal_segmentations, best_k, best_cost, best_segmentation = segment_time_series(X, max_segments=5)

# Побудова графіку
plt.figure(figsize=(14, 8))
plt.plot(X, label='Часовий ряд', marker='o', linestyle='-')

# Сортування точок сегментації
for cost, segmentation in optimal_segmentations:
    segmentation.sort()

# (остання) сегментація з найменшою вартістю
# best_segmentation = optimal_segmentations[-1][1]
# рисування точок найоптимальнішої сегментації на графіку
for seg_point in best_segmentation[1:-1]:
    plt.plot(seg_point, X[seg_point], marker='o', markersize=8, color='red')
    plt.axvline(x=seg_point, color='black', linestyle='--')

plt.xlabel('Часова відмітка')
plt.ylabel('Значення')
plt.title('Сегментація часового ряду')
plt.legend()
plt.grid(True)
plt.show()

for cost, segmentation in optimal_segmentations:
    print(f"Cost: {cost}, Segmentation: {segmentation}")