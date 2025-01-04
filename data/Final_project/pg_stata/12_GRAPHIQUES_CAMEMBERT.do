


*local amin=2016
*local amax=2020
* Répertoire 0û vont se trouve les fichiers intermédiaires

cd "C:\INCIDENCE_RGT\DONNEES\"

 
  * GRAPHIQUE camemberts
  
  
  
  
  
use "TI_TM_Geneve_Final.dta", clear
*http://repec.sowi.unibe.ch/stata/palettes/getting-started.html
*diagramme en cercle pour la dernière période
tab loc3num,m
keep if adiag=="[2020-2021]"
keep if loc3num!=1000 & loc3num!=440 & loc3num!=1001
keep if cat==1

keep  indic nbcas*   loc3* cat
reshape long nbcas,i(indic loc3) j(sexe)

gsort  indic sexe -nbcas
by  indic sexe : egen totalcas=total(nbcas)
by  indic sexe : gen num=_n
replace num=6 if num>5

replace loc3="Autres" if num>5
replace loc3num=998  if num>5

collapse (sum) nbcas (mean) totalcas (mean) num, by( indic sexe loc3 loc3num)
sort  indic num

*replace nbcas=round(nbcas/5)



label def loc3num ///		
100	"Lèvre, Bouche, Pharynx"	 ///
150	"Œsophage"	 ///
160	"Estomac"	 ///
170	"Intestin grêle"	 ///
200	"Côlon et rectum"	 ///
210	"Anus et canal anal"	 ///
220	"Foie"	 ///
230	"Vésicule et voies biliaires"	 ///  et extra-hépatiques
250	"Pancréas"	 ///
320	"Larynx"	 ///
330	"Poumon et bronches"	 ///
380	"Plèvre et mésothéliome"	 ///
400	"Os"	 ///
430	"Mélanome de la peau"	 ///
470	"Tissus mous"	 ///
500	"Sein"	 ///
530	"Col de l'utérus"	 ///
540	"Corps de l'utérus"	 ///
560	"Ovaires et annexes"	 ///
610	"Prostate"	 ///
620	"Testicule"	 ///
640	"Rein"	 ///
650	"Voies urinaires"	 ///
670	"Vessie"	 ///
700	"Système nerveux central"	 ///
730	"Thyroïde"	 ///
810	"Maladie de Hodgkin"	 ///
820	"LMNH"	 ///
880	"Myélome multiple"	 ///
910	"Leucémie lymphoïde"	 ///
920	"Leucémie myéloïde"	 ///
930	"Leucémie SAI"	 ///
998	"Autres"	 ///
999	"Site primitif inconnu" ///
1000 "Total", modify

label val loc3num loc3num


gen pc= nbcas/ (totalcas)*100
save "3_graphique_camemberts.dta",replace

