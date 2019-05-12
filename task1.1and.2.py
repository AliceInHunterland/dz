import numpy as np
import random
def LU_partial_decomposition(matrix):
    n, m = matrix.shape
    P = np.identity(n)
    L = np.identity(n)
    U = matrix.copy()
    PF = np.identity(n)
    LF = np.zeros((n,n))
    for k in range(0, n - 1):
        index = np.argmax(abs(U[k:,k]))
        index = index + k 
        if index != k:
            P = np.identity(n)
            P[[index,k],k:n] = P[[k,index],k:n]
            U[[index,k],k:n] = U[[k,index],k:n] 
            PF = np.dot(P,PF)
            LF = np.dot(P,LF)
        L = np.identity(n)
        for j in range(k+1,n):
            L[j,k] = -(U[j,k] / U[k,k])
            LF[j,k] = (U[j,k] / U[k,k])
        U = np.dot(L,U)
    np.fill_diagonal(LF, 1)
    return PF, LF, U

# Usage


# Scipy
import scipy
import scipy.linalg





def determinant (A):
    n= len(A)
    d=1.0
    P1, L1, U1 = LU_partial_decomposition(A)
    for i in range(n):
        d=d*U1[i][i]
    return d


def lu_solver(l,u,b,P1):
    n=len(b)
    y = np.zeros(n)
    x = np.zeros(n)
    b_s=np.dot(P1,b)
    for i in range(n):
        y[i]=(b_s[i]- sum(L1[i][p] * y[p] for p in range(n)))
        #print(y[i])
    for i in range(n):
        x[n-i-1]=float(y[n-i-1]-sum(U1[n-i-1][n-p-1]* x[n-p-1] for p in range(n)))/U1[n-i-1][n-i-1]
        #print(x[n-1-i])
    return x


def obratn(l,u,p):
    n=len(l)
    E=np.identity(n)
    
    matrix=[]
   
    for i in range (n):
        b=[]
        for j in range (n):
            b.append(E[i][j])
        
        stolb=lu_solver(l,u,b,p)
        matrix.append(stolb.tolist())
    matrix=np.transpose(matrix)
    return matrix

def obuslov(a,a1):
    norm=np.linalg.norm(a)
    norm1=np.linalg.norm(a1)
   # print(norm,norm1)
    number=norm*norm1
    return(number)

def generate_diagonal_dominant():
	dim = random.randint(2, 10)
	matrix = 200 * np.random.rand(dim, dim) - 100
	vector = 200 * np.random.rand(dim, 1) - 100

	for i in range(dim):
		max_in_row = 0
		num_max = 0
		for j in range(dim):
			if abs(matrix[i, j]) > max_in_row:
				max_in_row = abs(matrix[i, j])
				num_max = j
		matrix[i, i], matrix[i, num_max] = matrix[i, num_max], matrix[i, i]
	for i in range(dim):
		for j in range(dim):
			if not i == j:
				matrix[i, j] /= dim-1
	return matrix, vector

def generate_positive_definite():
	dim = random.randint(2, 5)
	matrix = 200 * np.random.rand(dim, dim) - 100
	vector = 200 * np.random.rand(dim, 1) - 100
	return np.dot(matrix, matrix.T)/1000, vector

def norm_oo(a):
	norm = 0.
	rows, cols = a.shape
	for i in range(rows):
		tmp = abs(a[i]).sum()
		if tmp > norm:
			norm = tmp
	return norm

def jacobi(a, b):
	currency = 10e-12
	max_iterations = 10e3
	rows, cols = a.shape
	h = np.zeros((rows, cols))
	g = np.zeros((rows, 1))
	for i in range(rows):
		for j in range(i):
			h[i, j] = - a[i, j] / a[i, i]
		h[i, i] = 0
		for j in range(i+1, cols):
			h[i, j] = - a[i, j] / a[i, i]
		g[i, 0] = b[i, 0] / a[i, i]
	x_n_1 = np.copy(g)
	counter = 0
	koef = norm_oo(h) / (1 - norm_oo(h))
	if koef < 0:
		koef = 10
	while True:
		x_n = np.dot(h, x_n_1) + g
		x_n, x_n_1 = x_n_1, x_n
		counter += 1
		if not((koef * abs(norm_oo(x_n_1 - x_n))) > currency and counter < max_iterations):
			break
	print('Jacobi iterations: ', counter)
	if counter > max_iterations or np.isnan(x_n_1[0, 0]):
		raise Exception('DOESN\'T COVERAGE!!!')
	return x_n_1

def seidel(a, b):
	currency = 10e-12
	rows, cols = a.shape
	x_n_1 = np.ones((rows, 1))
	x_n = np.zeros((rows, 1))

	counter = 0

	r = np.zeros((rows, cols))
	for i in range(rows):
		for j in range(i, rows):
			r[i, j] = -a[i, j] / a[i, i]

	h = np.zeros((rows, cols))
	for i in range(rows):
		for j in range(cols):
			h[i, j] = -a[i, j] / a[i, i]

	print(norm_oo(h))
	koef = abs(norm_oo(r) / (1 - norm_oo(h)))
	print(koef)

	while True:
		for i in range(rows):
			x_n[i, 0] = b[i, 0] / a[i, i]
			for j in range(i):
				x_n[i, 0] -= x_n[j, 0] * a[i, j] / a[i, i]
			for j in range(i+1, rows):
				x_n[i, 0] -= x_n_1[j, 0] * a[i, j] / a[i, i]

		x_n, x_n_1 = x_n_1, x_n
		counter += 1
		if (koef * abs(norm_oo(x_n_1 - x_n))) < currency:
			break

	print('Seidel iterations: ', counter)
	return x_n_1




# Usage
A=[[1,1,1], [4,3,-1], [3,5,3]]

#A = [[1, 2], [4,5]]
#A = [[11,9,24,2],[1,5,2,6],[3,17,18,1],[2,5,7,1]]
A = np.array(A)
P1, L1, U1 = LU_partial_decomposition(A)
P2, L2, U2 = scipy.linalg.lu(A) # P2 = P2.T 
print(A)
print(P1)
print(L1)
print(U1)
#print(P2)
#print(L2)
#print(U2)
d =determinant(A) 
print("Определитель равен ",d)
b= np.array([1,6,4])
x = lu_solver(L1,U1,b,P1)
#x2=np.linalg.solve(A,b)
print ("решение Ах=В   х=  ",x)
#print (x2)
#print(np.allclose(np.dot(A, x2), b))
#print(np.allclose(np.dot(A, x), b))
A_1=obratn(L1,U1,P1)
print("Обратная матрица  ",obratn(L1,U1,P1))
#print(np.linalg.inv(A))

print("число обусловленности  ",obuslov(A,A_1))
#print(np.linalg.cond(A))
print('\n', '-' * 100, '-' * 100, '№2', '-' * 100, '-' * 100, sep='\n')
mat_pd, vec_pd = generate_positive_definite()

print('A:', mat_pd)
print('b:', vec_pd.T)
krya=jacobi(mat_pd,vec_pd)
x_s_pd = seidel(mat_pd, vec_pd)
print('Сравнение с положительно определённой матрицей:', np.dot(mat_pd, x_s_pd) - vec_pd)
