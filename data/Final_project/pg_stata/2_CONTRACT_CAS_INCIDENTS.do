

*-----------------------------------------------------------------------------------
*
*                                        DEBUT PROGRAMME
*
*-----------------------------------------------------------------------------------


* Répertoire 0û vont se trouve les fichiers intermédiaires





local donnees="C:\INCIDENCE_RGT\DONNEES\"

cd `donnees'

use "3_base_registre_def.dta", clear
*drop if cim10def=="C44"
label var loc3 "Localisation primitive CIM10"
label var adiag "Année incidence"
save  "3_base_registre_def.dta", replace




*-----------------------------------------------------------------------------------
*
*    CONCEPTION DU TABLEAU 1
*
*-----------------------------------------------------------------------------------



* OBTENTION D'UN FICHIER DE DONNEES AGREGEES : nbre de cas par année, sexe, classe age
* et par localisation nlicdo3
* on n'a que les invasifs ici
use "3_base_registre_def.dta", clear
/*
tab cat i

         cat |      Freq.     Percent        Cum.
-------------+-----------------------------------
  1. Invasif |      5,367       76.18       76.18
  2. In-Situ |      1,291       18.33       94.51
    3. Bénin |        151        2.14       96.65
4. Incertain |        236        3.35      100.00
-------------+-----------------------------------
       Total |      7,045      100.00

	tab cat if loc3num!=440    
        cat |      Freq.     Percent        Cum.
-------------+-----------------------------------
  1. Invasif |      6,427       79.30       79.30
  2. In-Situ |      1,291       15.93       95.23
    3. Bénin |        151        1.86       97.09
4. Incertain |        236        2.91      100.00
-------------+-----------------------------------
       Total |      8,105      100.00

*/


drop if loc3num==440 | loc3num>=2000
/*
tab cat

         cat |      Freq.     Percent        Cum.
-------------+-----------------------------------
  1. Invasif |      5,367      100.00      100.00
-------------+-----------------------------------
       Total |      5,367      100.00
*/
contract sexe adiag, zero
rename _freq nbcas
reshape wide nbcas, i(adiag) j(sexe)
label var nbcas1 "Hommes"
label var nbcas2 "Femmes"
gen total = nbcas1+nbcas2
label var total "Total"
save "1_contract.dta", replace
save "1_tableau_1_nombre_cas_indident_par_an.dta", replace


* Préparation du fichier pour le calcul des taux d'incidence


use "3_base_registre_def.dta", clear
drop if loc3num==440 | loc3num>=2000
sort clage
merge clage using clage
tab _merge // que des 3 
drop _merge
contract sexe adiag clage, zero
rename _freq nbcas
destring sex, replace
gen indic="Incidence"
gen indic_num=1
gen loc3="C00-C95"
gen loc3num=1000
replace loc3=trim(loc3)
drop if sex==.
save  "2_contract_invasifs.dta", replace


use "3_base_registre_def.dta", clear
drop if loc3num>=2000
sort clage
merge clage using clage
tab _merge // que des 3 
drop _merge
contract sexe adiag clage, zero
rename _freq nbcas
destring sex, replace
gen indic="Incidence"
gen indic_num=1
gen loc3="C00-C95 avec C44"
gen loc3num=1001
replace loc3=trim(loc3)
codebook sex clage
drop if sex==.
drop if adiag==.
drop if sexe==.
save  "2_contract_invasifs_avec_peau.dta", replace



use "3_base_registre_def.dta", clear
keep if loc3num>=2000 & loc3num<=2009
sort clage
merge clage using clage
tab _merge // 2 et 3 
drop _merge

contract sexe adiag clage, zero
rename _freq nbcas
destring sex, replace
gen indic="Incidence"
gen indic_num=1
gen loc3="D00-D09"
gen loc3num=2099
replace loc3=trim(loc3)
drop if adiag==.
drop if sexe==.
drop if clage==.
save  "2_contract_insitu.dta", replace



use "3_base_registre_def.dta", clear
keep if loc3num>=3010 & loc3num<=3036
sort clage
merge clage using clage
tab _merge // 2 et 3 
drop _merge

contract sexe adiag clage, zero
rename _freq nbcas
destring sex, replace
gen indic="Incidence"
gen indic_num=1
gen loc3="D10-D36"
gen loc3num=3099
replace loc3=trim(loc3)
drop if adiag==.
drop if sexe==.
drop if clage==.
save  "2_contract_benin.dta", replace



use "3_base_registre_def.dta", clear
keep if loc3num>=4037 & loc3num<=4090
sort clage
merge clage using clage
tab _merge // 2 et 3 
drop _merge
contract sexe adiag clage, zero
rename _freq nbcas
destring sex, replace
gen indic="Incidence"
gen indic_num=1
gen loc3="D37-D89"
gen loc3num=4099
replace loc3=trim(loc3)
drop if adiag==.
drop if sexe==.
drop if clage==.
save  "2_contract_incertains.dta", replace



use "2_contract_invasifs.dta", clear
append using  "2_contract_invasifs_avec_peau.dta"
append using  "2_contract_insitu.dta"
append using "2_contract_benin.dta"
append using  "2_contract_incertains.dta"
save "2_contract.dta", replace

tab clage sex // pour checker

 tabstat nbcas, stat(sum) by( loc3)
/*
Summary for variables: nbcas
Group variable: loc3 

   loc3 |       Sum
--------+----------
C00-C95 |      5367
D00-D09 |      1291
D10-D36 |       151
D37-D89 |       236
--------+----------
  Total |      7045

*/

* on fait en 2 étapes
use "3_base_registre_def.dta", clear
contract sexe adiag  loc3num clage , zero // cela fait plein de lignes supplémentaires, normale car on a mis option zero. on règle cela à l'étape suivante
rename _freq nbcas
destring sex, replace
gen indic="Incidence"
gen indic_num=1

codebook   loc3num // pour vérifier le fait qu'il n'y ait pas de données manquantes
sort  loc3num 
save  "3_contract_1.dta", replace

use "3_base_registre_def.dta", clear
contract loc3 loc3num 
drop _freq
sort  loc3num 
codebook loc3 loc3num  // 0 données manquantes
save "correspondance_loc_incid.dta",replace

use  "3_contract_1.dta", clear
sort  loc3num
merge loc3num  using "correspondance_loc_incid.dta"
tab _merge
drop _merge

* On vérifie
tab loc3 if loc3num==100
tab loc3num if loc3=="C00-C14"
/*
tab loc3num if loc3=="C00-C14"


                                loc3num |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
       C00-C14 - Lèvre, Bouche, Pharynx |         76      100.00      100.00
----------------------------------------+-----------------------------------
                                  Total |         76      100.00
								  */
save "3_contract_2.dta", replace


use "3_contract_2.dta" , clear
append using  "2_contract.dta"
tab loc3num

tabstat nbcas if loc3num==1000, stat(sum)
tabstat nbcas if  loc3num<1000 & loc3num!=440, stat(sum)
/*

tabstat nbcas if loc3num==1000, stat(sum)

    Variable |       Sum
-------------+----------
       nbcas |      5367
------------------------

. tabstat nbcas if  loc3num<1000 & loc3num!=440, stat(sum)

    Variable |       Sum
-------------+----------
       nbcas |      5367
------------------------





*/

capture tabstat nbcas if clage==., stat(sum) // a permis d'identifier un pb sur le calcul de l'âge pour deux tumeurs => retour au dossier pour retrouver les dates de naissances
save "4_contract_total_incident_avec_localisations_detaillees.dta", replace

use "4_contract_total_incident_avec_localisations_detaillees.dta", clear

tab clage sexe if loc3num==100,m
/*
     |         SEXE
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



2 ans de suivis
	 */
* on s'ccupe de la mortalité maintenant

