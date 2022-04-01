#include<iostream>
using namespace std;
const int m = 60;
long long a[m], b[m], c[m], d[m], e[m];
int main() {
    a[0] = 0, b[0] = 1;
    for (int i = 1; i < m; i++) {
        a[i] = a[i - 1] + i;
        b[i] = b[i - 1] + 3 * i;
    }
    for (int i = 0; i < 20; i++) { c[i] = a[i];
        d[i] = b[i];
    }
    for (int i = 20; i < 40; i++) {
        c[i] = a[i] + b[i];
        d[i] = c[i] * a[i];
    }
    for (int i = 40; i < 60; i++) { c[i] = a[i] * b[i];
        d[i] = c[i] * b[i];
    }
    for (int i = 0; i < m;
        e[i] = c[i] + d[i];
        cout << hex << ”0x”<< e[i] << endl;
    }
return 0; 
}