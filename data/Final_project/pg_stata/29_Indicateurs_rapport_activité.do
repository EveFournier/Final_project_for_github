


* Calcul des indicateurs du rapport d'activité

* Répertoire 0û vont se trouve les fichiers intermédiaires
cd "C:\INCIDENCE_RGT\DONNEES\"


clear
odbc load, exec("select pid, TID, TYPE, STATUS, DATE_OPEN, DESTTYPE, DESTID as vcardid from a_dpa") dsn(nicer_64) lower
sort type
save "a_dpa.dta", replace


use "a_dpa.dta", clear
keep if vcardid=="4759"
keep tid
sort tid
by tid : gen nb=_n
keep if nb==1
drop nb
sort tid
save "dpa_hug_lemo", replace

clear
odbc load, exec("select id as type, TEXT_FR as dpa_type  from dpa_type") dsn(nicer_64) lower
sort type
save "dpa_type", replace




clear
odbc load, exec("select ID as status, TEXT_FR as dpa_status from dpa_status") dsn(nicer_64) lower
destring *, replace
sort status
save "dpa_status", replace



use  "a_dpa", clear
merge type using "dpa_type"
tab _merge
edit if _merge==1
edit if _merge==2
drop if _merge!=3
drop _merge
sort status
merge status using "dpa_status"
tab _merge
keep if _merge==3
drop _merge
labmask status, val(dpa_status)
labmask type, val(dpa_type)
numlabel, add force


gen dpa_date_info=1 if inlist(type, 9,11,14,15,16,17,18,19,22,24)
replace dpa_date_info=0 if dpa_date_info==.
label var dpa_date_info "Envoi DPA pour recherche date information"
label def dpa_date_info  0 "Non" 1 "Oui"
label val dpa_date_info  dpa_date_info  
 
gen dpa_medic=1 if type>=1 & type<9
replace dpa_medic=1 if inlist(type,10,12,21,23,25,26,27)
replace dpa_medic=0 if dpa_medic==.


label var dpa_medic "Envoi DPA pour codage"
label def dpa_medic  0 "Non" 1 "Oui"
label val dpa_medic  dpa_medic  

save "dpa.dta",replace
keep if status!=2
tab status
drop if status==5
/*
tab status

       STATUS |      Freq.     Percent        Cum.
--------------+-----------------------------------
3. en attente |      9,862       69.12       69.12
     4. reçue |      4,404       30.87       99.99
   6. terminé |          1        0.01      100.00
--------------+-----------------------------------
        Total |     14,267      100.00
*/
collapse (sum) dpa_medic (sum) dpa_date_info, by(tid)
sort tid
save "nb_dpa_par_tid.dta", replace

codebook tid



use "3_base_registre_def.dta", clear
sort tid
merge tid using "nb_dpa_par_tid.dta"
tab _merge
drop if _merge==2
gen envoi_dpa=1 if _merge==3
replace envoi_dpa=0 if _merge!=3

tab envoi_dpa 
drop _merge
for var dpa_medic dpa_date_info : replace X=0 if X==.
for var dpa_medic dpa_date_info : gen nb_X=X 
bysort dpa_date_info : tab envoi_dpa dpa_medic

for var dpa_medic dpa_date_info : recode X (1/max=1)
sort tid
save "4_DPA_base_registre_def.dta", replace

clear
odbc load, exec("select tid, date(PATIENT_NOTIFICATION_DATE) as PATIENT_NOTIFICATION_DATE from a_tumor") dsn(nicer_64) lower
sort tid
save "PATIENT_NOTIFICATION_DATE.dta", replace


use "4_DPA_base_registre_def.dta", clear
sort tid
merge tid using "PATIENT_NOTIFICATION_DATE.dta"
tab _merge
keep if _merge==3
drop _merge
gen fake_date=1 if patient_notification_date==date("01/01/1900","DMY")
replace patient_notification_date=date("01-01-1900","DMY") if patient_notification_date==date("01/01/1960","DMY")
replace fake=0 if fake==.

bysort adiag : egen sum_dpa_date_info=total( nb_dpa_date_info)
bysort adiag : egen sum_dpa_medic=total(  nb_dpa_medic )

save "5_DPA_base_registre_def.dta", replace



use "5_DPA_base_registre_def.dta", clear
sort tid
merge tid using "dpa_hug_lemo"
tab _merge
gen dpa_hug_lemo=1 if _merge==3
replace dpa_hug_lemo=0 if dpa_hug_lemo==.
drop if _merge==2
drop _merge
gen fake_date=1 if patient_notification_date==date("01/01/1900","DMY")
replace fake=0 if fake==.


save "6_DPA_base_registre_def.dta", replace


 use "6_DPA_base_registre_def.dta",clear
tab adiag dpa_date_info, row
tab adiag dpa_medic, row
tabstat nb_dpa_medic nb_dpa_date_info, stat(sum) by(adiag)
tab cat
tab adiag fake_date, row



 use "6_DPA_base_registre_def.dta",clear
drop if cim10def=="C44"

