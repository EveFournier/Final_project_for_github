



* Répertoire 0û vont se trouve les fichiers intermédiaires
 cd "C:\INCIDENCE_RGT\DONNEES\"


 use "3_base_registre_1970_plus.dta", clear
 
 keep if adiag>=1971 & adiag<=2021 
 egen periode=cut(adiag), at(1971(3)2025)
 tab periode
  contract periode sexe loc3num clage, zero
 rename _freq nbcas
  save "4_base_registre_1971_plus_periode.dta", replace
  
  
  
  * Pour la mortalite
  * il faudra récupérer les années 1980-1995 ... 
* Fichiers de Massimo
import delimited "C:\INCIDENCE_RGT\POP\Mortality_data_1970_2020.csv", clear
rename year adiag
save "Mortality_data_1970_2020_massimo.dta", replace
keep if adiag>=1971 & adiag<=1995
egen clage=cut(age),at(0,1,5(5)85,150)
rename icd10 cim10def
replace cim10def=substr(cim10def,1,3)
rename gender sexe
drop id
save "Mortality_data_1971_1995_massimo.dta", replace



use "C:\INCIDENCE_RGT\POP\morta_geneve_1995_2021.dta",replace
save "14_morta_geneve_1995_2021.dta", replace
/*
d

Contains data from C:\INCIDENCE_RGT\POP\morta_geneve_1995_2021.dta
 Observations:        23,178                  
    Variables:             8                  2 May 2024 17:09
-------------------------------------------------------------------------------------------------------------
Variable      Storage   Display    Value
    name         type    format    label      Variable label
-------------------------------------------------------------------------------------------------------------
cim10def        str3    %9s                   
adiag           int     %9.0g                 
date_nais       int     %9.0g                 
date_dc         int     %9.0g                 
age             int     %9.0g                 
clage           byte    %9.0g                 
sexe            float   %9.0g                 
periode         float   %9.0g       
    

*/

use "14_morta_geneve_1995_2021.dta", clear
append using  "Mortality_data_1971_1995_massimo.dta"
tab cim10def if fichier=="OFS"
tab cim10def if adiag==1995 & fichier!="OFS"
drop  if adiag==1995 & fichier=="OFS"
*drop date_nais date_dc fichier
save "15_morta_geneve_1971_2021.dta",replace

keep if substr(cim10def,1,1)=="C"  | substr(cim10def,1,1)=="D"
save "15_morta_geneve.dta", replace
*------------------------------------------------------------------------------------------------------------------------------------
*2 VENTILATION DES LOCALISATIONS

use "15_morta_geneve.dta", clear
gen cat=1 if substr(cim10def,1,1)=="C"
replace cat=2 if substr(cim10def,1,3)>="D00" &   substr(cim10def,1,3)<"D10"
replace cat=3 if substr(cim10def,1,3)>="D10" &   substr(cim10def,1,3)<"D37"
replace cat=4 if substr(cim10def,1,3)>="D37" 
label def cat 1 "Invasif" 2 "In-Situ" 3 "Bénin" 4 "Incertain"
label val cat cat

numlabel, add
tab  adiag cat if cim10def!="C44"
/*
tab cat adiag if cim10def!="C44"

             |         adiag
         cat |      2020       2021 |     Total
-------------+----------------------+----------
  1. Invasif |       922        816 |     1,738 
    3. Bénin |         4          4 |         8 
4. Incertain |        37         51 |        88 
-------------+----------------------+----------
       Total |       963        871 |     1,834 
*/
keep if cat==1
save "16_morta_geneve.dta", replace

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
 use "16_morta_geneve.dta", clear
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


codebook loc3* // il ne doit pas y avoir de manquants


*--------------------------------------------------------------------------------------------------------------------
*
* 
*
*--------------------------------------------------------------------------------------------------------------------

compress
tab cim10def if loc3=="" // il ne doit plus y en avoir
tab adiag

*drop if cim10def=="C44"
*drop if substr(cim10def,1,1)=="D"

drop if cim10def>="D50" // ce ne sont pas des incertains
tab adiag
 *di 969+938+955+866
*3728

 *di 938+955+866
*2759

save "16_morta_geneve_1971_2021.dta",replace

