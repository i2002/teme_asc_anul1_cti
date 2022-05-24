// Butufei Tudor-David, grupa 161, problema 26
#include <iostream>
#include <string>
using namespace std;

int main()
{
    string s;
    cout << "Introduceti cuvant: ";
    cin >> s;
    int len = s.length();
    for(int i = 0; i < len / 2; i++)
        if(s[i] != s[len - i - 1])
        {
            cout << "Nu este palindrom\n";
            return 0;
        }

    cout << "Este palindrom\n";
    return 0;
}