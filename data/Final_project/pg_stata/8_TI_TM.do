* LANCEMENT DES STATISTIQUES
* REALISATION DU DOCUMENT 1
* DONNEES D'INCIDENCE TOUTES LOCALISATIONS CONFONDUES



 cd "C:\INCIDENCE_RGT\DONNEES\"



*-----------------------------------------------------------------------------------
*
*    PREPARATION DES POPULATIONS DE REFERENCES
*
*-----------------------------------------------------------------------------------
use "C:\INCIDENCE_RGT\POP\refmonde.dta", clear
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
drop indic
reshape wide nbcas,i(adiag sexe clage loc3 loc3num cat) j(indic_num)
rename nbcas1 incid
rename nbcas2 morta
label var incid "Incidence"
label var morta "Mortalité"
replace incid=0 if incid==.
replace morta=0 if morta==.

save "7_nbcas_incident_et_morta_pop.dta", replace

tabstat incid morta pop if loc3num==1000 , stat(sum) 
/*
tabstat incid morta pop if loc3num==1000 , stat(sum) 

   Stats |     incid     morta       pop
---------+------------------------------
     Sum |      5368      1738   1013131

----------------------------------------

*/
	
*-----------------------------------------------------------------------------------------------------------------------------------
*---------------------------------2-  PAR LOCALISATION loc3, toutes années confondues

use   "7_nbcas_incident_et_morta_pop.dta", clear
save "8_Incidence_morta_loc3num_par_annees.dta", replace
 
collapse (sum) incid (sum) morta  (sum) pop, by(clage sexe loc3 loc3num cat)

list clage incid morta pop loc3 loc3num if loc3num==1000 & sexe==2
tabstat incid morta pop  if loc3num==1000 , stat(sum) 
/*

  Stats |     incid     morta       pop
---------+------------------------------
     Sum |     13110      4603   2483921


	 */
replace incid=round(incid)
replace morta=round(morta)
replace pop=round(pop)

save "9_Incidence_morta_loc3num_toutes_annees_confondues.dta", replace
 
 
 
	 
 *--------------------------------------------------------------------------------------------------------
*----------------------------------------------------------------------------------------------------------------------------------------------------------------	

*------------------------------------------------------ 4 LANCEMENT DU CALCUL DES TAUX STANDARDISES

*----------------------------------------------------------------------------------------------------------------------------------------------------------------
*----------------------------------------------------------------------------------------------------------------------------------------------------------------	


* FICHIER 1 : PAR ANNEE - il y a deja toutes les localisations dans loc3 
use  "8_Incidence_morta_loc3num_par_annees.dta", clear
sort loc3num
distrate incid pop using "C:\INCIDENCE_RGT\POP\refeurope.dta", standstrata(clage)   by(sexe loc3 loc3num cat adiag)   ///
saving(C:\Temp\11_taux_incidence_par_annee.dta,replace) format(%8.2f) mult(100000) level(95)
sort loc3num
distrate morta pop using "C:\INCIDENCE_RGT\POP\refeurope.dta", standstrata(clage)   by(sexe loc3 loc3num cat adiag)  ///
saving(C:\Temp\12_taux_morta_par_annee.dta,replace) format(%8.2f) mult(100000) level(95)



* FICHIER 2 : POUR TOUTE LA PERIODE 2015-2019 - il y a deja toutes les localisations dans loc3
use "9_Incidence_morta_loc3num_toutes_annees_confondues.dta", clear
sort loc3num
distrate incid pop using "C:\INCIDENCE_RGT\POP\refeurope.dta", standstrata(clage)   by(sexe loc3 loc3num cat )   ///
saving(C:\Temp\21_taux_incidence_par_periode.dta,replace) format(%8.2f) mult(100000) level(95)
sort loc3num
distrate morta pop using "C:\INCIDENCE_RGT\POP\refeurope.dta", standstrata(clage)   by(sexe loc3 loc3num cat )  ///
saving(C:\Temp\22_taux_morta_par_periode.dta,replace) format(%8.2f) mult(100000) level(95)



* REGROUPEMENT DES FICHIERS AVEC LES TI TM

use C:\Temp\11_taux_incidence_par_annee.dta, clear
gen fichier=1
append using C:\Temp\12_taux_morta_par_annee.dta
replace fichier=2 if fichier==.
append using C:\Temp\21_taux_incidence_par_periode.dta
replace fichier=3 if fichier==.
append using C:\Temp\22_taux_morta_par_periode.dta
replace fichier=4 if fichier==.
save "TI_TM_Geneve.dta", replace



use "TI_TM_Geneve.dta", clear
order sexe incid morta  loc3 loc3num 
rename N pop_risk
rename crude taux_brut
rename rateadj taux_std
rename lb_gam icmin
rename ub_gam icmax

gen nbcas=incid
replace nbcas=morta if nbcas==.

order sexe nbcas
label var nbcas "Nombre de cas"
label var pop_risk "Population à risque"
label var taux_brut "Taux brut"
label var taux_std "Taux Standardisé"
label var icmin  "IC 95% min"
label var icmax  "IC 95% max"

drop se_gam- ub_srr

gen indic="Incidence" if incid!=.
replace indic="Mortalité" if incid==.

order cat sexe indic adiag nbcas
drop incid morta

tostring adiag, replace
replace adiag="[2020-2021]" if adiag=="."


bysort sexe nbcas indic  loc3 adiag : gen nb=_n // plus de pb maintenant mais on garde au cas où
bysort sexe nbcas indic  loc3 adiag : gen nb2=_N // plus de pb maintenant mais on garde au cas où
tab nb 
drop nb nb2

sort adiag sexe indic cat loc3num

 format %8.1f taux_brut
 format %8.1f taux_std  
 format %8.1f icmin
 format %8.1f icmax
*drop pop_risk
 
tostring taux_brut taux_std icmin icmax, replace force usedisplay
gen ic95="["+icmin+"-"+icmax+"]"

drop fichier 
sort adiag sexe indic cat loc3num
for var taux_brut taux_std icmin icmax ic95 : replace X="-" if nbcas==0


replace nbcas=. if sexe==1 & inlist(loc3num,530,540,560,2006,4039)
for var taux_brut taux_std icmin icmax ic95 : replace X="" if  sexe==1 & inlist(loc3num,530,540,560,2006,4039)

replace nbcas=. if sexe==2 &  inlist(loc3num,610,620)
for var taux_brut taux_std icmin icmax ic95 : replace X="" if sexe==2 &  inlist(loc3num,610,620)




reshape wide nbcas pop_risk taux_brut taux_std icmin icmax ic95,i(indic adiag loc3 loc3num cat) j(sexe)

gen str5 vide="    "
 move vide nbcas2
 gen moy_an1=round(nbcas1/2)
gen moy_an2=round(nbcas2/2)
move moy_an1 taux_brut1
move moy_an2 taux_brut2
replace moy_an1=nbcas1 if length(adiag)==4
replace moy_an2=nbcas2 if length(adiag)==4
save "TI_TM_Geneve_Final.dta", replace

use "TI_TM_Geneve_Final.dta", clear


sort adiag indic cat loc3num