use "16_morta_geneve_1971_2021.dta", clear
 *keep if adiag>=1982 & adiag<=2021 
 capture drop periode
 egen periode=cut(adiag), at(1971(3)2025)
 tab periode
 contract periode sexe loc3num clage, zero
 rename _freq nbcas
 tab periode
 gen indic="Mortalité"
 gen indic_num=2
  
  tabstat nbcas, by(periode) stat(sum)
  
 tab sexe
 tab periode

/*
 tab sexe

   
       sexe |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |     11,305       50.00       50.00
          2 |     11,305       50.00      100.00
------------+-----------------------------------
      Total |     22,610      100.00

.  tab periode

    periode |      Freq.     Percent        Cum.
------------+-----------------------------------
       1971 |      1,330        5.88        5.88
       1974 |      1,330        5.88       11.76
       1977 |      1,330        5.88       17.65
       1980 |      1,330        5.88       23.53
       1983 |      1,330        5.88       29.41
       1986 |      1,330        5.88       35.29
       1989 |      1,330        5.88       41.18
       1992 |      1,330        5.88       47.06
       1995 |      1,330        5.88       52.94
       1998 |      1,330        5.88       58.82
       2001 |      1,330        5.88       64.71
       2004 |      1,330        5.88       70.59
       2007 |      1,330        5.88       76.47
       2010 |      1,330        5.88       82.35
       2013 |      1,330        5.88       88.24
       2016 |      1,330        5.88       94.12
       2019 |      1,330        5.88      100.00
------------+-----------------------------------
      Total |     22,610      100.00





*/
 save "16_morta_geneve_1971_2021.dta",replace
 
 use "16_morta_geneve_1971_2021.dta", clear
 append using "4_base_registre_1971_plus_periode.dta"
  replace indic="Incidence" if indic==""
replace indic_num=1 if indic_num==.

gen cat=1 if loc3num<1001
replace cat=2 if loc3num>=2000 & loc3num<3000
replace cat=3 if loc3num>=3000 & loc3num<4000
replace cat=4 if loc3num>=4000 & loc3num<5000

label def cat 1 "Invasif" 2 "In-Situ" 3 "Bénin" 4 "Incertain"
label val cat cat
sort sexe clage periode
save "17_incidence_morta_1971_2021.dta",replace

use "17_incidence_morta_1971_2021.dta", clear
keep if cat==1
drop if loc3num==440
collapse (sum) nbcas, by(indic indic_num sexe clage periode)
gen loc3num=1000
gen cat=1
save "18_total_cas_dc_par_periode.dta", replace


use "17_incidence_morta_1971_2021.dta", clear
keep if cat==1
drop if loc3num==440
append using "18_total_cas_dc_par_periode.dta"
tab loc3num
tab cat
 sort sexe clage periode
save "19_incidence_morta_1971_2021_invasifs.dta", replace


import delimited "C:\INCIDENCE_RGT\POP\pop_GE_1970_2021_Final.csv", clear
save "pop_GE_1970_2021_Final",replace
rename year adiag
rename gender sexe
egen clage=cut(age), at(0,1,5(5)85,150)
keep if adiag>=1971 & adiag<=2021

 egen periode=cut(adiag), at(1971(3)2025)
 collapse (sum) pop, by(periode sexe clage)
 sort sexe clage periode
 save "pop_GE_1971_2021.dta", replace
 


use "19_incidence_morta_1971_2021_invasifs.dta", clear
merge  sexe clage periode using  "pop_GE_1971_2021.dta"
tab _merge
drop _merge
gen periode2=periode+2
tostring periode, gen(periode_str)
tostring periode2, gen(periode2_str)
gen labperopde=periode_str+"-"+periode2_str
labmask periode, values( labperopde)
tab periode

save  "20_incidence_morta_1971_2021_pop.dta", replace

* taux d'incidence
sort loc3num
distrate nbcas pop using "C:\INCIDENCE_RGT\POP\refeurope.dta", standstrata(clage)   by(sexe  loc3num periode indic_num)   ///
saving(C:\Temp\21_taux_incidence_morta_par_periode.dta,replace) format(%8.2f) mult(100000) level(95)

use "C:\Temp\21_taux_incidence_morta_par_periode.dta", clear
save "21_taux_incidence_morta_par_periode.dta", replace



* Lancement des graphiques

use  "21_taux_incidence_morta_par_periode.dta", clear
order sexe indic   loc3num  periode
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

gen indic="Incidence" if indic_num==1
replace indic="Mortalité" if indic_num==2
save "22_taux_incidence_morta_par_periode.dta", replace