use "3_graphique_camemberts.dta", clear
quietly sum nbcas if indic=="Incidence" & sexe==1, detail
graph pie nbcas if indic=="Incidence" & sexe==1,  over(loc3num) sort ///
pie(1, color(blue%10) explode)  /// vessie
pie(2, color(yellow) explode)  /// peau
pie(3, color(brown) explode)  /// crcc
pie(4, color(green) explode)  /// poumon
pie(5, color(dknavy%100) explode)  /// prostate
pie(6, color(white) explode) /// autre
plabel(1 percent, color(black) format(%9.1f) size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f) size(medsmall)) ///
plabel(3 percent, color(black) format(%9.1f) size(medsmall))  ///
plabel(4 percent, color(white) format(%9.1f) size(medsmall))  ///
plabel(5 percent, color(white) format(%9.1f) size(medsmall))  ///
plabel(6 percent, color(black) format(%9.1f) size(medsmall))  ///
line(lcolor(dknavy) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
graph export "Gr13_Pie_Chart_Incidence_Homme.emf", replace

*legend(row(2) size(medsmall) span)  

sum nbcas if indic=="Mortalité" & sexe==1, detail 
graph pie nbcas if indic=="Mortalité" & sexe==1,  over(loc3num) sort ///
pie(1, color(cranberry) explode)  /// foie
pie(2, color(brown) explode)  /// crc
pie(3, color(orange) explode)  /// pancreas
pie(4, color(dknavy%100) explode)  /// prostate
pie(5, color(green) explode)  /// poumon
pie(6, color(white) explode)  ///
plabel(1 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall)) ///
plabel(3 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(6 percent, color(black) format(%9.1f)  size(medsmall))  ///
line(lcolor(dknavy) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
graph export "Gr14_Pie_Chart_Mortalite_Homme.emf", replace

  
*  legend(rows(2) size(medsmall) span) ///



   sum nbcas if indic=="Incidence" & sexe==2, detail
graph pie nbcas if indic=="Incidence" & sexe==2, over(loc3num) sort  ///
pie(1, color(cranberry%10) explode)  /// corps utérus
pie(2, color(yellow) explode)  /// Mélanome
pie(3, color(brown) explode)  /// crc
pie(4, color(green) explode)  /// poumon
pie(5, color(pink) explode)  /// sein
pie(6, color(white) explode)  ///
plabel(1 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(3 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(6 percent, color(black) format(%9.1f)  size(medsmall))  ///
line(lcolor(cranberry) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
 graph export "Gr15_Pie_Chart_Incidence_Femme.emf", replace
  
  *legend(rows(2) size(medsmall) span) ///
  

quietly sum nbcas if indic=="Mortalité" & sexe==2, detail
graph pie nbcas if indic=="Mortalité" & sexe==2, over(loc3num) sort  ///
pie(1, color(cranberry%60) explode)  /// ovaire et annexes
pie(2, color(brown) explode)  /// crc
pie(3, color(orange) explode)  /// pancreas
pie(4, color(green) explode)  /// poumons
pie(5, color(pink) explode)  /// sein
pie(6, color(white) explode)  ///
plabel(1 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(3 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(6 percent, color(black) format(%9.1f)  size(medsmall))  ///
line(lcolor(cranberry) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
 graph export "Gr16_Pie_Chart_Mortalite_Femme.emf", replace
  
*legend(rows(2) size(medsmall) span) ///
  
 *-PAR CLASSE D'ÂGE
 
 *------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
  * on doit repartir du fichier contenant les cas et la population

use "6_nbcas_incident_et_morta_pop.dta", clear

tab loc3num,m
tab adiag

keep if loc3num!=1000  & loc3num!=1001 &  loc3num!=440 & cat==1
tab loc3num,m

tab clage
egen clage2=cut(clage), at(0,20,50,75,150)
tab clage2
drop clage
rename clage2 clage
tabstat nbcas if indic=="Incidence", stat(sum)
/*

 

    Variable |       Sum
-------------+----------
       nbcas |      5367
------------------------

------------------------------

*/
table ( loc3num ) ( sexe ) () if indic=="Incidence" & clage==20, statistic(total nbcas) // pour check Elisa
table ( loc3num ) ( sexe ) () if indic=="Mortalité" & clage==20, statistic(total nbcas)

collapse (sum) nbcas, by(indic indic_num clage loc3 loc3num sexe)

tabstat nbcas  if indic=="Incidence" , stat(sum)
/*

    Variable |       Sum
-------------+----------
       nbcas |     12905

    Variable |       Sum
-------------+----------
       nbcas |     13124


*/


gsort  indic sexe clage -nbcas
by  indic sexe clage : egen totalcas=total(nbcas)
by  indic sexe clage : gen num=_n
gen num2=num // au cas où les autres soient dans les 5 premières localisations
replace num=998 if num<=5 & loc3num==998
gsort  indic sexe clage num
by  indic sexe clage : replace num=_n
replace num=6 if num>5
edit if num!=num2
drop num2 // après check que tout est bien ok


replace loc3="Autres" if num>5
replace loc3num=998  if num>5
drop if nbcas==0 // à voir si cela marche
*replace loc3="Autres" if nbcas==0
*replace loc3num=998  if nbcas==0

* on vàrifie que tout est ok et que le totalcas est bien égal au tabstat ci dessous
tabstat nbcas if sexe==1 & indic_num==1 & clage==0, stat(sum)
tabstat nbcas if sexe==1 & indic_num==1 & clage==20, stat(sum)

collapse (sum) nbcas, by(sexe loc3 loc3num indic indic_num clage)
gsort sexe indic clage -nbcas
tabstat nbcas if sexe==1 & indic_num==1 & clage==0, stat(sum)
tabstat nbcas if sexe==1 & indic_num==1 & clage==20, stat(sum)


sort sexe indic clage -nbcas


label def loc3num ///		
100	"Lèvre, Bouche, Pharynx"	 ///
150	"Œsophage"	 ///
160	"Estomac"	 ///
170	"Intestin grêle"	 ///
200	"Côlon et rectum"	 ///
210	"Anus et canal anal"	 ///
220	"Foie"	 ///
230	"Vésicule et voies biliaires"	 ///  et extra-hépatiques
250	"Pancréas"	 ///
320	"Larynx"	 ///
330	"Poumon et bronches"	 ///
380	"Plèvre et mésothéliome"	 ///
400	"Os"	 ///
430	"Mélanome de la peau"	 ///
470	"Tissus mous"	 ///
500	"Sein"	 ///
530	"Col de l'utérus"	 ///
540	"Corps de l'utérus"	 ///
560	"Ovaires et annexes"	 ///
610	"Prostate"	 ///
620	"Testicule"	 ///
640	"Rein"	 ///
650	"Voies urinaires"	 ///
670	"Vessie"	 ///
700	"Système nerveux central"	 ///
730	"Thyroïde"	 ///
810	"Maladie de Hodgkin"	 ///
820	"LMNH"	 ///
880	"Myélome multiple"	 ///
910	"Leucémie lymphoïde"	 ///
920	"Leucémie myéloïde"	 ///
930	"Leucémie SAI"	 ///
998	"Autres"	 ///
999	"Site primitif inconnu" ///
1000 "Total", modify

label val loc3num loc3num
label val loc3num loc3num

save "3_graphique_camemberts_clage.dta",replace

use "3_graphique_camemberts_clage.dta", clear
/*
tab clage

      clage |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |         22       23.40       23.40
         20 |         24       25.53       48.94
         50 |         24       25.53       74.47
         75 |         24       25.53      100.00
------------+-----------------------------------
      Total |         94      100.00

	  */


* POUR LA CLAGE 0 & clage==0
quietly sum nbcas if indic=="Incidence" & sexe==1 & clage==0, detail
graph pie nbcas if indic=="Incidence" & sexe==1 & clage==0,  over(loc3num) sort  ///
pie(1, color(dknavy%10) explode)  ///
pie(2, color(dknavy%20) explode)  ///
pie(3, color(dknavy%40) explode)  ///
pie(4, color(dknavy%60) explode)  ///
pie(5, color(dknavy%100) explode)  ///
pie(6, color(white) explode)  ///
plabel(1 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(3 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(white) format(%9.1f)  size(medsmall))   ///
plabel(6 percent, color(black) format(%9.1f)  size(medsmall))  ///
line(lcolor(dknavy) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1))   caption(N=`r(sum)', size(*1)) 
graph export "Gr17_Clage0_Pie_Chart_Incidence_Homme.emf", replace
  *legend(rows(2) size(medsmall) span) ///
**# Bookmark #1
  
   list if indic=="Mortalité" & sexe==1 & clage==0
quietly sum nbcas if indic=="Mortalité" & sexe==1 & clage==0, detail 
graph pie nbcas if indic=="Mortalité" & sexe==1 & clage==0 & loc3!="Autres",  over(loc3num) sort /// ATTENTION QUE 5 CAUSE DE DECES CAR QUE 6 DECES et autres est à 0 et prend un camembdert donc on le vire
pie(1, color(dknavy%10) explode)  ///
pie(2, color(dknavy%20) explode)  ///
pie(3, color(dknavy%40) explode)  ///
pie(4, color(dknavy%60) explode)  ///
pie(5, color(dknavy%100) explode)  ///
pie(6, color(white) explode)  ///
plabel(1 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall)) ///
plabel(3 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(white) format(%9.1f)  size(medsmall))   ///
plabel(6 percent, color(black) format(%9.1f)  size(medsmall))  ///
line(lcolor(dknavy) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
graph export "Gr18_Clage0_Pie_Chart_Mortalite_Homme.emf", replace
  
 
quietly sum nbcas if indic=="Incidence" & sexe==2 & clage==0, detail 
graph pie nbcas if indic=="Incidence" & sexe==2 & clage==0, over(loc3num) sort  ///
pie(1, color(cranberry%10) explode)  ///
pie(2, color(cranberry%20) explode)  ///
pie(3, color(cranberry%40) explode)  ///
pie(4, color(cranberry%60) explode)  ///
pie(5, color(cranberry%100) explode)  ///
pie(6, color(white) explode)  ///
plabel(1 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(3 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(6 percent, color(black) format(%9.1f)  size(medsmall))  ///
line(lcolor(cranberry) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
 graph export "Gr19_Clage0_Pie_Chart_Incidence_Femme.emf", replace

 *legend(rows(2) size(medsmall) span) ///
  
  *ATTENTION QUE 4 CLASSES, PAS DE AUTRE - seulement 1 cas en 2020-2021 on ne va pas le mettre
list if indic=="Mortalité" & sexe==2 & clage==0
quietly sum nbcas if indic=="Mortalité" & sexe==2 & clage==0, detail 
graph pie nbcas if indic=="Mortalité" & sexe==2 & clage==0 & loc3!="Autres", over(loc3num) sort  /// ON REMET LA MM CONTRAINTE QUE POUR LES HOMMES
pie(1, color(cranberry%10) explode)  ///
pie(2, color(cranberry%20) explode)  ///
pie(3, color(cranberry%40) explode)  ///
pie(4, color(cranberry%60) explode)  ///
pie(5, color(cranberry%100) explode)  ///
pie(6, color(white) explode)  ///
plabel(1 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall)) ///
plabel(3 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(white) format(%9.1f)  size(medsmall))   ///
plabel(6 percent, color(black) format(%9.1f)  size(medsmall))  ///
line(lcolor(cranberry) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
 graph export "Gr20_Clage0_Pie_Chart_Mortalite_Femme.emf", replace
   *pie(1, color(white) explode)  ///
 *legend(rows(2) size(medsmall) span) ///
 
 
 * POUR LA CLAGE 20 & clage==20
 quietly sum nbcas if indic=="Incidence" & sexe==1 & clage==20, detail
graph pie nbcas if indic=="Incidence" & sexe==1 & clage==20,  over(loc3num) sort ///
pie(1, color(eggshell) explode)  /// LMNH
pie(2, color(lavender) explode)  /// Thyroide
pie(3, color(brown) explode)  ///  crc
pie(4, color(midblue) explode)  /// testicule
pie(5, color(yellow) explode)  /// mélanome
pie(6, color(white) explode)  ///
plabel(1 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall)) ///
plabel(3 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(black) format(%9.1f)  size(medsmall))   ///
plabel(6 percent, color(black) format(%9.1f)  size(medsmall))  ///
line(lcolor(dknavy) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
graph export "Gr21_Clage20_Pie_Chart_Incidence_Homme.emf", replace

*  legend(rows(2) size(medsmall) span) ///

quietly sum nbcas if indic=="Mortalité" & sexe==1 & clage==20, detail
graph pie nbcas if indic=="Mortalité" & sexe==1 & clage==20,  over(loc3num) sort ///
pie(1, color(cyan) explode)  /// rein
pie(2, color(brown) explode)  /// 
pie(3, color(dknavy%20) explode)  /// C80
pie(4, color(mint) explode)  /// SNC
pie(5, color(green) explode)  /// poumons
pie(6, color(white) explode)  ///
plabel(1 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall)) ///
plabel(3 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(white) format(%9.1f)  size(medsmall))   ///
plabel(6 percent, color(black) format(%9.1f)  size(medsmall))  ///
line(lcolor(dknavy) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
graph export "Gr22_Clage20_Pie_Chart_Mortalite_Homme.emf", replace

*legend(rows(2) size(medsmall) span) ///
  
 
quietly sum nbcas if indic=="Incidence" & sexe==2 & clage==20, detail 
graph pie nbcas if indic=="Incidence" & sexe==2 & clage==20, over(loc3num) sort  ///
pie(1, color(cranberry%50) explode)  /// Col de l'utérus
pie(2, color(brown) explode)  ///
pie(3, color(lavender) explode)  /// thyroide
pie(4, color(yellow) explode)  ///méla
pie(5, color(white) explode)  ///
pie(6, color(pink) explode)  /// sein
plabel(1 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(3 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(6 percent, color(white) format(%9.1f)  size(medsmall))   ///
line(lcolor(cranberry) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
 graph export "Gr23_Clage20_Pie_Chart_Incidence_Femme.emf", replace

 *legend(rows(2) size(medsmall) span) ///
  

quietly sum nbcas if indic=="Mortalité" & sexe==2 & clage==20, detail
graph pie nbcas if indic=="Mortalité" & sexe==2 & clage==20, over(loc3num) sort  ///
pie(1, color(cyan) explode)  /// rein
pie(2, color(orange) explode)  /// pancreas
pie(3, color(brown) explode)  /// crc
pie(4, color(green) explode)  /// poumons
pie(5, color(white) explode)  ///
pie(6, color(pink) explode)  ///
plabel(1 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(3 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(6 percent, color(white) format(%9.1f)  size(medsmall))  ///
line(lcolor(cranberry) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
 graph export "Gr24_Clage20_Pie_Chart_Mortalite_Femme.emf", replace
  
  
  *legend(rows(2) size(medsmall) span) ///
  
 
 * POUR LA CLAGE 50 & clage==50
quietly sum nbcas if indic=="Incidence" & sexe==1 & clage==50, detail
graph pie nbcas if indic=="Incidence" & sexe==1 & clage==50,  over(loc3num) sort ///
pie(1, color(yellow) explode)  /// mélanome
pie(2, color(teal) explode)  /// LBP
pie(3, color(brown) explode)  ///
pie(4, color(green) explode)  ///
pie(5, color(white) explode)  ///
pie(6, color(dknavy%100) explode)  ///
plabel(1 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall)) ///
plabel(3 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(6 percent, color(white) format(%9.1f)  size(medsmall))  ///
line(lcolor(dknavy) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
graph export "Gr25_Clage50_Pie_Chart_Incidence_Homme.emf", replace
  
  
quietly sum nbcas if indic=="Mortalité" & sexe==1 & clage==50, detail 
graph pie nbcas if indic=="Mortalité" & sexe==1 & clage==50,  over(loc3num) sort ///
pie(1, color(teal) explode)  ///
pie(2, color(brown) explode)  /// LBP
pie(3, color(dknavy%100) explode)  ///
pie(4, color(orange) explode)  ///
pie(5, color(green) explode)  ///
pie(6, color(white) explode)  ///
plabel(1 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall)) ///
plabel(3 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(6 percent, color(black) format(%9.1f)  size(medsmall))  ///
line(lcolor(dknavy) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
graph export "Gr26_Clage50_Pie_Chart_Mortalite_Homme.emf", replace
**# Bookmark #1
  
quietly sum nbcas if indic=="Incidence" & sexe==2 & clage==50, detail 
graph pie nbcas if indic=="Incidence" & sexe==2 & clage==50, over(loc3num) sort  ///
pie(1, color(cranberry%10) explode)  /// corps utérus
pie(2, color(yellow) explode)  ///
pie(3, color(brown) explode)  ///
pie(4, color(green) explode)  ///
pie(5, color(white) explode)  ///
pie(6, color(pink) explode)  ///
plabel(1 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(3 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(6 percent, color(white) format(%9.1f)  size(medsmall))   ///
line(lcolor(cranberry) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
 graph export "Gr27_Clage50_Pie_Chart_Incidence_Femme.emf", replace
  
  

quietly sum nbcas if indic=="Mortalité" & sexe==2 & clage==50, detail 
graph pie nbcas if indic=="Mortalité" & sexe==2 & clage==50, over(loc3num) sort  ///
pie(1, color(cranberry%60) explode)  /// ovaire et annex
pie(2, color(brown) explode)  ///
pie(3, color(orange) explode)  ///
pie(4, color(pink) explode)  ///
pie(5, color(green) explode)  ///
pie(6, color(white) explode)  ///
plabel(1 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(3 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(white) format(%9.1f)  size(medsmall))   ///
plabel(6 percent, color(black) format(%9.1f)  size(medsmall))  ///
line(lcolor(cranberry) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
 graph export "Gr28_Clage50_Pie_Chart_Mortalite_Femme.emf", replace
 
 
 
 * POUR LA CLAGE 75 & clage==75
quietly sum nbcas if indic=="Incidence" & sexe==1 & clage==75, detail 
graph pie nbcas if indic=="Incidence" & sexe==1 & clage==75,  over(loc3num) sort ///
pie(1, color(blue%10) explode)  ///
pie(2, color(yellow) explode)  ///
pie(3, color(brown) explode)  ///
pie(4, color(green) explode)  ///
pie(5, color(dknavy%100) explode)  ///
pie(6, color(white) explode)  ///
plabel(1 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall)) ///
plabel(3 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(white) format(%9.1f) size(medsmall))   ///
plabel(6 percent, color(black) format(%9.1f)  size(medsmall))  ///
line(lcolor(dknavy) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
graph export "Gr29_Clage75_Pie_Chart_Incidence_Homme.emf", replace
  
quietly sum nbcas if indic=="Mortalité" & sexe==1 & clage==75, detail 
graph pie nbcas if indic=="Mortalité" & sexe==1 & clage==75,  over(loc3num) sort ///
pie(1, color(cranberry) explode)  ///
pie(2, color(orange) explode)  ///
pie(3, color(brown) explode)  ///
pie(4, color(dknavy%100) explode)  ///
pie(5, color(green) explode)  ///
pie(6, color(white) explode)  ///
plabel(1 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall)) ///
plabel(3 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(white) format(%9.1f) size(medsmall))   ///
plabel(6 percent, color(black) format(%9.1f)  size(medsmall))  ///
line(lcolor(dknavy) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
graph export "Gr30_Clage75_Pie_Chart_Mortalite_Homme.emf", replace
  
  
quietly sum nbcas if indic=="Incidence" & sexe==2 & clage==75, detail 
graph pie nbcas if indic=="Incidence" & sexe==2 & clage==75, over(loc3num) sort  ///
pie(1, color(orange) explode)  ///
pie(2, color(yellow) explode)  ///
pie(3, color(brown) explode)  ///
pie(4, color(green) explode)  ///
pie(5, color(pink) explode)  ///
pie(6, color(white) explode)  ///
plabel(1 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(3 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(white) format(%9.1f) size(medsmall))   ///
plabel(6 percent, color(black) format(%9.1f)  size(medsmall))  ///
line(lcolor(cranberry) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
 graph export "Gr31_Clage75_Pie_Chart_Incidence_Femme.emf", replace
  
  

quietly sum nbcas if indic=="Mortalité" & sexe==2 & clage==75, detail 
graph pie nbcas if indic=="Mortalité" & sexe==2 & clage==75, over(loc3num) sort  ///
pie(1, color(cranberry%60) explode)  /// ovaire et annexes
pie(2, color(orange) explode)  /// pancreas
pie(3, color(brown) explode)  /// crc 
pie(4, color(green) explode)  /// poumon
pie(5, color(pink) explode)  ///
pie(6, color(white) explode)  ///
plabel(1 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(2 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(3 percent, color(black) format(%9.1f)  size(medsmall))  ///
plabel(4 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(5 percent, color(white) format(%9.1f)  size(medsmall))  ///
plabel(6 percent, color(black) format(%9.1f)  size(medsmall))  ///
line(lcolor(cranberry) lwidth(vthin)) ///
legend(region(lcolor(white)))  ///
graphregion(fcolor(white) lcolor(white))  caption(N=`r(sum)', size(*1)) 
 graph export "Gr32_Clage75_Pie_Chart_Mortalite_Femme.emf", replace
  
 