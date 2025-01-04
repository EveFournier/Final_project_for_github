


local donnees="C:\INCIDENCE_RGT\DONNEES\"

cd `donnees'

use "3_base_registre_def.dta", clear
egen clage2=cut(age),at(0,20,50,75,150)
numlabel, add force
tab loc3num sexe if clage2==20, col
keep if clage2==20
keep if loc3num==730
tab loc3num sexe if clage2==20, col
save "Thyroide_elisa.dta",replace

/*

                      |         SEXE
              loc3num |         1          2 |     Total
----------------------+----------------------+----------
  730. C73 - Thyroïde |        28        126 |       154 
                      |    100.00     100.00 |    100.00 
----------------------+----------------------+----------
                Total |        28        126 |       154 
                      |    100.00     100.00 |    100.00 

					  */


* Quels traitements ont eu ces patients

clear
odbc load, exec("select TID,PID,TREATMENT,t.TEXT_FR  as treat_txt, START_DATE , STATUS,s.TEXT_FR as status_txt, PRIORITY,GOAL,f.TEXT_FR as goal_txt from a_treatment  left join treatments t on TREATMENT=t.id left join status_treatmt s on status=s.id left join finality_treatmt f on goal=f.TEXT_FR") dsn(nicer_64) lower

clear
odbc load, exec("select TID, PID, TREATMENT, STATUS , goal  from a_treatment")  dsn(nicer_64) lower
destring *, replace
save "a_treatment.dta", replace

clear
odbc load, exec("select id as treatment, text_fr as traitement_txt from treatments")   dsn(nicer_64) lower
sort treatment
by treatment : gen nb=_n
tab nb
by treatment : gen nb2=_N
tab nb2
edit if nb2>1
keep if nb==1
drop nb*
save "treatment.dta", replace

clear
odbc load, exec("select id as status, text_fr as status_fr from status_treatmt")   dsn(nicer_64) lower
destring *, replace
sort status
save "status_treatmt.dta", replace

use "a_treatment.dta", clear
sort treatment
merge treatment using "treatment.dta"
tab _merge
drop if _merge==2
drop _merge
sort status
merge status using "status_treatmt.dta"
tab _merge
drop _merge
label def status ///
0	"Prévu"	 ///
1	"Entrepris"	 ///
2	"Terminé"	 ///
3	"Interrompu avant la fin"	 ///
4	"Refusé"	 ///
5	"Non envisagé"	 ///
6	"Pas débuté"	 ///
9	"Sans renseignement"	
label val status status

numlabel, add
tab status
keep if status<4
sort pid tid
save "traitements_CHOP.dta",replace



use "Thyroide_elisa.dta", clear
sort pid tid
merge pid tid using  "traitements_CHOP.dta"
tab _merge
keep if _merge!=2
gen ttt=1 if _merge==3
replace ttt=0 if _merge==1
tab ttt
label var ttt "Traitement thyroide"
label def oni 0 "Non" 1 "Oui"
label val ttt oni
tab ttt
drop _merge
save "Thyroide_elisa_ttt.dta", replace


use "Thyroide_elisa_ttt.dta", clear
* on va regarder les sans traitements







tab traitement_txt
contract  traitement_txt
rename _freq nbcas
edit
do "C:\Users\fourniev\AppData\Local\Temp\STD94bc_000000.tmp"
codebook tid if ttt==0