* tous cancers
twoway (line taux_std periode if sex==1 & indic_num==1, sort lcolor(dknavy) lwidth(medthin)) ///
(line taux_std periode if sexe==2 & indic_num==1 , sort lcolor(cranberry) lwidth(medthin)) ///
(line taux_std periode if sex==1 & indic_num==2 , sort lcolor(dknavy) lwidth(medthin) lpattern(dash)) ///
(line taux_std periode if sex==2 & indic_num==2 , sort lcolor(cranberry) lwidth(medthin) lpattern(dash)) ///
if loc3num==1000, ytitle("Taux standardisés pour 100 000 personnes/an") ytitle(, size(small)) ylabel(0(100)500, format(%9.0f) grid)  ///
xtitle("Période de diagnostic") ///
xlabel(1971(3)2019, labels labsize(small) angle(forty_five) valuelabel nogrid) ///
title("Tous cancers (hors peau non mélanique)")  ///
legend(order(1 "Incidence  homme"  2 "Incidence femme"  3 "Mortalité homme" 4 "Mortalité femme") nostack rows(4) size(medsmall) position(3))
 graph export "Gr50_Evolution_toutes_localisations.emf", replace
 
 
 
 
 * Lèvres-bouches-p C00 C14 100
 twoway (line taux_std periode if sex==1 & indic_num==1 , sort lcolor(dknavy) lwidth(medthin)) ///
(line taux_std periode if sexe==2 & indic_num==1 , sort lcolor(cranberry) lwidth(medthin)) ///
(line taux_std periode if sex==1 & indic_num==2, sort lcolor(dknavy) lwidth(medthin) lpattern(dash)) ///
(line taux_std periode if sex==2 & indic_num==2 , sort lcolor(cranberry) lwidth(medthin) lpattern(dash)) ///
if loc3num==100, ytitle("Taux standardisés pour 100 000 personnes/an") ///
ytitle(, size(small)) ///
ylabel(0(10)50, format(%9.0f) grid)  ///
xtitle("Période de diagnostic") ///
xlabel(1971(3)2019, labels labsize(small) angle(forty_five) valuelabel nogrid) ///
title("C00-C14 Lèvres-bouche-pharynx")  ///
legend(order(1 "Incidence  homme"  2 "Incidence femme"  3 "Mortalité homme" 4 "Mortalité femme") nostack rows(4) size(medsmall) position(3))
 graph export "Gr51_Evolution_LBP.emf", replace
 
 
 
 * Estomac 160
 
 twoway (line taux_std periode if sex==1 & indic_num==1 , sort lcolor(dknavy) lwidth(medthin)) ///
(line taux_std periode if sexe==2 & indic_num==1 , sort lcolor(cranberry) lwidth(medthin)) ///
(line taux_std periode if sex==1 & indic_num==2, sort lcolor(dknavy) lwidth(medthin) lpattern(dash)) ///
(line taux_std periode if sex==2 & indic_num==2 , sort lcolor(cranberry) lwidth(medthin) lpattern(dash)) ///
if loc3num==160, ytitle("Taux standardisés pour 100 000 personnes/an") ///
ytitle(, size(small)) ///
ylabel(0(10)50, format(%9.0f) grid)  ///
xtitle("Période de diagnostic") ///
xlabel(1971(3)2019, labels labsize(small) angle(forty_five) valuelabel nogrid) ///
title("C16 Estomac")  ///
legend(order(1 "Incidence  homme"  2 "Incidence femme"  3 "Mortalité homme" 4 "Mortalité femme") nostack rows(4) size(medsmall) position(3))
 graph export "Gr52_Evolution_Estomac.emf", replace
 
 
  * Colon-rectum C18 200
  
 twoway (line taux_std periode if sex==1 & indic_num==1 , sort lcolor(dknavy) lwidth(medthin)) ///
