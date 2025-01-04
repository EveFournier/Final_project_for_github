

* OBJECTIF DU PROGRAMME : UTILISER LES OUTILS STATA POUR EXPORTER CORRECTEMENT LES RESULTATS
*-----------------------------------------------------------------------------------
*
*          DEBUT PROGRAMME
*
*-----------------------------------------------------------------------------------


* Répertoire 0û vont se trouve les fichiers intermédiaires

local donnees="C:\INCIDENCE_RGT\DONNEES\"

cd `donnees'
* PREPARATION DES DONNEES QUI VONT ETRE NECESSAIRES AU FICHIER 10

*--------------------------------------------

*--------------------------------------------------------------------------------------------------
* AJOUT DES TI PAR LOCALISATION POUR TOUTE LA PERIODE
*--------------------------------------------------------------------------------------------------
**# Bookmark #4

 use "TI_TM_Geneve_Final.dta", clear

label var loc3num "Localisation CIM10"
label var nbcas1 "Nombre total de cas sur la période (hommes)"
label var moy_an1 "Nombre moyen annuel de cas sur la période (hommes)"
label var taux_brut1 "Taux brut"
label var taux_std1 "Taux standardisé"
label var icmin1 "IC95% min"
label var icmax1 "IC95% max"
label var nbcas2 "Nombre total de cas sur la période (femmes)"
label var moy_an2 "Nombre moyen annuel de cas sur la période (femmes)"
label var taux_brut2 "Taux brut"
label var taux_std2 "Taux standardisé"
label var ic951 "IC95% hommes"
label var ic952 "IC95% femmes"
label var indic "Indicateur"

*format %8.1f taux_brut* taux_std* icmin* icmax*
 sort adiag  indic loc3num
 order adiag  indic cat loc3num
save "3_Tableau_global_TI_TM_par_localisation_periodes_incid_morta.dta", replace


 *-------------------------------------------------------------------------------------------------------------------------------------------------------
 *************************************************************** CAS PAR TRANCHES D'AGE ET PAR LOCALISATION
 *-------------------------------------------------------------------------------------------------------------------------------------------------------
 
 
 * on va rajouter les classes d'âge par localisation, pour chaque type de comportement
 
 
 
  use "5_nbcas_incident_et_morta.dta", clear
  replace clage=0 if clage==1
  collapse (sum) nbcas , by(sexe clage loc3num indic indic_num loc3 cat adiag)
  tabstat nbcas if indic_num==1, stat(sum) by(loc3num)
  tostring adiag, replace
  save "6_nbcas_incident_et_morta_new_clage.dta", replace
  
  use "5_nbcas_incident_et_morta.dta", clear
  replace clage=0 if clage==1
  collapse (sum) nbcas , by(sexe clage loc3num indic indic_num loc3 cat)
  tabstat nbcas if indic_num==1, stat(sum) by(loc3num)
  gen adiag="Période"
  save "6_nbcas_incident_et_morta_new_clage_periode.dta", replace
  
  use "6_nbcas_incident_et_morta_new_clage.dta", clear
  append using  "6_nbcas_incident_et_morta_new_clage_periode.dta"
  save "7_nbcas_incident_et_morta_new_clage.dta", replace
  
  
reshape wide nbcas,i(sexe loc3num cat adiag indic_num) j(clage)
egen Total=rowtotal( nbcas0- nbcas85)
gen nbcasmoy=round(Total/2) if adiag=="Période"
replace nbcasmoy=Total if nbcasmoy==.
for var  nbcas0- nbcas85 : replace X=0 if X==.

tostring *, replace
destring sex, replace
label var	nbcas0	"<5"
label var	nbcas5	"5-9"
label var	nbcas10	"10-14"
label var	nbcas15	"15-19"
label var	nbcas20	"20-24"
label var	nbcas25	"25-29"
label var	nbcas30	"30-34"
label var	nbcas35	"35-39"
label var	nbcas40	"40-44"
label var	nbcas45	"45-49"
label var	nbcas50	"50-54"
label var	nbcas55	"55-59"
label var	nbcas60	"60-64"
label var	nbcas65	"65-69"
label var	nbcas70	"70-74"
label var	nbcas75	"75-79"
label var	nbcas80	"80-84"
label var	nbcas85	"85+"
order sex indic* adiag cat loc3*
for var nbcas0- nbcasmoy: replace X="-" if sexe ==1 & inlist(loc3num,530,540,560,2006,4039)
for var nbcas0- nbcasmoy: replace X="-" if sexe ==2 & inlist(loc3num,610,620)

label var nbcasmoy "Nombre cas moyen/an"
label var loc3num "Localisation CIM10"
sort sex indic_num adiag loc3num
save "8_Tableau_nbcas_clage_periode.dta", replace



