#!/usr/bin/env python3
import matplotlib.pyplot as plt
import random

f = plt.figure()

depression = []
providers = []

fin = open("providers_per_capita.txt", "r")

for line in fin:
    fields = line.strip().split("|")
    depression.append(float(fields[1]))
    providers.append(float(fields[2]))

fin.close()

plt.scatter(depression, providers, c = "b", alpha = 0.5, s = 5)

# Simple regression line calculation
x_avg = sum(depression) / len(depression)
y_avg = sum(providers) / len(providers)
m = sum((x - x_avg) * (y - y_avg) for x, y in zip(depression, providers)) / sum((x - x_avg) ** 2 for x in depression)
b = y_avg - m * x_avg

# Plot regression line
x_min, x_max = min(depression), max(depression)
plt.plot([x_min, x_max], [m * x_min + b, m * x_max + b], color="red", label=f"Regression Line (y={m:.2f}x + {b:.2f})")


# Labeling
plt.xlabel("% Depression Per Zip Code")
plt.ylabel("Mental Health Providers Per Capita")
plt.title("Correlation Between Depression and Mental Health Providers")

f.savefig("final_project_scatterplot.pdf")
    