(line taux_std periode if sexe==2 & indic_num==1 , sort lcolor(cranberry) lwidth(medthin)) ///
(line taux_std periode if sex==1 & indic_num==2, sort lcolor(dknavy) lwidth(medthin) lpattern(dash)) ///
(line taux_std periode if sex==2 & indic_num==2 , sort lcolor(cranberry) lwidth(medthin) lpattern(dash)) ///
if loc3num==200, ytitle("Taux standardisés pour 100 000 personnes/an") ///
ytitle(, size(small)) ///
ylabel(0(10)80, format(%9.0f) grid)  ///
xtitle("Période de diagnostic") ///
xlabel(1971(3)2019, labels labsize(small) angle(forty_five) valuelabel nogrid) ///
title("C18-C20 Colon-rectum")  ///
legend(order(1 "Incidence  homme"  2 "Incidence femme"  3 "Mortalité homme" 4 "Mortalité femme") nostack rows(4) size(medsmall) position(3))
 graph export "Gr53_Evolution_CRC.emf", replace
 
 * Foie 220
 
 twoway (line taux_std periode if sex==1 & indic_num==1 , sort lcolor(dknavy) lwidth(medthin)) ///
(line taux_std periode if sexe==2 & indic_num==1 , sort lcolor(cranberry) lwidth(medthin)) ///
(line taux_std periode if sex==1 & indic_num==2, sort lcolor(dknavy) lwidth(medthin) lpattern(dash)) ///
(line taux_std periode if sex==2 & indic_num==2 , sort lcolor(cranberry) lwidth(medthin) lpattern(dash)) ///
if loc3num==220, ytitle("Taux standardisés pour 100 000 personnes/an") ///
ytitle(, size(small)) ///
ylabel(0(5)30, format(%9.0f) grid)  ///
xtitle("Période de diagnostic") ///
xlabel(1971(3)2019, labels labsize(small) angle(forty_five) valuelabel nogrid) ///
title("C22 Foie")  ///
legend(order(1 "Incidence  homme"  2 "Incidence femme"  3 "Mortalité homme" 4 "Mortalité femme") nostack rows(4) size(medsmall) position(3))
 graph export "Gr54_Evolution_Foie.emf", replace
 
 * Pancréas 250
  
 twoway (line taux_std periode if sex==1 & indic_num==1 , sort lcolor(dknavy) lwidth(medthin)) ///
(line taux_std periode if sexe==2 & indic_num==1 , sort lcolor(cranberry) lwidth(medthin)) ///
(line taux_std periode if sex==1 & indic_num==2, sort lcolor(dknavy) lwidth(medthin) lpattern(dash)) ///
(line taux_std periode if sex==2 & indic_num==2 , sort lcolor(cranberry) lwidth(medthin) lpattern(dash)) ///
if loc3num==250, ytitle("Taux standardisés pour 100 000 personnes/an") ///
ytitle(, size(small)) ///
ylabel(0(5)30, format(%9.0f) grid)  ///
xtitle("Période de diagnostic") ///
xlabel(1971(3)2019, labels labsize(small) angle(forty_five) valuelabel nogrid) ///
title("C25 Pancréas")  ///
legend(order(1 "Incidence  homme"  2 "Incidence femme"  3 "Mortalité homme" 4 "Mortalité femme") nostack rows(4) size(medsmall) position(3))
 graph export "Gr55_Evolution_Pancreas.emf", replace
 
 
 
 
 
  * Poumons 330
  
  
 twoway (line taux_std periode if sex==1 & indic_num==1 , sort lcolor(dknavy) lwidth(medthin)) ///
(line taux_std periode if sexe==2 & indic_num==1 , sort lcolor(cranberry) lwidth(medthin)) ///
(line taux_std periode if sex==1 & indic_num==2, sort lcolor(dknavy) lwidth(medthin) lpattern(dash)) ///
(line taux_std periode if sex==2 & indic_num==2 , sort lcolor(cranberry) lwidth(medthin) lpattern(dash)) ///
if loc3num==330, ytitle("Taux standardisés pour 100 000 personnes/an") ///
ytitle(, size(small)) ///
ylabel(0(10)100, format(%9.0f) grid)  ///
xtitle("Période de diagnostic") ///
xlabel(1971(3)2019, labels labsize(small) angle(forty_five) valuelabel nogrid) ///
title("C33-C34 Poumon")  ///
legend(order(1 "Incidence  homme"  2 "Incidence femme"  3 "Mortalité homme" 4 "Mortalité femme") nostack rows(4) size(medsmall) position(3))
 graph export "Gr56_Evolution_Poumon.emf", replace
 
 
 
   * Mélanome C43 430

 
 twoway (line taux_std periode if sex==1 & indic_num==1 , sort lcolor(dknavy) lwidth(medthin)) ///
