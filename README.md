# PSV konverteerimine sähvikuteks

NB! See on esialgne proov ja alles katsetamisfaasis.

[Anki](http://ankisrs.net/) on üks mitmetest vaba-tarkvaralistest sähvikuprogrammidest. Mitmed EKI keeleressursid sobiksid konverteerida headeks keeleõppe-materjalideks eesti keele iseõppijale. Eriti [Põhisõnavara sõnastik](http://www.eki.ee/dict/psv/) sisaldab palju kategooriaid ja eri liiki informatsiooni. Sähvikud on lihtne abivahend mälutreenimiseks, mis sobib hästi näiteks väiksemate sõnavara või faktide kogude mäletamiseks repetitsiooni teel.

Meil on võimalik konverteerida mitmel moel: 

1. CSV tekstifail
2. SuperMemo XML tegemine
3. Anki .apkg faili tegemine

Proovime neid järjest, alustades esimesest.

Kõigepealt tuleb siiski vastata küsimusele *millest* me tahame sähvikud koostada. Pakun välja et kõik sõnad füüsiliste omadussõnade grupist, neid on 35. Selle alamhulga leiame otsinguga:
```//*:A[some $sem-group in .//*:semg satisfies $sem-group = 'omadus_füüs']```

Sähviku esiküljele ehk küsimuseks paneme seletuse, ja tagaküljele ehk vastuseks paneme märksõna, võib-olla koos muutevormidega aga kindlasti lingiga sõnastikuotsingule.

Seletus(ed) asub EELex XMLis väljas nimega 'd' ja märksõna(d) väljas nimega 'm'.

Kuna märksõnadel võib esineda mitu seletust ja ka seletustel võib esineda mitu märksõna, saab meie 35 omadussõnast kokku 350 sähvikut.


## Variant 1) tekstifailist importimine

See on kõige lihtsam variant aga vajab käsitööd ja pole seega automatiseeritav. Me peame tegema:

1. Koostama tekstifaili seletuste ja märksõnade tabeliga
   tehakse XQuery skriptiga 'tekstifaili-koostamine.xq'

2. Importima tekstifail Ankisse
   saame teada, et:
   ```
   Importing complete.
   Appeared twice in file: väikese läbi- või ümbermõõduga
   Appeared twice in file: mitte paks
   88 notes added, 0 notes updated, 0 notes unchanged.
   ```
   Ignoreerime seda.

3. Sättima sähvikute seadeid Ankis
   Valime seletused sähvikute esiküljele ja märksõnad sähvikute vastuse ehk tagaküljele.

4. Salvestama e eksportima Anki pakina  
   Sellest tekib ``.apkg`` fail, mida me saame keeleõppijatele jagada.
   

## Variant 2) SuperMemo XML failiks konverteerimine

See oleks ehk kõige universaalsem lahendus, kuna mitmed sähvikuprogrammid suudavad SuperMemo faile importida. 
Faili struktuuri kohta on rohkem informatsiooni nt [SuperMemo XML leheküljel](http://supermemo.com/beta/xml/index.htm).


## Variant 3) Otse .apkg faili tegemine

See variant võiks osutuda lihtsaimaks täis-automatiseeritavaks konverteerimis-meetodiks aga piirduks ainult Anki programmi ühilduvusega. Ei ole soovitatav viis.
