#include <iostream>
#include <time.h>
#include <omp.h>
#include <vector>
#include <algorithm>   
#define THREADS 5
using namespace std;

void Gauss(int n) {
	
	//srand(time(0));
	float **A = new float *[n];

	for (int i = 0; i < n; i++)
		A[i] = new float[n];

	for (int i = 0; i < n; i++)
		for (int j = 0; j < n+1; j++)
		{
			cout << " A[" << i << "][" << j << "] \n";
			cin >> A[i][j];
			//A[i][j] = rand() % 10;
		}
	//выбор ведущего элемента
	for (int j = 0; j < n; j++)
	{
		int max = 0;
		for (int i = j; i < n; i++)
			if (abs(A[i][j]) > max) {
				max = i-1;
			}

		if (A[max][j] == 0.0) {
			continue;
		}
		if (max != j) {
			for (int k = n; k >= 0; --k) {
				swap(A[max][k], A[j][k]);

			}
		}
	}

		float  tmp, xx[21];
		int  i,j,k;
		double dt, timein, timeout;
		// прямой ход
		timein = omp_get_wtime();
		omp_set_num_threads(THREADS); 
		for (i = 0; i < n; i++) {
			tmp = A[i][i];
			for ( j = n+1; j >= i; j--)
				A[i][j] = A[i][j]/tmp;

#pragma omp parallel for private (j, k, tmp)
			for (j = i + 1; j < n; j++) {
				tmp = A[j][i];
				for (k = n; k >= i; k--)
					A[j][k] -= tmp * A[i][k];
			}
		}
		
		//Обратный ход
		xx[n - 1] = A[n - 1][n];
		for (i = n - 2; i >= 0; i--) {
			xx[i] = A[i][n];
#pragma omp for private (j)
			for (int j = i + 1; j < n; j++)
				xx[i] -= A[i][j] * xx[j];
		}
		timeout = omp_get_wtime();
		dt = timeout - timein;
		//cout << "Time of parallel:" << dt << " .c" << endl;

		for (int i = 0; i < n; i++) {
			cout << floor(xx[i] * 1000) / 1000. << " ";
			cout << endl;
		}
		delete[] A;
}
int main() {
	int n;
	cout << "N"<<endl;
	cin >> n;
	Gauss(n);
}
