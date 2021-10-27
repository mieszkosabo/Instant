# Instant Compiler, Mieszko Sabo 406322

## Budowa projektu

```
make
```

## Tester

W korzeniu projektu dodałem taki mały skrypt pythonowy, który odpala kompilatory dla
wszystkich plików testowych z wybranego folderu. Można go uruchomić np. tak:

```
python3 myTester.py examples
```

## Struktura projektu

Rozwiązanie składa się z folderów:

- Frontend
  Tu znajdują się automatycznie wygenerowane pliku przez program bnfc.

- lib
  Tu znajduje się jasmin.jar oraz runtime.ll. Oba pliki pobrane z moodle kursu.

- examples i tests
  W folderze examples znajdują się pliki testowe z moodle, test zawiera kilka bardzo prostych testów napisanych przeze mnie.

- Src
  Folder Src jest podzielony na moduły JVM, LLVM oraz Shared zawierające odpowiednio
  kompilator dla JVM, LLVM oraz funkcje i typy współdzielone przez oba kompilatory.

