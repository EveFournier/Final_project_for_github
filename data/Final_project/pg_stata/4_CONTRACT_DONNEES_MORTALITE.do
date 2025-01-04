

*-----------------------------------------------------------------------------------
*
*                                        DEBUT PROGRAMME
*
*-----------------------------------------------------------------------------------


* Répertoire 0û vont se trouve les fichiers intermédiaires



local donnees="C:\INCIDENCE_RGT\DONNEES\"

cd `donnees'

use "6_morta_geneve.dta", clear
*drop if cim10def=="C44"
label var loc3 "Localisation primitive CIM10"
label var loc3num "Localisation primitive CIM10"
label var adiag "Année"
replace loc3=trim(loc3)
save  "6_morta_geneve.dta", replace




*-----------------------------------------------------------------------------------
*
*    CONCEPTION DU TABLEAU 1
*
*-----------------------------------------------------------------------------------



* OBTENTION D'UN FICHIER DE DONNEES AGREGEES : nbre de cas par année, sexe, classe age
* et par localisation nlicdo3
* on n'a que les invasifs ici

use "6_morta_geneve.dta", clear // 1821
tab cat
tab cat if loc3num!=440 
/*
tab cat

         cat |      Freq.     Percent        Cum.
-------------+-----------------------------------
  1. Invasif |      1,747       95.94       95.94
    3. Bénin |          8        0.44       96.38
4. Incertain |         66        3.62      100.00
-------------+-----------------------------------
       Total |      1,821      100.00

. tab cat if loc3num!=440 

         cat |      Freq.     Percent        Cum.
-------------+-----------------------------------
  1. Invasif |      1,738       95.92       95.92
    3. Bénin |          8        0.44       96.36
4. Incertain |         66        3.64      100.00
-------------+-----------------------------------
       Total |      1,812      100.00



	   */

drop if loc3num==440 | loc3num>=2000
	   
contract sexe adiag, zero
rename _freq nbcas
reshape wide nbcas, i(adiag) j(sexe)
label var nbcas1 "Hommes"
label var nbcas2 "Femmes"
gen total = nbcas1+nbcas2
label var total "Total"
save "1_contract_morta.dta", replace

save "1_tableau_1_nombre_cas_mortalite_par_an.dta", replace


* Préparation du fichier pour le calcul des taux d'Mortalié


use "6_morta_geneve.dta", clear
drop if loc3num==440 | loc3num>=2000
sort clage
merge clage using clage
tab _merge // que des 3 
drop _merge
contract sexe adiag clage, zero
rename _freq nbcas
destring sex, replace
gen indic="Mortalité"
gen indic_num=2
gen loc3="C00-C95"
gen loc3num=1000
replace loc3=trim(loc3)

drop if clage==.
drop if adiag==.
drop if sexe==.
drop if loc3num==.
save  "2_contract_morta_invasifs.dta", replace



use "6_morta_geneve.dta", clear
drop if loc3num>=2000
sort clage
merge clage using clage
tab _merge // que des 3 
drop _merge
contract sexe adiag clage, zero
rename _freq nbcas
destring sex, replace
gen indic="Mortalité"
gen indic_num=2
gen loc3="C00-C95 avec C44"
gen loc3num=1001
replace loc3=trim(loc3)

drop if clage==.
drop if adiag==.
drop if sexe==.
drop if loc3num==.
save  "2_contract_morta_invasifs_avec_peau.dta", replace







* pas de cas insitu
use "6_morta_geneve.dta", clear
keep if loc3num>=2000 & loc3num<=2009
sort clage
merge clage using clage
tab _merge // 2 et 3 
drop _merge

contract sexe adiag clage, zero
rename _freq nbcas
destring sex, replace
gen indic="Mortalité"
gen indic_num=2
gen loc3="D00-D09"
gen loc3num=2099
replace loc3=trim(loc3)

drop if clage==.
drop if adiag==.
drop if sexe==.
drop if loc3num==.
save  "2_contract_morta_insitu.dta", replace


* 8 bénin
use "6_morta_geneve.dta", clear
keep if loc3num>=3010 & loc3num<=3036
sort clage
merge clage using clage
tab _merge // 2 et 3 
drop _merge

contract sexe adiag clage, zero
rename _freq nbcas
destring sex, replace
gen indic="Mortalité"
gen indic_num=2
gen loc3="D10-D36"
gen loc3num=3099
replace loc3=trim(loc3)

drop if clage==.
drop if adiag==.
drop if sexe==.
drop if loc3num==.
save  "2_contract_morta_benin.dta", replace


* 88 incertains
use "6_morta_geneve.dta", clear
keep if loc3num>=4037 & loc3num<=4090
sort clage
merge clage using clage
tab _merge // 2 et 3 
drop _merge
contract sexe adiag clage, zero
rename _freq nbcas
destring sex, replace
gen indic="Mortalité"
gen indic_num=2
gen loc3="D37-D89"
gen loc3num=4099
replace loc3=trim(loc3)

drop if clage==.
drop if adiag==.
drop if sexe==.
drop if loc3num==.
save  "2_contract_morta_incertains.dta", replace



use "2_contract_morta_invasifs.dta", clear
append using  "2_contract_morta_invasifs_avec_peau.dta"
append using  "2_contract_morta_insitu.dta"
append using "2_contract_morta_benin.dta"
append using  "2_contract_morta_incertains.dta"
save "2_contract_morta.dta", replace

tab clage sex // pour checker
tabstat nbcas, stat(sum) by( loc3)
/*
Summary for variables: nbcas
Group variable: loc3 

   loc3 |       Sum
--------+----------
C00-C95 |      1738
D10-D36 |         8
D37-D89 |        88
--------+----------
  Total |      1834
*/




tab clage sexe
/*
tab clage sexe


           |         sexe
     clage |         1          2 |     Total
-----------+----------------------+----------
         0 |         6          6 |        12 
         1 |         6          6 |        12 
         5 |         6          6 |        12 
        10 |         6          6 |        12 
        15 |         6          6 |        12 
        20 |         6          6 |        12 
        25 |         6          6 |        12 
        30 |         6          6 |        12 
        35 |         6          6 |        12 
        40 |         6          6 |        12 
        45 |         6          6 |        12 
        50 |         6          6 |        12 
        55 |         6          6 |        12 
        60 |         6          6 |        12 
        65 |         6          6 |        12 
        70 |         6          6 |        12 
        75 |         6          6 |        12 
        80 |         6          6 |        12 
        85 |         6          6 |        12 
-----------+----------------------+----------
     Total |       114        114 |       228 
* 4 indicateurs invasif in situ bénin incertains mais ici pas d'in situ, sur 2 ans donc 6 lignes


	 */
save  "2_contract_morta.dta", replace

* on fait en 2 étapes
use "6_morta_geneve.dta", clear
replace loc3=trim(loc3)
sort clage
merge clage using clage
drop _merge

contract sexe adiag  loc3num clage , zero 
rename _freq nbcas
destring sex, replace
gen indic="Mortalité"
gen indic_num=2

drop if clage==.
drop if adiag==.
drop if sexe==.
drop if loc3num==.
codebook* // pour vérifier le fait qu'il n'y ait pas de données manquantes

save  "6_contract_1_morta.dta", replace


use "6_morta_geneve.dta", clear
contract loc3 loc3num
drop _freq
sort  loc3num
codebook loc3 // 0 données manquantes
save "correspondance_loc_morta.dta",replace

use "6_contract_1_morta.dta", clear
sort  loc3num
merge  loc3num using  "correspondance_loc_morta.dta"
tab _merge
/*
    _merge |      Freq.     Percent        Cum.
------------+-----------------------------------
          3 |      4,560      100.00      100.00
------------+-----------------------------------
      Total |      4,560      100.00



	  */
	  keep if _merge==3
drop _merge
   tab clage sexe if loc3num==100
/*
       |         sexe
     clage |         1          2 |     Total
-----------+----------------------+----------
         0 |         2          2 |         4 
         1 |         2          2 |         4 
         5 |         2          2 |         4 
        10 |         2          2 |         4 
        15 |         2          2 |         4 
        20 |         2          2 |         4 
        25 |         2          2 |         4 
        30 |         2          2 |         4 
        35 |         2          2 |         4 
        40 |         2          2 |         4 
        45 |         2          2 |         4 
        50 |         2          2 |         4 
        55 |         2          2 |         4 
        60 |         2          2 |         4 
        65 |         2          2 |         4 
        70 |         2          2 |         4 
        75 |         2          2 |         4 
        80 |         2          2 |         4 
        85 |         2          2 |         4 
-----------+----------------------+----------
     Total |        38         38 |        76 



	 */
save  "3_contract_2_morta.dta", replace





use "3_contract_2_morta.dta" , clear
append using  "2_contract_morta.dta"
tab loc3
tab loc3num
compress
save "4_contract_total_mortalite_avec_localisations_detaillees.dta", replace

use "4_contract_total_mortalite_avec_localisations_detaillees.dta", clear // 4603
tabstat nbcas if loc3num==1000, stat(sum) 
tabstat nbcas if loc3num<1000 & loc3num!=440, stat(sum) 
tabstat nbcas if loc3num==1000, stat(sum) 
*tabstat nbcas if loc3num==2099, stat(sum) 
tabstat nbcas if loc3num==3099, stat(sum) 
tabstat nbcas if loc3num==4099, stat(sum) 
/*
 tabstat nbcas if loc3num==1000, stat(sum) 

    Variable |       Sum
-------------+----------
       nbcas |      1738
------------------------

. tabstat nbcas if loc3num<1000 & loc3num!=440, stat(sum) 

    Variable |       Sum
-------------+----------
       nbcas |      1738
------------------------

*/
tab clage sexe if loc3num==100
/*

  clage |         1          2 |     Total
-----------+----------------------+----------
         0 |         5          5 |        10 
         1 |         5          5 |        10 
         5 |         5          5 |        10 
        10 |         5          5 |        10 
        15 |         5          5 |        10 
        20 |         5          5 |        10 
        25 |         5          5 |        10 
        30 |         5          5 |        10 
        35 |         5          5 |        10 
        40 |         5          5 |        10 
        45 |         5          5 |        10 
        50 |         5          5 |        10 
        55 |         5          5 |        10 
        60 |         5          5 |        10 
        65 |         5          5 |        10 
        70 |         5          5 |        10 
        75 |         5          5 |        10 
        80 |         5          5 |        10 
        85 |         5          5 |        10 
-----------+----------------------+----------
     Total |        95         95 |       190 
