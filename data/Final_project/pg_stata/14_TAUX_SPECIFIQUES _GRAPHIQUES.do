




* Répertoire 0û vont se trouve les fichiers intermédiaires
local donnees="C:\INCIDENCE_RGT\DONNEES\"

cd `donnees'


  
use "6_nbcas_incident_et_morta_pop.dta", clear
order indic*
label var adiag "Années"
label var sexe "Sexe"
label def sexe 1 "Hommes" 2 "Femmes"
label val sexe sexe
replace clage=0 if clage==1
keep if cat==1

  collapse (sum) nbcas (sum) pop, by(clage sexe loc3 loc3num indic)
tabstat nbcas pop if loc3num==1000 & indic=="Incidence", stat(sum)
   /*
   
   Stats |     nbcas       pop
---------+--------------------
     Sum |     12905   2431351
------------------------------

*/
  
label def clage 0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" ///
20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" ///
60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +"
label val clage clage


  gen double taux_spe=nbcas/pop*100000

keep indic sexe clage loc3 loc3num nbcas taux_spe

reshape wide taux_spe nbcas, i(sexe clage loc3 loc3num) j(indic) string

rename nbcasIncidence nbcasincid
rename nbcasMortalité nbcasmorta
rename taux_speIncidence txincid
rename taux_speMortalité txmorta

reshape wide nbcasincid nbcasmorta txincid txmorta, i( clage loc3 loc3num) j(sexe) 

for var nbcasincid1 nbcasincid2 nbcasmorta1 nbcasmorta2 :  replace X=X/2
 label var nbcasincid1 "Incidence hommes"
 label var nbcasincid2 "Incidence femmes"
 label var nbcasmorta1 "Mortalité hommes"
 label var nbcasmorta2 "Mortalité femmes"

 label var txincid1 "Taux incidence hommes"
 label var txincid2 "Taux incidence femmes"
 label var txmorta1 "Taux mortalité hommes"
 label var txmorta2 "Taux mortalité femmes"
**# Bookmark #1
drop if loc3num==1001
 replace loc3="Total" if loc3=="C00-C95"
 
  * Pour répartir les barres sur l'axe des X
  gen clage1=clage-1
  gen clage2=clage+1
  
  save "3_graphiques_taux_specifiques.dta",replace
  
  
  use "3_graphiques_taux_specifiques.dta", clear
preserve
	keep if loc3num==1000
twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)),  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
ylabel(0(50)350, labsize(small) angle(horizontal) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white))  ///
title("Tous cancers", size(medlarge) color(black))  /// 
yline(3500, lwidth(vvvthin) lcolor(gs9))  /// spécial ts cancer ligne horizontale
ylabel(0(500)3500, labsize(vsmall) angle(horizontal))  /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9))
graph export "11_TOUSCANCERS_Gr_taux_spe.emf", replace
restore


* C00-C14
preserve
	keep if loc3num==100 
twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6)  size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Lèvre - Cavité buccale - Pharynx", size(medlarge) color(black))  /// 
ylabel(0(20)120, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(5)30, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "21_LBP_Gr_taux_spe.emf", replace
restore




* c15
preserve
	keep if loc3num==150 
	twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Oesophage", size(medlarge) color(black))  /// 
ylabel(0(10)60, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(5)30, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "31_Oesophage_Gr_taux_spe.emf", replace
restore



* c16
preserve
	keep if loc3num==160 
twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Estomac", size(medlarge) color(black))  /// 
ylabel(0(20)120, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(5)30, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "41_Estomac_Gr_taux_spe.emf", replace
restore







* c17
preserve
	keep if loc3num==170 
twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Intestin grêle", size(medlarge) color(black))  /// 
ylabel(0(10)40, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(5)20, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "51_Intestin_grele_Gr_taux_spe.emf", replace
restore


**# Bookmark #1


* c18-20
preserve
	keep if loc3num==200 
twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Côlon et Rectum", size(medlarge) color(black))  /// 
yline(400, lwidth(vvvthin) lcolor(gs9))  /// spécial rectum ligne horizontale
ylabel(0(100)400, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(10)40, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "61_CR_Gr_taux_spe.emf", replace
restore



* c21
preserve
	keep if loc3num==210 
	twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Anus et canal anal", size(medlarge) color(black))  /// 
ylabel(0(5)30, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(1)6, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "71_Anus_taux_spe.emf", replace
restore



* c22
preserve
	keep if loc3num==220 
	twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Foie", size(medlarge) color(black))  /// 
ylabel(0(50)150, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(5)15, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "81_Foie_taux_spe.emf", replace
restore




* c23
preserve
	keep if loc3num==230 
		twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Vésicule et voies biliaires", size(medlarge) color(black))  /// 
ylabel(0(10)40, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(2)8, labsize(vsmall) angle(horizontal) axis(2))
graph export "91_Vesicule_taux_spe.emf", replace
restore




* c25
preserve
	keep if loc3num==250 
twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Pancréas", size(medlarge) color(black))  /// 
ylabel(0(50)200, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(5)20, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "101_Pancreas_taux_spe.emf", replace
restore




* c32
preserve
	keep if loc3num==320 
	twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Larynx", size(medlarge) color(black))  /// 
ylabel(0(5)60, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(2)12, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "111_Larynx_taux_spe.emf", replace
restore



* c33
preserve
	keep if loc3num==330 
		twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Poumon et bronches", size(medlarge) color(black))  /// 
yline(500, lwidth(vvvthin) lcolor(gs9))  /// spécial poumon ligne horizontale
ylabel(0(100)500, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(10)50, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "121_Poumon_taux_spe.emf", replace
restore





* c38
preserve
	keep if loc3num==380 
twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Plèvre et Mésothéliome", size(medlarge) color(black))  /// 
ylabel(0(5)20, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(2)8, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "131_Plevre_taux_spe.emf", replace
restore





* c41
preserve
	keep if loc3num==400 
twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Os", size(medlarge) color(black))  /// 
ylabel(0(2)10, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(2)10, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "141_Os_taux_spe.emf", replace
restore

**# Bookmark #2

* c43
preserve
	keep if loc3num==430 
twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Mélanome de la peau", size(medlarge) color(black))  /// 
yline(250, lwidth(vvvthin) lcolor(gs9))  /// spécial mélanome ligne horizontale
ylabel(0(50)250, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(5)25, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "151_Melanome_taux_spe.emf", replace
restore



* c44
preserve
	keep if loc3num==440 
twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))  /// 
(line txincid1 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Cancer de la peau autre que mélanome", size(medlarge) color(black))  /// 
yline(250, lwidth(vvvthin) lcolor(gs9))  /// spécial mélanome ligne horizontale
ylabel(0(200)1200, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(20)120, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "1551_Peau_Autre_taux_spe.emf", replace
restore

* c47
preserve
	keep if loc3num==470 
	twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Tissus Mous", size(medlarge) color(black))  /// 
ylabel(0(10)50, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(2)10, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "161_Tissus_Mous_taux_spe.emf", replace
restore

*------------------------------ QUE POUR LES HOMMES
* PROSTATE HOMMES
* c61
preserve
	keep if loc3num==610 
twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Prostate", size(medlarge) color(black))  /// 
ylabel(0(100)1000, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(20)100, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "211_Prostate_taux_spe.emf", replace
restore



* c62
preserve
	keep if loc3num==620 
twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2))   /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" ) rows(2)  position(6)  size(vsmall) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Testicules", size(medlarge) color(black))  /// 
ylabel(0(10)50, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(5)25, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "221_Testicules_taux_spe.emf", replace
restore





**# Bookmark #1

* c64
preserve
keep if loc3num==640 
	twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Rein", size(medlarge) color(black))  /// 
ylabel(0(20)160, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(2)16, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "231_Rein_taux_spe.emf", replace
restore




* c65
preserve
keep if loc3num==650 
	twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))  /// 
(line txmorta1 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Voies urinaires", size(medlarge) color(black))  /// 
ylabel(0(10)70, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(1)7, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "2331_Voix_Urinaires_taux_spe.emf", replace
restore




**# Bookmark #2


* c67
preserve
keep if loc3num==670 
	twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Vessie", size(medlarge) color(black))  /// 
yline(400, lwidth(vvvthin) lcolor(gs9))  /// spécial vessie ligne horizontale
ylabel(0(100)400, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(5)20, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "241_Vessie_taux_spe.emf", replace
restore





* c700
preserve
keep if loc3num==700 
	twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Système nerveux central", size(medlarge) color(black))  /// 
ylabel(0(10)50, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(1)5, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "251_SNC_taux_spe.emf", replace
restore





* c730
preserve
keep if loc3num==730 
	twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Thyroïde", size(medlarge) color(black))  /// 
ylabel(0(10)50, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(2)10, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "261_Thyroide_taux_spe.emf", replace
restore





* c810
preserve
keep if loc3num==810 
	twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Maladie de Hodgkin", size(medlarge) color(black))  /// 
ylabel(0(5)20, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(1)4, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "271_Hodgkin_taux_spe.emf", replace
restore





* c820
preserve
keep if loc3num==820 
twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Lymphome malin non Hodgkinien", size(medlarge) color(black))  /// 
yline(150, lwidth(vvvthin) lcolor(gs9))  /// spécial LMNH ligne horizontale
ylabel(0(50)150, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(10)30, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "281_LMNH_taux_spe.emf", replace
restore








* c880
preserve
keep if loc3num==880 
twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Myélome multiple", size(medlarge) color(black))  /// 
ylabel(0(20)100, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(4)20, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "291_Myelome_Multiple_taux_spe.emf", replace
restore






* c910
preserve
keep if loc3num==910 
twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Leucémie Lymphoïde", size(medlarge) color(black))  /// 
yline(100, lwidth(vvvthin) lcolor(gs9))  /// spécial LEUCEMIE LYMP ligne horizontale
ylabel(0(20)100, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(4)20, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "301_Leucemie_Lymphoide_taux_spe.emf", replace
restore





* c920
preserve
keep if loc3num==920 
twoway  /// 
(line txincid1 clage, sort lcolor(dknavy))   /// 
(line txmorta1 clage, sort lcolor(cranberry))  /// 
(bar nbcasincid1 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta1 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Leucémie Myéloïde", size(medlarge) color(black))  /// 
yline(80, lwidth(vvvthin) lcolor(gs9))  /// spécial LEUCEMIE mye ligne horizontale 
ylabel(0(20)80, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(4)16, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "311_Leucemie_Myeloide_taux_spe.emf", replace
restore


*-----------------------------------------------------------------------------------------------------------
* CHEZ LES FEMMES


**# Bookmark #2

use "3_graphiques_taux_specifiques.dta", clear
preserve
	keep if loc3num==1000
twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)),  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
ylabel(0(50)350, labsize(vsmall) angle(horizontal) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white))  ///
title("Tous cancers", size(medlarge) color(black))  /// 
yline(3500, lwidth(vvvthin) lcolor(gs9))  /// spécial ts cancer ligne horizontale
ylabel(0(500)3500, labsize(vsmall) angle(horizontal))  /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9))
graph export "12_TOUSCANCERS_Gr_taux_spe.emf", replace
restore


* C00-C14
preserve
	keep if loc3num==100 
twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Lèvre - Cavité buccale - Pharynx", size(medlarge) color(black))  /// 
ylabel(0(20)120, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(5)30, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "22_LBP_Gr_taux_spe.emf", replace
restore



* c15
preserve
	keep if loc3num==150 
	twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Oesophage", size(medlarge) color(black))  /// 
ylabel(0(10)60, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(5)30, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "32_Oesophage_Gr_taux_spe.emf", replace
restore



* c16
preserve
	keep if loc3num==160 
twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Estomac", size(medlarge) color(black))  /// 
ylabel(0(20)120, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(5)30, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "42_Estomac_Gr_taux_spe.emf", replace
restore







* c17
preserve
	keep if loc3num==170 
twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Intestin grêle", size(medlarge) color(black))  /// 
ylabel(0(10)40, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(5)20, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "52_Intestin_grele_Gr_taux_spe.emf", replace
restore




* c18-20
preserve
	keep if loc3num==200 
twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Côlon et Rectum", size(medlarge) color(black))  /// 
yline(400, lwidth(vvvthin) lcolor(gs9))  /// spécial rectum ligne horizontale
ylabel(0(100)400, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(10)40, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "62_CR_Gr_taux_spe.emf", replace
restore



* c21
preserve
	keep if loc3num==210 
	twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Anus et canal anal", size(medlarge) color(black))  /// 
ylabel(0(5)30, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(1)6, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "72_Anus_taux_spe.emf", replace
restore



* c22
preserve
	keep if loc3num==220 
	twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Foie", size(medlarge) color(black))  /// 
ylabel(0(50)150, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(5)15, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "82_Foie_taux_spe.emf", replace
restore




* c23
preserve
	keep if loc3num==230 
		twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Vésicule et voies biliaires", size(medlarge) color(black))  /// 
ylabel(0(10)40, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(2)8, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "92_Vesicule_taux_spe.emf", replace
restore




* c25
preserve
	keep if loc3num==250 
twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Pancréas", size(medlarge) color(black))  /// 
ylabel(0(50)200, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(5)20, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "102_Pancreas_taux_spe.emf", replace
restore




* c32
preserve
	keep if loc3num==320 
	twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Larynx", size(medlarge) color(black))  /// 
ylabel(0(5)60, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(2)12, labsize(vsmall) angle(horizontal) axis(2))  
graph export "112_Larynx_taux_spe.emf", replace
restore



* c33
preserve
	keep if loc3num==330 
		twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Poumon et bronches", size(medlarge) color(black))  /// 
yline(500, lwidth(vvvthin) lcolor(gs9))  /// spécial poumon ligne horizontale
ylabel(0(100)500, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(10)50, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "122_Poumon_taux_spe.emf", replace
restore





* c38
preserve
	keep if loc3num==380 
twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Plèvre et Mésothéliome", size(medlarge) color(black))  /// 
ylabel(0(5)20, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(2)8, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "132_Plevre_taux_spe.emf", replace
restore





* c41
preserve
	keep if loc3num==400 
twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Os", size(medlarge) color(black))  /// 
ylabel(0(2)10, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(2)10, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "142_Os_taux_spe.emf", replace
restore


* c43
preserve
	keep if loc3num==430 
twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Mélanome de la peau", size(medlarge) color(black))  /// 
yline(250, lwidth(vvvthin) lcolor(gs9))  /// spécial mélanome ligne horizontale
ylabel(0(50)250, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(5)25, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "152_Melanome_taux_spe.emf", replace
restore



* c44
preserve
	keep if loc3num==440 
twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Cancer de la peau autre que mélanome", size(medlarge) color(black))  /// 
yline(250, lwidth(vvvthin) lcolor(gs9))  /// spécial mélanome ligne horizontale
ylabel(0(200)1200, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(20)120, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "1552_Peau_Autre_taux_spe.emf", replace
restore


* c47
preserve
	keep if loc3num==470 
	twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Tissus Mous", size(medlarge) color(black))  /// 
ylabel(0(10)50, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(2)10, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "162_Tissus_Mous_taux_spe.emf", replace
restore



*-----------------QUE POUR LES FEMMES
* c50
preserve
	keep if loc3num==500 
twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Sein", size(medlarge) color(black))  /// 
ylabel(0(100)500, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(20)100, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "172_Sein_taux_spe.emf", replace
restore




* C53
preserve
	keep if loc3num==530 
	twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Col de l'utérus", size(medlarge) color(black))  /// 
ylabel(0(5)30, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(1)6, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "182_Col_uterus_taux_spe.emf", replace
restore



* c54
preserve
	keep if loc3num==540 
	twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Corps de l'utérus", size(medlarge) color(black))  /// 
ylabel(0(20)120, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(2)12, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "192_Corps_uterus_taux_spe.emf", replace
restore




* c56
preserve
	keep if loc3num==560 
twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Ovaires et annexes", size(medlarge) color(black))  /// 
ylabel(0(20)120, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(2)12, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "202_Ovaire_taux_spe.emf", replace
restore



* c64
preserve
keep if loc3num==640 
	twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Rein", size(medlarge) color(black))  /// 
ylabel(0(20)160, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(2)16, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "232_Rein_taux_spe.emf", replace
restore




* c65
preserve
keep if loc3num==650 
	twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Voies urinaires", size(medlarge) color(black))  /// 
ylabel(0(10)70, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(1)7, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "2332_Voix_Urinaires_taux_spe.emf", replace
restore





* c67
preserve
keep if loc3num==670 
	twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Vessie", size(medlarge) color(black))  /// 
yline(400, lwidth(vvvthin) lcolor(gs9))  /// spécial vessie ligne horizontale
ylabel(0(100)400, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(5)20, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "242_Vessie_taux_spe.emf", replace
restore





* c700
preserve
keep if loc3num==700 
	twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Système nerveux central", size(medlarge) color(black))  /// 
ylabel(0(10)50, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(1)5, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "252_SNC_taux_spe.emf", replace
restore





* c730
preserve
keep if loc3num==730 
	twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Thyroïde", size(medlarge) color(black))  /// 
ylabel(0(10)50, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(2)10, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "262_Thyroide_taux_spe.emf", replace
restore





* c810
preserve
keep if loc3num==810 
	twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Maladie de Hodgkin", size(medlarge) color(black))  /// 
ylabel(0(5)20, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(1)4, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "272_Hodgkin_taux_spe.emf", replace
restore





* c820
preserve
keep if loc3num==820 
twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Lymphome malin non Hodgkinien", size(medlarge) color(black))  /// 
yline(150, lwidth(vvvthin) lcolor(gs9))  /// spécial LMNH ligne horizontale
ylabel(0(50)150, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(10)30, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "282_LMNH_taux_spe.emf", replace
restore








* c880
preserve
keep if loc3num==880 
twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Myélome multiple", size(medlarge) color(black))  /// 
ylabel(0(20)100, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(4)20, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "292_Myelome_Multiple_taux_spe.emf", replace
restore






* c910
preserve
keep if loc3num==910 
twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Leucémie Lymphoïde", size(medlarge) color(black))  /// 
yline(100, lwidth(vvvthin) lcolor(gs9))  /// spécial LEUCEMIE LYMP ligne horizontale
ylabel(0(20)100, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(4)20, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "302_Leucemie_Lymphoide_taux_spe.emf", replace
restore





* c920
preserve
keep if loc3num==920 
twoway  /// 
(line txincid2 clage, sort lcolor(dknavy))  /// 
(line txmorta2 clage, sort lcolor(cranberry))  ///  
(bar nbcasincid2 clage1, sort yaxis(2) fcolor(dknavy%40) lwidth(none) barwidth(2)) /// 
(bar nbcasmorta2 clage2, sort yaxis(2) fcolor(cranberry%40) lcolor(cranberry%50) lwidth(none) barwidth(2)) ,  /// 
ytitle(Taux spécifique pour 100 000 personnes/an) /// 
ytitle(, size(small) margin(small)) /// 
ylabel(, grid glwidth(vvvthin) glcolor(gs9)) ///
ytitle(Nombre moyen annuel , axis(2))  /// 
ytitle(, size(small) orientation(rvertical) margin(small) alignment(top) axis(2)) /// 
xtitle(Classe d'âge)  /// 
xtitle(, size(small)) /// 
xlabel(0 "00-04" 5 "05-09" 10 "10-14" 15 "15-19" 20 "20-24" 25 "25-29" 30 "30-34" 35 "35-39" 40 "40-44" 45 "45-49" 50 "50-54" 55 "55-59" 60 "60-64" 65 "65-69" 70 "70-74" 75 "75-79" 80 "80-84" 85 "85 et +", labels labsize(small) angle(forty_five))  /// 
xlabel(, nogrid) ///
legend(order(1 "Taux spécifique incidence"  2 "Taux spécifique mortalité"  3  "Nombre nouveaux cancers" 4 "Nombre décès" )  rows(2) position(6) size(small) region(fcolor(white) lcolor(white))) /// 
graphregion(fcolor(white) lcolor(white)) ///
title("Leucémie Myéloïde", size(medlarge) color(black))  ///
yline(80, lwidth(vvvthin) lcolor(gs9))  /// spécial LEUCEMIE mye ligne horizontale 
ylabel(0(20)80, labsize(vsmall) angle(horizontal))  /// 
ylabel(0(4)16, labsize(vsmall) angle(horizontal) axis(2)) 
graph export "312_Leucemie_Myeloide_taux_spe.emf", replace
restore




