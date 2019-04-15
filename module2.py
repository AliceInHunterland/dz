import lu
import pprint
import numpy as np

A=lu.A
P, L, U = lu.lu_decomposition(A)
b = [ 1, 2, 3]
n = len(b)
print (P)
print (A)
print (L)
print (U)
y = np.zeros(n)
x = np.zeros(n)

for i in range(n):
    y[i]=b[i]- sum(L[i][p] * y[p] for p in range(n))

print (y)
print(x)
for i in range(n):
    x[n-i-1]=float(y[n-i-1]-sum(U[n-i-1][n-p-1]* x[n-p-1] for p in range(n)))/U[n-i-1][n-i-1]

print(x)
det=1
for i in range(n):
    det= det*U[i][i]
print(det)