(line taux_std periode if sexe==2 & indic_num==1 , sort lcolor(cranberry) lwidth(medthin)) ///
(line taux_std periode if sex==1 & indic_num==2, sort lcolor(dknavy) lwidth(medthin) lpattern(dash)) ///
(line taux_std periode if sex==2 & indic_num==2 , sort lcolor(cranberry) lwidth(medthin) lpattern(dash)) ///
if loc3num==430, ytitle("Taux standardisés pour 100 000 personnes/an") ///
ytitle(, size(small)) ///
ylabel(0(10)50, format(%9.0f) grid)  ///
xtitle("Période de diagnostic") ///
xlabel(1971(3)2019, labels labsize(small) angle(forty_five) valuelabel nogrid) ///
title("C43 Mélanome")  ///
legend(order(1 "Incidence  homme"  2 "Incidence femme"  3 "Mortalité homme" 4 "Mortalité femme") nostack rows(4) size(medsmall) position(3))
 graph export "Gr57_Evolution_Melanome.emf", replace
 

 * Sein C50 500
 
 
 
 twoway (line taux_std periode if sex==1 & indic_num==1 , sort lcolor(dknavy) lwidth(medthin)) ///
(line taux_std periode if sexe==2 & indic_num==1 , sort lcolor(cranberry) lwidth(medthin)) ///
(line taux_std periode if sex==1 & indic_num==2, sort lcolor(dknavy) lwidth(medthin) lpattern(dash)) ///
(line taux_std periode if sex==2 & indic_num==2 , sort lcolor(cranberry) lwidth(medthin) lpattern(dash)) ///
if loc3num==500, ytitle("Taux standardisés pour 100 000 personnes/an") ///
ytitle(, size(small)) ///
ylabel(0(20)160, format(%9.0f) grid)  ///
xtitle("Période de diagnostic") ///
xlabel(1971(3)2019, labels labsize(small) angle(forty_five) valuelabel nogrid) ///
title("C50 Sein")  ///
legend(order(1 "Incidence  homme"  2 "Incidence femme"  3 "Mortalité homme" 4 "Mortalité femme") nostack rows(4) size(medsmall) position(3))
 graph export "Gr58_Evolution_Sein.emf", replace
 
 
 
  * Corps de l'utérus 540 sans les hommes
  
 twoway (line taux_std periode if sexe==2 & indic_num==1 , sort lcolor(cranberry) lwidth(medthin)) ///
(line taux_std periode if sex==2 & indic_num==2 , sort lcolor(cranberry) lwidth(medthin) lpattern(dash)) ///
if loc3num==540, ytitle("Taux standardisés pour 100 000 personnes/an") ///
ytitle(, size(small)) ///
ylabel(0(10)40, format(%9.0f) grid)  ///
xtitle("Période de diagnostic") ///
xlabel(1971(3)2019, labels labsize(small) angle(forty_five) valuelabel nogrid) ///
title("C54 Corps de l'utérus")  ///
legend(order(1 "Incidence femme"  2 "Mortalité femme") nostack rows(4) size(medsmall) position(3))
 graph export "Gr59_Evolution_Corps_uterus.emf", replace
 
 
 
  
 * Prostate C61 610
   
 twoway (line taux_std periode if sexe==1 & indic_num==1 , sort lcolor(dknavy) lwidth(medthin)) ///
(line taux_std periode if sex==1 & indic_num==2 , sort lcolor(dknavy) lwidth(medthin) lpattern(dash)) ///
if loc3num==610, ytitle("Taux standardisés pour 100 000 personnes/an") ///
ytitle(, size(small)) ///
ylabel(0(20)160, format(%9.0f) grid)  ///
xtitle("Période de diagnostic") ///
xlabel(1971(3)2019, labels labsize(small) angle(forty_five) valuelabel nogrid) ///
title("C61 Prostate")  ///
legend(order(1 "Incidence homme"  2 "Mortalité homme") nostack rows(4) size(medsmall) position(3))
 graph export "Gr60_Evolution_Prostate.emf", replace
 
 
 
 * Rein 640

 
 twoway (line taux_std periode if sex==1 & indic_num==1 , sort lcolor(dknavy) lwidth(medthin)) ///
