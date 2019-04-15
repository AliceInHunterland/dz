import pprint
import numpy as np

def pivot_matrix(M):
    """Returns the pivoting matrix for M, used in Doolittle's method."""
    m = len(M)

    # Create an identity matrix, with floating point values                                                                                                                                                                                            
    id_mat = np.identity(m)

    # Rearrange the identity matrix such that the largest element of                                                                                                                                                                                   
    # each column of M is placed on the diagonal of of M                                                                                                                                                                                               
    for i in range(m):
        row= M[i].index(max(M[i], key = abs))
        print (row)
        id_mat[i][row] = id_mat[i][i]
        id_mat[i][i]=0
        
    return id_mat

def lu_decomposition(A):
    """Performs an LU Decomposition of A (which must be square)                                                                                                                                                                                        
    into PA = LU. The function returns P, L and U."""
    n = len(A)
    N =(n, n)
    # Create zero matrices for L and U                                                                                                                                                                                                                 
    L = np.zeros(N)
    U = np.zeros(N)
                                                                                                                                                                                            
    P = pivot_matrix(A)
    PA = np.dot(P, A)

                                                                                                                                                                                                                        
    for j in range(n):
                                                                                                                                                                                                         
        L[j][j] = 1.0

                                                                                                                                                                                    
        for i in range(j+1):
            s1 = sum(U[k][j] * L[i][k] for k in range(i))
            U[i][j] = PA[i][j] - s1

                                                                                                                                                                 
        for i in range(j+1, n):
            s2 = sum(U[k][j] * L[i][k] for k in range(j))
            L[i][j] = (PA[i][j] - s2) / U[j][j]

    return (P, L, U)


A = [[1, 2, 0], [1, 1, 1], [ 0, 1, 1]]
P, L, U = lu_decomposition(A)

#print ("A:")
#pprint.pprint(A)

#print ("P:")
#pprint.pprint(P)

#print ("L:")
#pprint.pprint(L)

#print ("U:")
#pprint.pprint(U)

#print ("LU:")
#pprint.pprint(np.dot(L, U))