tab adiag dpa_date_info, row
tab adiag dpa_medic, row
tabstat nb_dpa_medic nb_dpa_date_info, stat(sum) by(adiag)
tab cat
tab adiag fake_date, row
tab adiag dpa_hug_lemo, row
save "7_DPA_base_registre_def_sans_C44.dta", replace



 
 clear
 odbc load, exec("select TID, EVENT_TYPE, EVOLID  from a_followup") dsn(nicer_64) lower
 destring *, replace
 sort tid event_type
 by tid event_type : gen nb=_n
 tab nb
 keep if nb==1
drop nb
  sort event_type
 save "a_followup", replace
 

 
 
 clear
 odbc load, exec(" select ID as EVENT_TYPE, TEXT_FR as EVENT_TYPE_fr from followup_event") dsn(nicer_64) lower
 sort  event_type
 save "followup_event", replace
 
 use  "a_followup", clear
 merge event_type using "followup_event"
 labmask event_type, val(event_type_fr)
 tab _merge
 keep if _merge==3
 drop _merge
 sort tid
 drop event_type_fr
tab event_type
drop evolid
gen ev=1
reshape wide ev, i(tid) j( event_type)
rename ev1 progression
rename ev2 transformation
rename ev3 metastase
rename ev4 recidive
rename ev9 inconnu
rename * suivi_*
rename suivi_tid tid
sort tid
  save "followup2.dta", replace
 
 
 
 use "6_DPA_base_registre_def.dta",clear
 sort tid
 merge tid using "followup2.dta"
 tab _merge
 drop if _merge==2

 gen suivi=1 if _merge==3
 replace suivi=0 if suivi==.
 drop _merge
 for var suivi_progression suivi_transformation suivi_metastase suivi_recidive suivi_inconnu : replace X=0 if X==.
 gen nb_suivi=0
 foreach var in suivi_progression suivi_transformation suivi_metastase suivi_recidive suivi_inconnu  {
 	replace nb_suivi=nb_suivi+`var'
	
 } 
 tab nb_suivi
 save "8_DPA_base_registre_def.dta", replace
 
 for var suivi_progression suivi_transformation suivi_metastase suivi_recidive : tab adiag X , row
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 



*on va ajouter la notion de public ou privé et on prendra aussi les DPA HUG lemo

clear
odbc load, exec("select TID,VCARDID,VCARDTYPE,SOURCETYPE,MAIN_SOURCE,QUEST_STATUS from a_source") dsn(nicer_64) lower
sort tid



select ID,TEXT_FR from source_info



graph bar turn mpg gear_ratio, over(foreign)
graph bar (count), over(dpa_date_info) over(adiag)  stack bar(1, fcolor(yellow)) blabel(bar, size(medium) position(center)) ytitle("Nombre de tumeurs") legend(order(0 "Déclaration spontannée" 1 "Envoi DPA"))


putdocx clear
putdocx begin, pagenum(decimal) header(eve_header) font(arial,7,black)  pagesize(A4) // format paysage  footer(evefooter) 


 putdocx table hdr = (1, 3), border(all, nil) toheader(eve_header)
 putdocx table hdr(1, 1) = ("Le Cancer dans le canton de Genève")
 putdocx table hdr(1, 2) = ("2020-2021"), halign(center)


putdocx paragraph, style(Heading1)
putdocx text ("Déclaration des tumeurs selon la LEMO/l'OEMO")

summarize  sum_dpa_date_info if adiag==2020 , detail
local nadiag1=`r(N)'
local nb_dpa_adiag1=`r(mean)'

summarize  sum_dpa_date_info if adiag==2021 , detail
local nadiag2=`r(N)'
local nb_dpa_adiag2=`r(mean)'


putdocx textblock begin
En 2020 et 2021, le registre a entrepris de grands efforts auprès de ses partenaires soumis à l'obligation de déclaration et d'information afin 
We have the recorded weight for <<dd_docx_display: r(N)>> babies with an 
average birthweight of <<dd_docx_display: %5.2f r(mean)>> grams.
putdocx textblock end

local total = r(N)
count if smoke==1

putdocx textblock append
 There are <<dd_docx_display: r(N)>> mothers who smoked during pregnancy, and
<<dd_docx_display: `total'-r(N)>> who did not. Below we graph the mean 
birthweight for babies with mothers who smoke versus those who do not, 
separately for mothers with and without a history of hypertension.
putdocx textblock end

graph hbar bwt, over(ht) over(smoke) asyvars ///
		ytitle(Average birthweight (grams)) title(Baby birthweights) ///
		subtitle(by mother's smoking status and history of hypertension)
graph export bweight.png, replace

putdocx paragraph
putdocx image bweight.png, width(4) 

putdocx pagebreak

putdocx paragraph, style(Heading1)
putdocx text ("Regression results")



putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 47 : Evolution des taux standardisés d'incidence et de mortalité par cancer colo-rectal dans le canton de Genève [1971-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl8 = (1,1), border(all,nil) 
 putdocx table tbl8(1,1)=image(Gr53_Evolution_CRC.emf)
 

 putdocx save Graphique6, replace




putdocx append Doc_Epidemio_20240624 Graphique6	 , pagebreak pgnumrestart saving(Doc_Epidemio_20240624_bis,replace) headsrc(own)   stylesrc(own) // à voir le calcul des pages, commence dès la page de garde














