* LANCEMENT DES STATISTIQUES
* REALISATION DU DOCUMENT 1
* DONNEES D'INCIDENCE TOUTES LOCALISATIONS CONFONDUES



local donnees="C:\INCIDENCE_RGT\DONNEES\"

cd `donnees'



*-----------------------------------------------------------------------------------
*
*    PREPARATION DES POPULATIONS DE REFERENCES
*
*-----------------------------------------------------------------------------------
use "C:\INCIDENCE_RGT\\POP\refmonde.dta", clear
sort clage
save "C:\INCIDENCE_RGT\POP\refmonde.dta", replace

use "C:\INCIDENCE_RGT\POP\refeurope.dta", clear
sort clage
save "C:\INCIDENCE_RGT\POP\refeurope.dta", replace

*-----------------------------------------------------------------------------------
*
*    PREPARATION DES FICHIERS POUR CALCUL
*
*-----------------------------------------------------------------------------------

use "6_nbcas_incident_et_morta_pop.dta", clear
label var adiag "Années"
label var sexe "Sexe"
label def sexe 1 "Hommes" 2 "Femmes"
label val sexe sexe
drop if clage<20
drop if clage>=50
save "80_taux_spe_20_49.dta",replace

collapse (sum) nbcas (sum) pop, by(indic indic_num clage sexe loc3 loc3num)
save "81_taux_spe_20_49.dta",replace


 *--------------------------------------------------------------------------------------------------------
*----------------------------------------------------------------------------------------------------------------------------------------------------------------	

*------------------------------------------------------ 4 LANCEMENT DU CALCUL DES TAUX STANDARDISES

*----------------------------------------------------------------------------------------------------------------------------------------------------------------
*----------------------------------------------------------------------------------------------------------------------------------------------------------------	
use "C:\INCIDENCE_RGT\POP\refeurope.dta" , clear
 tabstat pop, stat(sum)
/*
    Variable |       Sum
-------------+----------
         pop |    100000
*/
		 
drop if clage<20
drop if clage>=50
/*tabstat pop, stat(sum)

    Variable |       Sum
-------------+----------
         pop |     42000
------------------------

*/
replace pop=7000*100000/42000
tabstat pop,stat(sum)
/*
   Variable |       Sum
-------------+----------
         pop |    100000

		 */
		 sort clage
save "C:\INCIDENCE_RGT\POP\refeurope_20_49.dta", replace




* FICHIER 1 : POUR TOUTE LA PERIODE 2014-2018 - il y a deja toutes les localisations dans loc3
use  "81_taux_spe_20_49.dta", clear

distrate nbcas pop using "C:\INCIDENCE_RGT\POP\refeurope_20_49.dta", standstrata(clage)   by(indic sexe loc3 loc3num)   ///
saving(C:\Temp\81_taux_spe_20_49_ans.dta,replace) format(%8.2f) mult(100000) level(95)



* REGROUPEMENT DES FICHIERS AVEC LES TI TM

use C:\Temp\81_taux_spe_20_49_ans.dta, clear
save "TI_TM_Geneve_20_49_ans_2014_2018.dta", replace



use "TI_TM_Geneve_20_49_ans_2014_2018.dta", clear
order sexe indic   loc3 loc3num 
rename N pop_risk
rename crude taux_brut
rename rateadj taux_std
rename lb_gam icmin
rename ub_gam icmax


label var nbcas "Nombre de cas"
label var pop_risk "Population à risque"
label var taux_brut "Taux brut"
label var taux_std "Taux Standardisé"
label var icmin  "IC 95% min"
label var icmax  "IC 95% max"

drop se_gam- ub_srr

replace loc3="Total" if loc3=="C00-C95"
replace loc3="Total" if loc3==""
replace loc3num=1000 if loc3num==.


bysort sexe nbcas indic  loc3  : gen nb=_n // plus de pb maintenant mais on garde au cas où
bysort sexe nbcas indic  loc3 : gen nb2=_N // plus de pb maintenant mais on garde au cas où
tab nb
edit if nb2>1
keep if nb==1
drop nb nb2
 format %8.1f taux_brut
 format %8.1f taux_std  
 format %8.1f icmin
 format %8.1f icmax
drop pop_risk
 
save "TI_TM_Geneve_20_49_ans_2014_2018_final.dta", replace

use "TI_TM_Geneve_20_49_ans_2014_2018_final.dta", clear


tostring taux_brut taux_std icmin icmax, replace force usedisplay
gen ic95="["+icmin+"-"+icmax+"]"
reshape wide nbcas taux_brut taux_std icmin icmax ic95,i(indic  loc3 loc3num) j(sexe)
gen str5 vide="    "
 move vide nbcas2
 gen moy_an1=round(nbcas1/5)
gen moy_an2=round(nbcas2/5)
move moy_an1 taux_brut1
move moy_an2 taux_brut2
save "TI_TM_Geneve_20_49_ans_2014_2018_final.dta", replace

use "TI_TM_Geneve_20_49_ans_2014_2018_final.dta", clear
tabstat nbcas1, stat(sum)
tabstat nbcas1 nbcas2, stat(sum)
di 248+1100
drop icmin1 icmax1 icmin2 icmax2
drop vide

sort indic   loc3num
sort indic sexe  loc3num

