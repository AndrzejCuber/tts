title: OCR PDF

author: Andrzej Cuber

date: 2026-01-30, 2026-02-21

filename: tts.md


# Instalacje:

Przedstawione tu rozwiązania bazują na kilku pakietach, które nie wiem
czy są standardowo instalowane. Przed przystąpieniem do działań warto
więc wydać polecenie:

```
$ sudo apt install poppler-utils
```

Po podaniu hasła użytkownika nastąpi instalacja pakietu lub zostanie
wyświetlona informacja, że pakiet został już instalowany i jest w
najnowszej wersji lub dokona się aktualizacja - mam nadzieję.


# Pozyskiwanie tekstu z pliku PDF.

Tekst w plikach PDF może być gromadzony na co najmniej dwa różne
sposoby. Pierwszy to tzw. tekst elektroniczny zapisany w treści pliku
PDF, drugi sposób to graficzne obrazy (zdjęcia) stron z tekstem danej
publikacji. W pierwszym przpadku możemy użyć polecenia
```pdftotext```, aby pozyskać tekst, drugi przypadek jest znacznie
bardziej skomplikowany i wymaga wykonania kilku kroków.


## Przetwarzanie pliku PDF jako obrazy tekstu stron.

Wydaje się, że najlepsze efekty można uzyskać za pomocą programu
```pdfimages```, który "wyciąga" z pliku pdf obrazy stron, jeśli ten
takie zawiera. Dzięki zastosowaniu tego oprogramowania uzyskuje się
mniejsze rozmiarowo obrazy zarówno pod względem rozmiary (pixele) i
wagi. Użycie ```pdfimages``` jest następujące:

```
pdfimages -png nazwa_pliku.pdf przedrostek_zapisanych obrazów

$ pdfimages -png ch7.pdf ch7
```

Podobnie jak w przypadku zaprezentowanego poniżej programu
```pdftoppm``` można użyć opcji ```-f``` oraz ```-l```, aby określić
zakres stron, które mają zostać przetworzone.

W pierwszej kolejności musimy zapisać poszczególne strony pliku PDF
jako obrazy w jednym z wielu formatów graficznych. Służy do tego
polecenie: ```pdftoppm```, którego syntaktyka korzystania jest
następująca:

```
$ pdftoppm -png nazwa_pliku.pdf -r 300 prefix
```

gdzie:

-png - format pliku graficznego, do którego zostaną zapisane obrazy stron;

nazwa-pliku.pdf - to nazwa pliku pdf to przetworzenia: ***Albrecht.pdf***;
    
-r 300 - rozdzielczość (jakość) pliku graficznego (do OCR stosuje się jakość 300dpi);

prefix - to taki przedrostek, którym zostaną opatrzone nazwy plików
graficznych zawierających poszczególne obrazy stron pliku PDF.

```
pdftoppm -gray -progress -r 300 -png albrecht.pdf albrecht
```

dodatkowo można użyć argumentów:

-gray - aby uzyskać obraz czarno-biały;

-progress - aby być informowanym o postępie przetwarzania;

W wyniku działania powyższego polecenia powstaną następujące pliki
zawierające obrazy stron.

```
a-001.png  a-004.png  a-007.png  a-010.png  a-013.png  a-016.png  
a-002.png  a-005.png  a-008.png  a-011.png  a-014.png  a-017.png
a-003.png  a-006.png  a-009.png  a-012.png  a-015.png  a-018.png  
```

Istnieje także możliwość pozyskania wyłącznie wybranych stron. Wówczas
przedmiotowe to polecenie należy wzbogacić o następujące parametry:

```
pdftoppm -gray -progress -r 300 -png -f 10 -l 13 albrecht.pdf albrecht
```

-f (first) - pierwsza strona - tutaj 10;

-l (last) - ostatnia strona - tutaj 13;

Jeśli nie określi się zakresu końca strom, przetwarzanie następuje do
końca pliku.


### Obracanie stron

for szFile in /path/*.png
do 
    convert "$szFile" -rotate 90 /tmp/"$(basename "$szFile")" ; 
done

### Rozjaśnianie stron

Rozjaśnianie o 10% 

convert porsche.png -fill white -colorize 10%  porshe_light.png
