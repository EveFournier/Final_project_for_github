


local donnees="C:\INCIDENCE_RGT\DONNEES\"

cd `donnees'


*cd "C:\INCIDENCE_RGT\DONNEES\POUR_ROBIN\"
*cd "C:\INCIDENCE_RGT\DONNEES\20_49_2014_2018\"
*------------------------------------------------------------------------------------------------------------------------------------
* à PERSONNALISER A CHAQUE LANCEMENT : LE NOM DU FICHIER EXCEL
*- 1 PREPARATION DU FICHIER DE DONNEES DU REGISTRE

/*
Faire tourner ce programme sous MySqlQueryBrowser et récupérer le résultats
select
  TID,
  VERSION_ICDO,
  LOC_ICDO,
  MORPH_ICDO,
  COMPORT_ICDO,
  locICDOxTO3(VERSION_ICDO, LOC_ICDO, MORPH_ICDO) As `topo V3`,
  if(COMPORT_ICDO = '', '?', morphICDOxTO3(VERSION_ICDO, LOC_ICDO, MORPH_ICDO, COMPORT_ICDO)) As `morph_icdo V3`,
  if(COMPORT_ICDO = '', '?', malignICDOxTO3(VERSION_ICDO, LOC_ICDO, MORPH_ICDO, COMPORT_ICDO)) As `beh V3`
from
  a_tumor
where
  VERSION_ICDO in (1, 2)
order by
  VERSION_ICDO, TID
;
*/
* Pour les vieilles années, transcodages CIMO1 2 vers CIMO3
* il faut le faire tourner chaque fois car il y a un ou deux cas d'écart...à controler avec les tid récdent 91,779
import delimited "C:\INCIDENCE_RGT\DONNEES\ICDO12_vers_ICDO3.csv", clear 
rename *, lower
keep tid  topov3 morph_icdov3 behv3
rename morph_icdov3 morphov3
replace topov3="" if topov3=="?"
replace morphov3="" if morphov3=="?"
replace behv3="" if behv3=="?"
sort tid
save "CIMO12_vers_CIMO3.dta" ,replace



* Extraction des données registre

clear
odbc load, exec("select PID, BIRTHDATE, SEXE from a_patient") dsn(nicer_64) lower
destring *, replace
sort pid
save a_patient.dta, replace


clear
odbc load, exec("select PID,PAT_STATUS,PAT_STATUS_DATE from a_pat_demo") dsn(nicer_64) 
gen date_point=dofc(PAT_STATUS_DATE)
rename *, lower
sort pid
save "date_point.dta",replace

clear
odbc load, exec("select PID, TID, TUM_STATUS, INCIDENCE_DATE, incidence_year, RESIDENT_STATUS, ICD10,LOC_ICDO,  MORPH_ICDO, COMPORT_ICDO, VERSION_ICDO from a_tumor") dsn(nicer_64) lower
destring *, replace
sort pid
save a_tumor.dta, replace

use a_patient, clear
merge pid using a_tumor
tab _merge
drop _merge
sort tid
save "1_base_registre.dta", replace

use "1_base_registre.dta", clear
sort tid
merge tid using "CIMO12_vers_CIMO3.dta"
tab _merge
replace loc_icdo=subinstr(loc_icdo,".","",(.))
replace loc_icdo=substr(loc_icdo,1,4)
replace loc_icdo=topov3 if _merge==3 & topov3!=""

tab morph_icdo
replace morph_icdo=substr( morph_icdo,1,4)
tab morph_icdo

replace morph_icdo=morphov3 if _merge==3 & morphov3!=""
destring behv3, replace force
replace comport_icdo=behv3 if _merge==3 & behv3!=.
drop _merge
keep if inlist(tum_status,3,10,11) // enfants ou complet récidive
keep if resident_status=="GE"
save "2_base_registre.dta", replace


* EXPORT VERS IARCTOOLS POUR CIM10


use "2_base_registre.dta", clear
keep tid loc_icdo morph_icdo comport_icdo sexe
order tid sexe loc_icdo morph_icdo comport_icdo  
gsort -tid
save "pour_cim10.dta",replace
export delimited using "pour_cim10.csv", delimiter(";") replace

* on fait tourner iarctools, il y a 40 erreurs, surtout des hémato, snc................................
import excel "C:\INCIDENCE_RGT\DONNEES\cim10.xlsx", sheet("cim10") firstrow clear
sort tid
save "cim10.dta", replace



use "2_base_registre.dta", clear
sort tid
merge tid using  "cim10.dta"
replace sexe=1 if tid==43925 // changement de sexe
replace sexe=1 if tid==153671 // changement de sexe
list if tid==175364 // était sans age

*drop if tid==185891 // véto

tab _merge 
gen date_incid=dofc(incidence_date)
gen date_nais=dofc(birthdate)
format %tdDD/NN/CCYY  date_incid date_nais
gen adiag=year(date_incid)
gen age=floor((date_incid-date_nais)/365.25)
drop birthdate incidence_date
move date_incid incidence_year
move date_nais incidence_year
move date_nais incidence_year
move date_nais tid


replace cim10=icd10 if cim10==""
replace cim10=subinstr(cim10,".","",(.))
drop _merge
drop icd10

*keep if adiag>=2020 & adiag<=2021
egen clage=cut(age),at(0,1,5(5)85,150)
*drop if comport_icdo!=3
* pour le rapport d'activité on va garder les invasifs et insitu et bénins

drop topov3 morphov3  behv3

compress
destring *, replace
gen topo2=substr(loc_icdo,1,3)
gen cim10def=substr(cim10,1,3)
tostring morph_icdo, gen(morpho3)
replace morpho3=substr(morpho3,1,3)
destring morpho3, replace
save "2_base_registre_cim101.dta", replace


import delimited "C:\INCIDENCE_RGT\CIM10BAG\CIM10GM2021_CSV_S_FR_versionmétadonnée_codes_20201222.csv", clear 
count if v6!=v7
edit if v6!=v7
tab v1
compress
tab v8 if v1==3
tab v8 if v1==4
tab v8 if v1==5
keep if v1==3
tab v8
codebook v8
count if v9!=v10
keep v8 v9
rename v8 cim10def
rename v9 cim10def_txt
sort cim10def
list in 1/3
/*
 list in 1/3

     +---------------------------------------------+
     | cim10def                       cim10def_txt |
     |---------------------------------------------|
  1. |      A00                            Choléra |
  2. |      A01   Fièvres typhoïde et paratyphoïde |
  3. |      A02     Autres infections à Salmonella |
     +---------------------------------------------+

*/
sort cim10def
save "cim10def_avec_insitu.dta",replace



 use "2_base_registre_cim101.dta", clear
sort cim10def
merge cim10def using  "cim10def_avec_insitu.dta"
keep if _merge==3
drop _merge
 save "2_base_registre_cim10.dta", replace


 use "2_base_registre_cim10.dta", clear

tab cim10def if topo2=="C44" & morph_icdo>=8720 & morph_icdo<=8780 // ok mélanomes C43
edit cim10* loc_icdo morph_icdo topo2 if  (topo2=="C77" |  topo2=="C83") & (morph_icdo==9823 | morph_icdo==9670) 
sort morph_icdo

keep if  substr(cim10def,1,1)=="C" | substr(cim10def,1,1)=="D"

gen cat=1 if substr(cim10def,1,1)=="C"
replace cat=2 if substr(cim10def,1,3)>="D00" &   substr(cim10def,1,3)<"D10"
replace cat=3 if substr(cim10def,1,3)>="D10" &   substr(cim10def,1,3)<"D37"
replace cat=4 if substr(cim10def,1,3)>="D37" 
label def cat 1 "Invasif" 2 "In-Situ" 3 "Bénin" 4 "Incertain"
label val cat cat

numlabel, add
label def comport_icdo 0 "Benin" 1 "Indetermine" 2 "In-situ" 3 "Invasif"
label val comport_icdo comport_icdo
tab cat comport_icdo
numlabel, add
tab cat comport_icdo

save "2_base_registre_cim10.dta", replace

/*
tab cat comport_icdo

             |                COMPORT_ICDO
         cat |  0. Benin  1. Indete  2. In-sit  3. Invasi |     Total
-------------+--------------------------------------------+----------
  1. Invasif |         0          1          0      6,425 |     6,426 
  2. In-Situ |         0          0      1,285          7 |     1,292 
    3. Bénin |       147          4          0          0 |       151 
4. Incertain |         1        144          1         90 |       236 
-------------+--------------------------------------------+----------
       Total |       148        149      1,286      6,522 |     8,105 

*/
edit tid cim10def cim10def_txt  if cat==3 & comport_icdo==1
edit tid cim10def cim10def_txt  if cat==4 & comport_icdo==3 // D45- D47




*-----------------------------------------------------------------------------------------------
* REGROUPEMENT PAR LOCALISATION CIM10 TEL QUE FAIT POUR LA PUBLICATION
 *-----------------------------------------------------------------------------------------------
*-----------------------------------------------------------------------------------------------
*
* TABLEAU FIN DE RAPPORT
*
*-----------------------------------------------------------------------------------------------
* REGROUPEMENT PAR LOCALISATION CIM10 TEL QUE FAIT POUR LA PUBLICATION
 *-----------------------------------------------------------------------------------------------
 use "2_base_registre_cim10.dta", clear
*---------------------------------------------------------------------------------------------------------
* LOC 3 , UN INTERMEDIAIRE ENTRE LOC1 ET LOC2



gen loc3=""	
replace loc3=	"C00-C14"	if cim10def==	"C00"
replace loc3=	"C00-C14"	if cim10def==	"C01"
replace loc3=	"C00-C14"	if cim10def==	"C02"
replace loc3=	"C00-C14"	if cim10def==	"C03"
replace loc3=	"C00-C14"	if cim10def==	"C04"
replace loc3=	"C00-C14"	if cim10def==	"C05"
replace loc3=	"C00-C14"	if cim10def==	"C06"
replace loc3=	"C00-C14"	if cim10def==	"C07"
replace loc3=	"C00-C14"	if cim10def==	"C08"
replace loc3=	"C00-C14"	if cim10def==	"C09"
replace loc3=	"C00-C14"	if cim10def==	"C10"
replace loc3=	"C00-C14"	if cim10def==	"C11"
replace loc3=	"C00-C14"	if cim10def==	"C12"
replace loc3=	"C00-C14"	if cim10def==	"C13"
replace loc3=	"C00-C14"	if cim10def==	"C14"
replace loc3=	"C15"		if cim10def==	"C15"
replace loc3=	"C16"		if cim10def==	"C16"
replace loc3=	"C17"		if cim10def==	"C17"
replace loc3=	"C18-C20"	if cim10def==	"C18"
replace loc3=	"C18-C20"	if cim10def==	"C19"
replace loc3=	"C18-C20"	if cim10def==	"C20"
replace loc3=	"C21"		if cim10def==	"C21"
replace loc3=	"C22"		if cim10def==	"C22"
replace loc3=	"C23,C24"	if cim10def==	"C23"
replace loc3=	"C23,C24"	if cim10def==	"C24"
replace loc3=	"C25"		if cim10def==	"C25"
replace loc3=	"C26,C80"	if cim10def==	"C26"
replace loc3=	"Autres*"	if cim10def==	"C30"
replace loc3=	"Autres*"	if cim10def==	"C31"
replace loc3=	"C32"		if cim10def==	"C32"
replace loc3=	"C33-C34"	if cim10def==	"C33"
replace loc3=	"C33-C34"	if cim10def==	"C34"
replace loc3=	"Autres*"	if cim10def==	"C37"
replace loc3=	"C38,C45"	if cim10def==	"C38"
replace loc3=	"Autres*"	if cim10def==	"C39"
replace loc3=	"C40,C41"	if cim10def==	"C40"
replace loc3=	"C40,C41"	if cim10def==	"C41"
replace loc3=	"C43"		if cim10def==	"C43"
replace loc3=	"C44"		if cim10def==	"C44"
replace loc3=	"C38,C45"	if cim10def==	"C45"
replace loc3=	"Autres*"	if cim10def==	"C46"
replace loc3=	"C47, C49"	if cim10def==	"C47"
replace loc3=	"Autres*"	if cim10def==	"C48"
replace loc3=	"C47, C49"	if cim10def==	"C49"
replace loc3=	"C50"		if cim10def==	"C50"
replace loc3=	"Autres*"	if cim10def==	"C51"
replace loc3=	"Autres*"	if cim10def==	"C52"
replace loc3=	"C53"		if cim10def==	"C53"
replace loc3=	"C54-C55"	if cim10def==	"C54"
replace loc3=	"C54-C55"	if cim10def==	"C55"
replace loc3=	"C56,C57"	if cim10def==	"C56"
replace loc3=	"C56,C57"	if cim10def==	"C57"
replace loc3=	"Autres*"	if cim10def==	"C58"
replace loc3=	"Autres*"	if cim10def==	"C60"
replace loc3=	"C61"		if cim10def==	"C61"
replace loc3=	"C62"		if cim10def==	"C62"
replace loc3=	"Autres*"	if cim10def==	"C63"
replace loc3=	"C64"	if cim10def==	"C64"
replace loc3=	"C65-C66,C68"	if cim10def==	"C65"
replace loc3=	"C65-C66,C68"	if cim10def==	"C66"
replace loc3=	"C67"		if cim10def==	"C67"
replace loc3=	"C65-C66,C68"	if cim10def==	"C68"
replace loc3=	"Autres*"	if cim10def==	"C69"
replace loc3=	"C70-C72"	if cim10def==	"C70"
replace loc3=	"C70-C72"	if cim10def==	"C71"
replace loc3=	"C70-C72"	if cim10def==	"C72"
replace loc3=	"C73"		if cim10def==	"C73"
replace loc3=	"Autres*"	if cim10def==	"C74"
replace loc3=	"Autres*"		if cim10def==	"C75"
replace loc3=	"Autres*"	if cim10def==	"C76"
replace loc3=	"Autres*"	if cim10def==	"C77"
replace loc3=	"C26,C80"	if cim10def==	"C80"
replace loc3=	"C81"		if cim10def==	"C81"
replace loc3=	"C82-85, C96"	if cim10def==	"C82"
replace loc3=	"C82-85, C96"	if cim10def==	"C83"
replace loc3=	"C82-85, C96"	if cim10def==	"C84"
replace loc3=	"C82-85, C96"	if cim10def==	"C85"
replace loc3=	"Autres*"	if cim10def==	"C86"
replace loc3=	"Autres*"	if cim10def==	"C88"
replace loc3=	"C90"		if cim10def==	"C90"
replace loc3=	"C91"		if cim10def==	"C91"
replace loc3=	"C92"		if cim10def==	"C92"
replace loc3=	"C93-95"	if cim10def==	"C93"
replace loc3=	"C93-95"	if cim10def==	"C94"
replace loc3=	"C93-95"	if cim10def==	"C95"
replace loc3=	"C82-85, C96"	if cim10def==	"C96"
replace loc3=	"Autres*"	if cim10def==	"C97"
*replace loc3=	"D45-D47"	if substr(cim10def,1,3)>="D43" & substr(cim10def,1,3)<="D47"
replace loc3= substr(cim10def,1,3) if substr(cim10def,1,1)=="D"
replace loc3=	"Autres*"	if loc3==""

drop if loc3=="D04" // ce sont les peaux in situ



gen loc3num=.			
replace loc3num=	100	if cim10def==	"C00"
replace loc3num=	100	if cim10def==	"C01"
replace loc3num=	100	if cim10def==	"C02"
replace loc3num=	100	if cim10def==	"C03"
replace loc3num=	100	if cim10def==	"C04"
replace loc3num=	100	if cim10def==	"C05"
replace loc3num=	100	if cim10def==	"C06"
replace loc3num=	100	if cim10def==	"C07"
replace loc3num=	100	if cim10def==	"C08"
replace loc3num=	100	if cim10def==	"C09"
replace loc3num=	100	if cim10def==	"C10"
replace loc3num=	100	if cim10def==	"C11"
replace loc3num=	100	if cim10def==	"C12"
replace loc3num=	100	if cim10def==	"C13"
replace loc3num=	100	if cim10def==	"C14"
replace loc3num=	150	if cim10def==	"C15"
replace loc3num=	160	if cim10def==	"C16"
replace loc3num=	170	if cim10def==	"C17"
replace loc3num=	200	if cim10def==	"C18"
replace loc3num=	200	if cim10def==	"C19"
replace loc3num=	200	if cim10def==	"C20"
replace loc3num=	210	if cim10def==	"C21"
replace loc3num=	220	if cim10def==	"C22"
replace loc3num=	230	if cim10def==	"C23"
replace loc3num=	230	if cim10def==	"C24"
replace loc3num=	250	if cim10def==	"C25"
replace loc3num=	999	if cim10def==	"C26"
replace loc3num=	998	if cim10def==	"C30"
replace loc3num=	998	if cim10def==	"C31"
replace loc3num=	320	if cim10def==	"C32"
replace loc3num=	330	if cim10def==	"C33"
replace loc3num=	330	if cim10def==	"C34"
replace loc3num=	998	if cim10def==	"C37"
replace loc3num=	380	if cim10def==	"C38"
replace loc3num=	998	if cim10def==	"C39"
replace loc3num=	400	if cim10def==	"C40"
replace loc3num=	400	if cim10def==	"C41"
replace loc3num=	430	if cim10def==	"C43"
replace loc3num=	440	if cim10def==	"C44" // peau autre ajout du 10.06.2024
replace loc3num=	380	if cim10def==	"C45"
replace loc3num=	998	if cim10def==	"C46"
replace loc3num=	470	if cim10def==	"C47"
replace loc3num=	998	if cim10def==	"C48"
replace loc3num=	470	if cim10def==	"C49"
replace loc3num=	500	if cim10def==	"C50"
replace loc3num=	998	if cim10def==	"C51"
replace loc3num=	998	if cim10def==	"C52"
replace loc3num=	530	if cim10def==	"C53"
replace loc3num=	540	if cim10def==	"C54"
replace loc3num=	540	if cim10def==	"C55"
replace loc3num=	560	if cim10def==	"C56"
replace loc3num=	560	if cim10def==	"C57"
replace loc3num=	998	if cim10def==	"C58"
replace loc3num=	998	if cim10def==	"C60"
replace loc3num=	610	if cim10def==	"C61"
replace loc3num=	620	if cim10def==	"C62"
replace loc3num=	998	if cim10def==	"C63"
replace loc3num=	640	if cim10def==	"C64"
replace loc3num=	650	if cim10def==	"C65"
replace loc3num=	650	if cim10def==	"C66"
replace loc3num=	670	if cim10def==	"C67"
replace loc3num=	650	if cim10def==	"C68"
replace loc3num=	998	if cim10def==	"C69"
replace loc3num=	700	if cim10def==	"C70"
replace loc3num=	700	if cim10def==	"C71"
replace loc3num=	700	if cim10def==	"C72"
replace loc3num=	730	if cim10def==	"C73"
replace loc3num=	998	if cim10def==	"C74"
replace loc3num=	998	if cim10def==	"C75" // à RAJOUTER CHEZ YVAN
replace loc3num=	998	if cim10def==	"C76"
replace loc3num=	998	if cim10def==	"C77"
replace loc3num=	999	if cim10def==	"C80"
replace loc3num=	810	if cim10def==	"C81"
replace loc3num=	820	if cim10def==	"C82"
replace loc3num=	820	if cim10def==	"C83"
replace loc3num=	820	if cim10def==	"C84"
replace loc3num=	820	if cim10def==	"C85"
replace loc3num=	998	if cim10def==	"C86"
replace loc3num=	998	if cim10def==	"C88"
replace loc3num=	880	if cim10def==	"C90"
replace loc3num=	910	if cim10def==	"C91"
replace loc3num=	920	if cim10def==	"C92"
replace loc3num=	930	if cim10def==	"C93"
replace loc3num=	930	if cim10def==	"C94"
replace loc3num=	930	if cim10def==	"C95"
replace loc3num=	820	if cim10def==	"C96"
replace loc3num=	998	if cim10def==	"C97"
replace loc3num=	998	if loc3=="Autres*"
*replace loc3num=	940	if substr(cim10def,1,1)=="D"
* Ajout du 10.06.2024
replace loc3num=	2000	if cim10def==	"D00"
replace loc3num=	2001	if cim10def==	"D01"
replace loc3num=	2002	if cim10def==	"D02"
replace loc3num=	2003	if cim10def==	"D03"
replace loc3num=	2004	if cim10def==	"D04"
replace loc3num=	2005	if cim10def==	"D05"
replace loc3num=	2006	if cim10def==	"D06"
replace loc3num=	2007	if cim10def==	"D07"
replace loc3num=	2009	if cim10def==	"D09"
replace loc3num=	3010	if cim10def==	"D10"
replace loc3num=	3011	if cim10def==	"D11"
replace loc3num=	3012	if cim10def==	"D12"
replace loc3num=	3013	if cim10def==	"D13"
replace loc3num=	3014	if cim10def==	"D14"
replace loc3num=	3015	if cim10def==	"D15"
replace loc3num=	3016	if cim10def==	"D16"
replace loc3num=	3017	if cim10def==	"D17"
replace loc3num=	3018	if cim10def==	"D18"
replace loc3num=	3019	if cim10def==	"D19"
replace loc3num=	3020	if cim10def==	"D20"
replace loc3num=	3021	if cim10def==	"D21"
replace loc3num=	3022	if cim10def==	"D22"
replace loc3num=	3023	if cim10def==	"D23"
replace loc3num=	3024	if cim10def==	"D24"
replace loc3num=	3025	if cim10def==	"D25"
replace loc3num=	3026	if cim10def==	"D26"
replace loc3num=	3027	if cim10def==	"D27"
replace loc3num=	3028	if cim10def==	"D28"
replace loc3num=	3029	if cim10def==	"D29"
replace loc3num=	3030	if cim10def==	"D30"
replace loc3num=	3031	if cim10def==	"D31"
replace loc3num=	3032	if cim10def==	"D32"
replace loc3num=	3033	if cim10def==	"D33"
replace loc3num=	3034	if cim10def==	"D34"
replace loc3num=	3035	if cim10def==	"D35"
replace loc3num=	3036	if cim10def==	"D36"
replace loc3num=	4037	if cim10def==	"D37"
replace loc3num=	4038	if cim10def==	"D38"
replace loc3num=	4039	if cim10def==	"D39"
replace loc3num=	4040	if cim10def==	"D40"
replace loc3num=	4041	if cim10def==	"D41"
replace loc3num=	4042	if cim10def==	"D42"
replace loc3num=	4043	if cim10def==	"D43"
replace loc3num=	4044	if cim10def==	"D44"
replace loc3num=	4045	if cim10def==	"D45"
replace loc3num=	4046	if cim10def==	"D46"
replace loc3num=	4047	if cim10def==	"D47"
replace loc3num=	4048	if cim10def==	"D48"
replace loc3num=	4050	if cim10def==	"D50"
replace loc3num=	4051	if cim10def==	"D51"
replace loc3num=	4052	if cim10def==	"D52"
replace loc3num=	4053	if cim10def==	"D53"
replace loc3num=	4055	if cim10def==	"D55"
replace loc3num=	4056	if cim10def==	"D56"
replace loc3num=	4057	if cim10def==	"D57"
replace loc3num=	4058	if cim10def==	"D58"
replace loc3num=	4059	if cim10def==	"D59"
replace loc3num=	4060	if cim10def==	"D60"
replace loc3num=	4061	if cim10def==	"D61"
replace loc3num=	4062	if cim10def==	"D62"
replace loc3num=	4063	if cim10def==	"D63"
replace loc3num=	4064	if cim10def==	"D64"
replace loc3num=	4065	if cim10def==	"D65"
replace loc3num=	4066	if cim10def==	"D66"
replace loc3num=	4067	if cim10def==	"D67"
replace loc3num=	4068	if cim10def==	"D68"
replace loc3num=	4069	if cim10def==	"D69"
replace loc3num=	4070	if cim10def==	"D70"
replace loc3num=	4071	if cim10def==	"D71"
replace loc3num=	4072	if cim10def==	"D72"
replace loc3num=	4073	if cim10def==	"D73"
replace loc3num=	4074	if cim10def==	"D74"
replace loc3num=	4075	if cim10def==	"D75"
replace loc3num=	4076	if cim10def==	"D76"
replace loc3num=	4077	if cim10def==	"D77"
replace loc3num=	4080	if cim10def==	"D80"
replace loc3num=	4081	if cim10def==	"D81"
replace loc3num=	4082	if cim10def==	"D82"
replace loc3num=	4083	if cim10def==	"D83"
replace loc3num=	4084	if cim10def==	"D84"
replace loc3num=	4086	if cim10def==	"D86"
replace loc3num=	4089	if cim10def==	"D89"
replace loc3num=	4090	if cim10def==	"D90"




label def loc3num ///		
100	"Lèvre, Bouche, Pharynx"	 ///
150	"Œsophage"	 ///
160	"Estomac"	 ///
170	"Intestin grêle"	 ///
200	"Côlon et rectum"	 ///
210	"Anus et canal anal"	 ///
220	"Foie"	 ///
230	"Vésicule et voies biliaires extra-hépatiques"	 ///
250	"Pancréas"	 ///
320	"Larynx"	 ///
330	"Poumon et bronches"	 ///
380	"Plèvre et mésothéliome"	 ///
400	"Os"	 ///
430	"Mélanome de la peau"	 ///
440 "Peau autre" ///
470	"Tissus mous"	 ///
500	"Sein"	 ///
530	"Col de l'utérus"	 ///
540	"Corps de l'utérus"	 ///
560	"Ovaires et annexes"	 ///
610	"Prostate"	 ///
620	"Testicule"	 ///
640	"Rein"	 ///
650 "Voie urinaires" ///
670	"Vessie"	 ///
700	"Système nerveux central"	 ///
730	"Thyroïde"	 ///
810	"Maladie de Hodgkin"	 ///
820	"Lymphome non H"	 ///
880	"Myélome multiple"	 ///
910	"Leucémie lymphoïde"	 ///
920	"Leucémie myéloïde"	 ///
930	"Leucémie SAI"	 ///
998	"Autres*"	 ///
999	"Site primitif inconnu" ///
1000 "Total invasifs sans peau non mélanomique" ///
1001 "Total invasifs avec peau non mélanomique" ///
2000	"Carcinome in situ de la cavité buccale, de l'œsophage et de l'estomac"	 ///
2001	"Carcinome in situ des organes digestifs, autres et non précisés"	 ///
2002	"Carcinome in situ de l'oreille moyenne et de l'appareil respiratoire"	 ///
2003	"Mélanome in situ"	 ///
2004	"Carcinome in situ de la peau"	 ///
2005	"Carcinome in situ du sein"	 ///
2006	"Carcinome in situ du col de l'utérus"	 ///
2007	"Carcinome in situ d'organes génitaux, autres et non précisés"	 ///
2009	"Carcinome in situ de sièges autres et non précisés"	 ///
3010	"Tumeur bénigne de la bouche et du pharynx"	 ///
3011	"Tumeur bénigne des glandes salivaires principales"	 ///
3012	"Tumeur bénigne du côlon, du rectum, de l'anus et du canal anal"	 ///
3013	"Tumeurs bénignes de parties autres et mal définies de l'appareil digestif"	 ///
3014	"Tumeur bénigne de l'oreille moyenne et de l'appareil respiratoire"	 ///
3015	"Tumeur bénigne des organes intrathoraciques, autres et non précisés"	 ///
3016	"Tumeur bénigne des os et du cartilage articulaire"	 ///
3017	"Tumeur lipomateuse bénigne"	 ///
3018	"Hémangiome et lymphangiome"	 ///
3019	"Tumeur bénigne du tissu mésothélial"	 ///
3020	"Tumeur bénigne des tissus mous du rétropéritoine et du péritoine"	 ///
3021	"Autres tumeurs bénignes du tissu conjonctif et des autres tissus mous"	 ///
3022	"Nævus à mélanocytes"	 ///
3023	"Autres tumeurs bénignes de la peau"	 ///
3024	"Tumeur bénigne du sein"	 ///
3025	"Léiomyome de l'utérus"	 ///
3026	"Autres tumeurs bénignes de l'utérus"	 ///
3027	"Tumeur bénigne de l'ovaire"	 ///
3028	"Tumeur bénigne des organes génitaux de la femme, autres et non précisés"	 ///
3029	"Tumeur bénigne des organes génitaux de l'homme"	 ///
3030	"Tumeur bénigne des organes urinaires"	 ///
3031	"Tumeur bénigne de l'œil et de ses annexes"	 ///
3032	"Tumeur bénigne des méninges"	 ///
3033	"Tumeur bénigne de l'encéphale et d'autres parties du système nerveux central"	 ///
3034	"Tumeur bénigne de la thyroïde"	 ///
3035	"Tumeur bénigne des glandes endocrines, autres et non précisées"	 ///
3036	"Tumeur bénigne de sièges autres et non précisés"	 ///
4037	"Tumeur de la cavité buccale et des organes digestifs à évolution imprévisible ou inconnue"	 ///
4038	"Tumeur de l'oreille moyenne et des organes respiratoires et intrathoraciques à évolution imprévisible ou inconnue"	 ///
4039	"Tumeur des organes génitaux de la femme à évolution imprévisible ou inconnue"	 ///
4040	"Tumeur des organes génitaux de l'homme à évolution imprévisible ou inconnue"	 ///
4041	"Tumeur des organes urinaires à évolution imprévisible ou inconnue"	 ///
4042	"Tumeur des méninges à évolution imprévisible ou inconnue"	 ///
4043	"Tumeur de l'encéphale et du système nerveux central à évolution imprévisible ou inconnue"	 ///
4044	"Tumeur des glandes endocrines à évolution imprévisible ou inconnue"	 ///
4045	"Polyglobulie essentielle"	 ///
4046	"Syndromes myélodysplasiques"	 ///
4047	"Autres tumeurs des tissus lymphoïde, hématopoïétique et apparentés à évolution imprévisible ou inconnue"	 ///
4048	"Tumeur de sièges autres et non précisés à évolution imprévisible ou inconnue"	 ///
4050	"Anémie par carence en fer"	 ///
4051	"Anémie par carence en vitamine B12"	 ///
4052	"Anémie par carence en acide folique"	 ///
4053	"Autres anémies nutritionnelles"	 ///
4055	"Anémie due à des anomalies enzymatiques"	 ///
4056	"Thalassémie"	 ///
4057	"Affections à hématies falciformes [drépanocytaires]"	 ///
4058	"Autres anémies hémolytiques héréditaires"	 ///
4059	"Anémie hémolytique acquise"	 ///
4060	"Aplasie médullaire [anémie aplastique] acquise pure [érythroblastopénie]"	 ///
4061	"Autres anémies aplastiques"	 ///
4062	"Anémie posthémorragique aiguë"	 ///
4063	"Anémie au cours de maladies chroniques classées ailleurs"	 ///
4064	"Autres anémies"	 ///
4065	"Coagulation intravasculaire disséminée [syndrome de défibrination]"	 ///
4066	"Carence héréditaire en facteur VIII"	 ///
4067	"Carence héréditaire en facteur IX"	 ///
4068	"Autres anomalies de la coagulation"	 ///
4069	"Purpura et autres affections hémorragiques"	 ///
4070	"Agranulocytose et neutropénie"	 ///
4071	"Anomalies fonctionnelles des granulocytes neutrophiles"	 ///
4072	"Autres anomalies des leucocytes"	 ///
4073	"Maladies de la rate"	 ///
4074	"Méthémoglobinémie"	 ///
4075	"Autres maladies du sang et des organes hématopoïétiques"	 ///
4076	"Autres maladies précisées avec participation des tissus lymphoréticulaires et du système réticulohistiocytaire"	 ///
4077	"Autres maladies du sang et des organes hématopoïétiques au cours de maladies classées ailleurs"	 ///
4080	"Déficit immunitaire avec déficit prédominant de la production d'anticorps"	 ///
4081	"Déficits immunitaires combinés"	 ///
4082	"Déficit immunitaire associé à d'autres anomalies majeures"	 ///
4083	"Déficit immunitaire commun variable"	 ///
4084	"Autres déficits immunitaires"	 ///
4086	"Sarcoïdose"	 ///
4089	"Autres anomalies du système immunitaire, non classées ailleurs"	 ///
4090	"Immunocompromission après radiothérapie, chimiothérapie et autres mesures immunosuppressives"	///
2099 "Total in-situ"	 ///
3099 "Total bénins"	 ///
4099 "Total incertains", modify

label def loc3bnum ///		
100	"C00-C14 - Lèvre, Bouche, Pharynx"	 ///
150	"C15 - Œsophage"	 ///
160	"C16 - Estomac"	 ///
170	"C17 - Intestin grêle"	 ///
200	"C18-C20 - Côlon et rectum"	 ///
210	"C21 - Anus et canal anal"	 ///
220	"C22 - Foie"	 ///
230	"C23,C24 - Vésicule et voies biliaires extra-hépatiques"	 ///
250	"C25 - Pancréas"	 ///
320	"C32 - Larynx"	 ///
330	"C33,C34 - Poumon et bronches"	 ///
380	"C38,C45 - Plèvre et mésothéliome"	 ///
400	"C41 - Os"	 ///
430	"C43 - Mélanome de la peau"	 ///
440 "C44 - Peau autre" /// ajout du 13.06
470	"C47,C49 - Tissus mous"	 ///
500	"C50 - Sein"	 ///
530	"C53 - Col de l'utérus"	 ///
540	"C54,C55 - Corps de l'utérus"	 ///
560	"C56,C57 - Ovaires et annexes"	 ///
610	"C61 - Prostate"	 ///
620	"C62 - Testicule"	 ///
640	"C64 - Rein"	 ///
650	"C65-C66,C68 - Voies urinaires"	 ///
670	"C67 - Vessie"	 ///
700	"C70 - Système nerveux central"	 ///
730	"C73 - Thyroïde"	 ///
810	"C81 - Maladie de Hodgkin"	 ///
820	"C82-85, C96 - Lymphome non H"	 ///
880	"C90 - Myélome multiple"	 ///
910	"C91 - Leucémie lymphoïde"	 ///
920	"C92 - Leucémie myéloïde"	 ///
930	"C93-C95 - Leucémie SAI"	 ///
998	"Autres*"	 ///
999	"C26,C80 - Site primitif inconnu" ///
1000 "C00-C95 - Total invasifs sans peau non mélanomique" ///
1001 "C00-C95 - Total invasifs avec peau non mélanomique" ///
2000	"D00 - Carcinome in situ de la cavité buccale, de l'œsophage et de l'estomac"	 ///
2001	"D01 - Carcinome in situ des organes digestifs, autres et non précisés"	 ///
2002	"D02 - Carcinome in situ de l'oreille moyenne et de l'appareil respiratoire"	 ///
2003	"D03 - Mélanome in situ"	 ///
2004	"D04 - Carcinome in situ de la peau"	 ///
2005	"D05 - Carcinome in situ du sein"	 ///
2006	"D06 - Carcinome in situ du col de l'utérus"	 ///
2007	"D07 - Carcinome in situ d'organes génitaux, autres et non précisés"	 ///
2009	"D09 - Carcinome in situ de sièges autres et non précisés"	 ///
3010	"D10 - Tumeur bénigne de la bouche et du pharynx"	 ///
3011	"D11 - Tumeur bénigne des glandes salivaires principales"	 ///
3012	"D12 - Tumeur bénigne du côlon, du rectum, de l'anus et du canal anal"	 ///
3013	"D13 - Tumeurs bénignes de parties autres et mal définies de l'appareil digestif"	 ///
3014	"D14 - Tumeur bénigne de l'oreille moyenne et de l'appareil respiratoire"	 ///
3015	"D15 - Tumeur bénigne des organes intrathoraciques, autres et non précisés"	 ///
3016	"D16 - Tumeur bénigne des os et du cartilage articulaire"	 ///
3017	"D17 - Tumeur lipomateuse bénigne"	 ///
3018	"D18 - Hémangiome et lymphangiome"	 ///
3019	"D19 - Tumeur bénigne du tissu mésothélial"	 ///
3020	"D20 - Tumeur bénigne des tissus mous du rétropéritoine et du péritoine"	 ///
3021	"D21 - Autres tumeurs bénignes du tissu conjonctif et des autres tissus mous"	 ///
3022	"D22 - Nævus à mélanocytes"	 ///
3023	"D23 - Autres tumeurs bénignes de la peau"	 ///
3024	"D24 - Tumeur bénigne du sein"	 ///
3025	"D25 - Léiomyome de l'utérus"	 ///
3026	"D26 - Autres tumeurs bénignes de l'utérus"	 ///
3027	"D27 - Tumeur bénigne de l'ovaire"	 ///
3028	"D28 - Tumeur bénigne des organes génitaux de la femme, autres et non précisés"	 ///
3029	"D29 - Tumeur bénigne des organes génitaux de l'homme"	 ///
3030	"D30 - Tumeur bénigne des organes urinaires"	 ///
3031	"D31 - Tumeur bénigne de l'œil et de ses annexes"	 ///
3032	"D32 - Tumeur bénigne des méninges"	 ///
3033	"D33 - Tumeur bénigne de l'encéphale et d'autres parties du système nerveux central"	 ///
3034	"D34 - Tumeur bénigne de la thyroïde"	 ///
3035	"D35 - Tumeur bénigne des glandes endocrines, autres et non précisées"	 ///
3036	"D36 - Tumeur bénigne de sièges autres et non précisés"	 ///
4037	"D37 - Tumeur de la cavité buccale et des organes digestifs à évolution imprévisible ou inconnue"	 ///
4038	"D38 - Tumeur de l'oreille moyenne et des organes respiratoires et intrathoraciques à évolution imprévisible ou inconnue"	 ///
4039	"D39 - Tumeur des organes génitaux de la femme à évolution imprévisible ou inconnue"	 ///
4040	"D40 - Tumeur des organes génitaux de l'homme à évolution imprévisible ou inconnue"	 ///
4041	"D41 - Tumeur des organes urinaires à évolution imprévisible ou inconnue"	 ///
4042	"D42 - Tumeur des méninges à évolution imprévisible ou inconnue"	 ///
4043	"D43 - Tumeur de l'encéphale et du système nerveux central à évolution imprévisible ou inconnue"	 ///
4044	"D44 - Tumeur des glandes endocrines à évolution imprévisible ou inconnue"	 ///
4045	"D45 - Polyglobulie essentielle"	 ///
4046	"D46 - Syndromes myélodysplasiques"	 ///
4047	"D47 - Autres tumeurs des tissus lymphoïde, hématopoïétique et apparentés à évolution imprévisible ou inconnue"	 ///
4048	"D48 - Tumeur de sièges autres et non précisés à évolution imprévisible ou inconnue"	 ///
4050	"D50 - Anémie par carence en fer"	 ///
4051	"D51 - Anémie par carence en vitamine B12"	 ///
4052	"D52 - Anémie par carence en acide folique"	 ///
4053	"D53 - Autres anémies nutritionnelles"	 ///
4055	"D55 - Anémie due à des anomalies enzymatiques"	 ///
4056	"D56 - Thalassémie"	 ///
4057	"D57 - Affections à hématies falciformes [drépanocytaires]"	 ///
4058	"D58 - Autres anémies hémolytiques héréditaires"	 ///
4059	"D59 - Anémie hémolytique acquise"	 ///
4060	"D60 - Aplasie médullaire [anémie aplastique] acquise pure [érythroblastopénie]"	 ///
4061	"D61 - Autres anémies aplastiques"	 ///
4062	"D62 - Anémie posthémorragique aiguë"	 ///
4063	"D63 - Anémie au cours de maladies chroniques classées ailleurs"	 ///
4064	"D64 - Autres anémies"	 ///
4065	"D65 - Coagulation intravasculaire disséminée [syndrome de défibrination]"	 ///
4066	"D66 - Carence héréditaire en facteur VIII"	 ///
4067	"D67 - Carence héréditaire en facteur IX"	 ///
4068	"D68 - Autres anomalies de la coagulation"	 ///
4069	"D69 - Purpura et autres affections hémorragiques"	 ///
4070	"D70 - Agranulocytose et neutropénie"	 ///
4071	"D71 - Anomalies fonctionnelles des granulocytes neutrophiles"	 ///
4072	"D72 - Autres anomalies des leucocytes"	 ///
4073	"D73 - Maladies de la rate"	 ///
4074	"D74 - Méthémoglobinémie"	 ///
4075	"D75 - Autres maladies du sang et des organes hématopoïétiques"	 ///
4076	"D76 - Autres maladies précisées avec participation des tissus lymphoréticulaires et du système réticulohistiocytaire"	 ///
4077	"D77 - Autres maladies du sang et des organes hématopoïétiques au cours de maladies classées ailleurs"	 ///
4080	"D80 - Déficit immunitaire avec déficit prédominant de la production d'anticorps"	 ///
4081	"D81 - Déficits immunitaires combinés"	 ///
4082	"D82 - Déficit immunitaire associé à d'autres anomalies majeures"	 ///
4083	"D83 - Déficit immunitaire commun variable"	 ///
4084	"D84 - Autres déficits immunitaires"	 ///
4086	"D86 - Sarcoïdose"	 ///
4089	"D89 - Autres anomalies du système immunitaire, non classées ailleurs"	 ///
4090	"D90 - Immunocompromission après radiothérapie, chimiothérapie et autres mesures immunosuppressives"	///
2099 "D00-D09 - Total in-situ"	 ///
3099 "D10-D36 - Total bénins"	 ///
4099 "D37-D49 - Total incertains", modify


label val loc3num loc3bnum



*--------------------------------------------------------------------------------------------------------------------
*
* 
*
*--------------------------------------------------------------------------------------------------------------------

compress
tab cim10def if loc3=="" // C44
tab adiag

*drop if cim10def=="C44"
*drop if substr(cim10def,1,1)=="D"
tab adiag

drop if cim10def>="D50" // ce ne sont pas des incertains
save "3_base_registre_1970_plus.dta", replace
keep if adiag>=2020 & adiag<=2021
tab adiag
save "3_base_registre_def.dta", replace

use "3_base_registre_def.dta", clear
tab cim10def if cim10def>="D12" & cim10def<"D32"
drop if cim10def>="D12" & cim10def<"D32"

save "3_base_registre_def.dta", replace

/*
tab adiag

   adiag |      Freq.     Percent        Cum.
------------+-----------------------------------
       2016 |      2,593       19.78       19.78
       2017 |      2,654       20.24       40.02
       2018 |      2,644       20.17       60.19
       2019 |      2,673       20.39       80.58
       2020 |      2,546       19.42      100.00
------------+-----------------------------------
      Total |     13,110      100.00

      adiag |      Freq.     Percent        Cum.
------------+-----------------------------------
       2020 |      3,956       48.81       48.81
       2021 |      4,149       51.19      100.00
------------+-----------------------------------
      Total |      8,105      100.00

*/

* à faire pour récupérer les classes d'âge par sexe
use "C:\INCIDENCE_RGT\DONNEES\2_base_registre_cim10.dta", clear
contract clage
tab clage
drop _freq
drop if clage==.
sort clage
save "clage.dta",replace
