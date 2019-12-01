import numpy as np
import random
import matplotlib.pyplot as plt
import time
A = np.array([[60, 91, 26], [60, 3, 75], [45, 90, 31]], dtype='float')
b = np.array([1, 0, 0])



def generator(size):
    m=np.array([[0,0],[0,0]])
    while np.linalg.det(m)==0:
        m= np.array([[random.random() for i in range(size)] for j in range(size)])
    b= np.array([random.random() for i in range(size)])
    return(m,b)



def npgauss(A,b):
    return(np.linalg.solve(A,b))


def gauss(A,b):
    Ab = np.hstack([A, b.reshape(-1, 1)])
    n = len(b)
    for i in range(n):
        a = Ab[i]
        for j in range(i + 1, n):
            b = Ab[j]
            m = a[i] / b[i]
            Ab[j] = a - m * b
    for i in range(n - 1, -1, -1):
        Ab[i] = Ab[i] / Ab[i, i]
        a = Ab[i]
        for j in range(i - 1, -1, -1):
            b = Ab[j]
            m = a[i] / b[i]
            Ab[j] = a - m * b
    x = Ab[:, 3]
   # return(x)
 

def experiment():
    times = []
    dots=[]
    for k in range(10, 501, 20):
        times_sum = 0
        counts_of_experiments = 20
        for i in range(counts_of_experiments):
            A,b=generator(k)
            start_time = time.time()
            gauss(A,b)
            times_sum += time.time() - start_time
        middle_time = times_sum / counts_of_experiments
        dots.append(k)
        times.append(middle_time)
        print(k, ': ', '{:.5f}'.format(middle_time), end='\n')
    plt.scatter(dots, times, c='b')
    plt.show()

experiment()
