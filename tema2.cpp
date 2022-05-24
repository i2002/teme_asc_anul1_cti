// Butufei Tudor-David, grupa 161, problema 20
#include <iostream>
#include <pthread.h>
using namespace std;

void *calcul_functie(void *data);
void *calcul_derivata(void *data);

int main()
{
    int n;
    double x;

    // citire date
    cout << "Introduceti x0:\n";
    cin >> x;
    cout << "Introduceti n:\n";
    cin >> n;

    // aproximare solutie
    for (int i = 0; i < n; i++)
    {
        double f = x, fd = x;

        // calculare in paralel valoarea functiei si a derivatei
        int rc1, rc2;
        pthread_t thread1, thread2;

        if((rc1=pthread_create(&thread1, NULL, &calcul_functie, &f)))
            printf("Eroare de creare thread-uri! %d\n", rc1);
    
        if((rc2=pthread_create(&thread2, NULL, &calcul_derivata, &fd)))
            printf("Eroare de creare thread-uri! %d\n", rc2);

        pthread_join(thread1, NULL);
        pthread_join(thread2, NULL);

        x = x - f / fd;
    }

    cout << "Solutia aproximata folosind metoda Newton-Rapson in " << n << " pasi este: " << x << "\n";
    return 0;
}

void *calcul_functie(void *data)
{
    double *res = (double*)data;
    double x = *res;
    double x_2 = x * x;
    double x_3 = x_2 * x;

    *res = -380 * x + 28 * x_2 + x_3;
    return NULL;
}

void *calcul_derivata(void *data)
{
    double *res = (double*)data;
    double x = *res;
    double x_2 = x * x;

    *res = -380 + 56 * x + 2 * x_2;
    return NULL;
}