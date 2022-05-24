# Teme laborator ASC
Acest repository conține rezolvările mele la cele două teme de laborator din cadrul cursului Arhitectura Sistemelor de Calcul (anul I, CTi, FMI)


## Tema 1
Am ales problema 26. Scopul programului este să determine dacă șirul de caractere citit de la tastatură este palindrom sau nu. Implementarea este făcută atât în _Assembly x86_ (dialectul _NASM_), cât și în _C++_.

Pentru a compila codul sursă assembly am folosit comenzile:
```
nasm tema1.asm -o tema1.o -f elf32 -g
ld -m elf_i386 tema1.o -o tema1
```


## Tema 2
Am ales problema 20. Scopul programului este să găsească soluția aproximativă a ecuației $-380x + 28x^2 + x^3 = 0$, folosind metoda Newton-Raphson. Programul primește de la tastatură aproximarea inițială ($x_0$) și numărul de iterații (n) și afișează soluția aproximativă rezultată.

Programul în limbaj de asamblare este scris în _x64 NASM_, și folosește instrucțiunile specifice pentru lucrul cu numere în virgulă mobilă.

Programul echivalent în C++ rezolvă problema folosind thread-uri separate pentru calculul valorii funcției și al derivatei acesteia în punctul x curent.

Pentru compilarea codului sursă assembly am folosit comenzile:
```
nasm tema2.asm -o tema2.o -f elf64 -g -F dwarf
/usr/bin/gcc tema2.0 -o tema2 -no-pie
```
