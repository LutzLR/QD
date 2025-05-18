* QUER.PRG
CLEAR ALL
SET BELL ON
SET CENTURY ON
SET CONFIRM ON
SET CONSOLE ON
SET CUAENTER OFF
SET CURSOR ON
SET DECIMALS TO 9  && wesentlich für die Berechnung, SQRT u. a. ...
SET DELETED ON
SET ESCAPE OFF
SET EXACT ON
SET EXCLUSIVE OFF
SET MARGIN TO 0
SET NEAR OFF
SET REPROCESS TO 0
SET SAFETY OFF
SET TALK OFF
*
* Variablen
* ORGVERZ     Installationsverzeichnis von Programmes
* un          Nennspannung in Volt
* u           Spannungsfall in Prozent oder Volt
* l           gesamte Kabellänge in Meter
* t1          1. Teillänge
* z           Anzahl der Anschlußpunkte
* s           Scheinleistung je Anschluß
* tl          Teillänge von Anschluß zu Anschluß
* srech       Scheinleistung zum Rechnen
* zrech       Anschlußanzahl zum Rechnen
* urech       Spannungsfall zum Rechnen
* a           Querschnitt
* tp1, tp2    Temperatur und daraus berechneter Korrekturfaktor
* ka          Kappa des Leitermaterials
* dstrom      bei Drehstrom gesetzt
* x           für Berechnungen
* v           Programmversion
* bem         Bemerkung
* m           Makro, Programmlauf
* z1          Zeilenzähler für TxtArr1 und TxtArr2
* z2          Zeilenzähler für TxtArr2
*
* Array 1:
* TxtArr1     privates Array mit den Resistanzen und Reaktanzen der einzelnen Kabelquerschnitte
*             Spalte 1: NENNQUER
*             Spalte 2: RESIS_CU
*             Spalte 3: RESIS_AL
*             Spalte 4: REAK
*
* Array 2:
* TxtArr2     privates Array zum Berechnen des Querschnitts
*             Spalte 1: UN_
*             Spalte 2: NETZ_
*             Spalte 3: LEITER_
*             Spalte 4: TEMP_
*             Spalte 5: LAENGE_
*             Spalte 6: QUER_
*             Spalte 7: I_
*             Spalte 8: UA_
*             Spalte 9: UAPROZ_
*
PUBLIC ORGVERZ,un,u,l,z,s,tl,srech,zrech,urech,a,t1,bem,ka,m,x,v,tp1,tp2,z1,z2
public TxtArr1,TxtArr2
store "Version 8.00" to v
store " " TO ORGVERZ,bem,m
store 0 to un,u,l,z,s,tl,srech,zrech,urech,a,t1,ka,dstrom,x,tp1,tp2,z1,z2
TxtArr1 = new Array(1,4)  && Array 1 initialisieren und füllen
TxtArr1[ 1,1] =   2.5; TxtArr1[ 1,2] = 7.073; TxtArr1[ 1,3] = 11.935; TxtArr1[ 1,4] = 0.110
TxtArr1.grow(1)  && TxtArr1 vergrößern
TxtArr1[ 2,1] =   4.0; TxtArr1[ 2,2] = 4.560; TxtArr1[ 2,3] =  7.468; TxtArr1[ 2,4] = 0.107
TxtArr1.grow(1)  && TxtArr1 vergrößern
TxtArr1[ 3,1] =   6.0; TxtArr1[ 3,2] = 3.030; TxtArr1[ 3,3] =  4.976; TxtArr1[ 3,4] = 0.100
TxtArr1.grow(1)  && TxtArr1 vergrößern
TxtArr1[ 4,1] =  10.0; TxtArr1[ 4,2] = 1.810; TxtArr1[ 4,3] =  2.984; TxtArr1[ 4,4] = 0.094
TxtArr1.grow(1)  && TxtArr1 vergrößern
TxtArr1[ 5,1] =  16.0; TxtArr1[ 5,2] = 1.141; TxtArr1[ 5,3] =  1.891; TxtArr1[ 5,4] = 0.090
TxtArr1.grow(1)  && TxtArr1 vergrößern
TxtArr1[ 6,1] =  25.0; TxtArr1[ 6,2] = 0.724; TxtArr1[ 6,3] =  1.201; TxtArr1[ 6,4] = 0.086
TxtArr1.grow(1)  && TxtArr1 vergrößern
TxtArr1[ 7,1] =  35.0; TxtArr1[ 7,2] = 0.526; TxtArr1[ 7,3] =  0.876; TxtArr1[ 7,4] = 0.083
TxtArr1.grow(1)  && TxtArr1 vergrößern
TxtArr1[ 8,1] =  50.0; TxtArr1[ 8,2] = 0.389; TxtArr1[ 8,3] =  0.642; TxtArr1[ 8,4] = 0.083
TxtArr1.grow(1)  && TxtArr1 vergrößern
TxtArr1[ 9,1] =  70.0; TxtArr1[ 9,2] = 0.271; TxtArr1[ 9,3] =  0.444; TxtArr1[ 9,4] = 0.082
TxtArr1.grow(1)  && TxtArr1 vergrößern
TxtArr1[10,1] =  95.0; TxtArr1[10,2] = 0.197; TxtArr1[10,3] =  0.321; TxtArr1[10,4] = 0.082
TxtArr1.grow(1)  && TxtArr1 vergrößern
TxtArr1[11,1] = 120.0; TxtArr1[11,2] = 0.157; TxtArr1[11,3] =  0.255; TxtArr1[11,4] = 0.080
TxtArr1.grow(1)  && TxtArr1 vergrößern
TxtArr1[12,1] = 150.0; TxtArr1[12,2] = 0.130; TxtArr1[12,3] =  0.208; TxtArr1[12,4] = 0.080
TxtArr1.grow(1)  && TxtArr1 vergrößern
TxtArr1[13,1] = 185.0; TxtArr1[13,2] = 0.105; TxtArr1[13,3] =  0.167; TxtArr1[13,4] = 0.080
TxtArr1.grow(1)  && TxtArr1 vergrößern
TxtArr1[14,1] = 240.0; TxtArr1[14,2] = 0.083; TxtArr1[14,3] =  0.131; TxtArr1[14,4] = 0.079
TxtArr1.grow(1)  && TxtArr1 vergrößern
TxtArr1[15,1] = 300.0; TxtArr1[15,2] = 0.069; TxtArr1[15,3] =  0.107; TxtArr1[15,4] = 0.079
*
* Installationsverzeichnis
store program(1) to m
store substr(m,1,len(m)-9) to orgverz
set directory to &ORGVERZ
*
* DLL laden und Formular öffnen
set directory to &ORGVERZ
LOAD DLL qd.DLL
DO QUER.WFM
*
* Programmende
set directory to &ORGVERZ
RELEASE DLL qd.DLL
* RETURN
CANCEL