(line taux_std periode if sexe==2 & indic_num==1 , sort lcolor(cranberry) lwidth(medthin)) ///
(line taux_std periode if sex==1 & indic_num==2, sort lcolor(dknavy) lwidth(medthin) lpattern(dash)) ///
(line taux_std periode if sex==2 & indic_num==2 , sort lcolor(cranberry) lwidth(medthin) lpattern(dash)) ///
if loc3num==640, ytitle("Taux standardisés pour 100 000 personnes/an") ///
ytitle(, size(small)) ///
ylabel(0(5)25, format(%9.0f) grid)  ///
xtitle("Période de diagnostic") ///
xlabel(1971(3)2019, labels labsize(small) angle(forty_five) valuelabel nogrid) ///
title("C64 Rein")  ///
legend(order(1 "Incidence  homme"  2 "Incidence femme"  3 "Mortalité homme" 4 "Mortalité femme") nostack rows(4) size(medsmall) position(3))
 graph export "Gr61_Evolution_Rein.emf", replace
 
 
 
 
 * Vessie 670

 
 twoway (line taux_std periode if sex==1 & indic_num==1 , sort lcolor(dknavy) lwidth(medthin)) ///
(line taux_std periode if sexe==2 & indic_num==1 , sort lcolor(cranberry) lwidth(medthin)) ///
(line taux_std periode if sex==1 & indic_num==2, sort lcolor(dknavy) lwidth(medthin) lpattern(dash)) ///
(line taux_std periode if sex==2 & indic_num==2 , sort lcolor(cranberry) lwidth(medthin) lpattern(dash)) ///
if loc3num==670, ytitle("Taux standardisés pour 100 000 personnes/an") ///
ytitle(, size(small)) ///
ylabel(0(10)50, format(%9.0f) grid)  ///
xtitle("Période de diagnostic") ///
xlabel(1971(3)2019, labels labsize(small) angle(forty_five) valuelabel nogrid) ///
title("C67 Vessie")  ///
legend(order(1 "Incidence  homme"  2 "Incidence femme"  3 "Mortalité homme" 4 "Mortalité femme") nostack rows(4) size(medsmall) position(3))
 graph export "Gr62_Evolution_Vessie.emf", replace
 
 
 * Thyroïde 730
  
 twoway (line taux_std periode if sex==1 & indic_num==1 , sort lcolor(dknavy) lwidth(medthin)) ///
(line taux_std periode if sexe==2 & indic_num==1 , sort lcolor(cranberry) lwidth(medthin)) ///
(line taux_std periode if sex==1 & indic_num==2, sort lcolor(dknavy) lwidth(medthin) lpattern(dash)) ///
(line taux_std periode if sex==2 & indic_num==2 , sort lcolor(cranberry) lwidth(medthin) lpattern(dash)) ///
if loc3num==730, ytitle("Taux standardisés pour 100 000 personnes/an") ///
ytitle(, size(small)) ///
ylabel(0(5)30, format(%9.0f) grid)  ///
xtitle("Période de diagnostic") ///
xlabel(1971(3)2019, labels labsize(small) angle(forty_five) valuelabel nogrid) ///
title("C73 Thyroide")  ///
legend(order(1 "Incidence  homme"  2 "Incidence femme"  3 "Mortalité homme" 4 "Mortalité femme") nostack rows(4) size(medsmall) position(3))
 graph export "Gr63_Evolution_Thyroide.emf", replace
 
 
 
 
 
 * LMNH 820
 

  
 twoway (line taux_std periode if sex==1 & indic_num==1 , sort lcolor(dknavy) lwidth(medthin)) ///
(line taux_std periode if sexe==2 & indic_num==1 , sort lcolor(cranberry) lwidth(medthin)) ///
(line taux_std periode if sex==1 & indic_num==2, sort lcolor(dknavy) lwidth(medthin) lpattern(dash)) ///
(line taux_std periode if sex==2 & indic_num==2 , sort lcolor(cranberry) lwidth(medthin) lpattern(dash)) ///
if loc3num==820, ytitle("Taux standardisés pour 100 000 personnes/an") ///
ytitle(, size(small)) ///
ylabel(0(5)30, format(%9.0f) grid)  ///
xtitle("Période de diagnostic") ///
xlabel(1971(3)2019, labels labsize(small) angle(forty_five) valuelabel nogrid) ///
title("C82 Lymphome malin non Hodgkinien")  ///
legend(order(1 "Incidence  homme"  2 "Incidence femme"  3 "Mortalité homme" 4 "Mortalité femme") nostack rows(4) size(medsmall) position(3))
 graph export "Gr64_Evolution_LMNH.emf", replace
 
 
 
 
 
 * On fait les Putdocx
 
 
 
 
 
  








*/