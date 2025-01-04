* NE PAS UTILISER CAR PAS INCLUS DANS RAPPORT




* Répertoire 0û vont se trouve les fichiers intermédiaires
cd "C:\INCIDENCE_RGT\DONNEES\"

use  "3_base_registre_def.dta", clear
sort loc3num sex
 
save "3_base_registre_def.dta", replace

* on va garder uniquement les 11 tumeurs les plus fréquenest

use  "1_graphique_nb_cas_incidents_mortalite_cas_invasifs.dta", clear
keep if rang_nbcas<13
keep if indic=="Incidence"
keep loc3num sexe
sort loc3num sexe
save "16_localisations_les_plus_frequentes.dta", replace



use  "3_base_registre_def.dta", clear
sort loc3num sexe
merge loc3num sexe using  "16_localisations_les_plus_frequentes.dta"
tab _merge
keep if _merge==3
drop _merge
bysort loc3num sexe : egen mean_age=mean(age)
bysort loc3num sexe : egen median_age=median(age)
save "17_lbase_registre_localisations_les_plus_frequentes.dta",replace


graph hbox age if cat==1 & sex==1, over(loc3num, sort(median_age) descending label(labsize(small))) box(1, fcolor(dknavy) lcolor(dknavy)) marker(1, mcolor(dknavy)) ytitle("Age au diagnostic")
graph export "401_Age_hommes_11_principales_localisations_incidentes_invasives.emf", replace
graph hbox age if cat==1 & sex==2, over(loc3num, sort(median_age) descending label(labsize(small))) box(1, fcolor(cranberry) lcolor(cranberry)) marker(1, mcolor(cranberry)) ytitle("Age au diagnostic")
graph export "402_Age_Femmes_11_principales_localisations_incidentes_invasives.emf", replace




putdocx clear
putdocx begin, pagenum(decimal) header(eve_header) font(arial,7,black)  pagesize(A4) // format paysage  footer(evefooter) 


 putdocx table hdr = (1, 3), border(all, nil) toheader(eve_header)
 putdocx table hdr(1, 1) = ("Le Cancer dans le canton de Genève")
 putdocx table hdr(1, 2) = ("2020-2021"), halign(center)
 

putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 43 : Age au diagnostic par cancer par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl5 = (1,2), border(all,nil) // note("Figure 5 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl5(1,1)=image(401_Age_hommes_11_principales_localisations_incidentes_invasives.emf)
 putdocx table tbl5(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl5(1,2)=image(402_Age_Femmes_11_principales_localisations_incidentes_invasives.emf)
 putdocx table tbl5(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl5(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
 
   
 putdocx save Graphique4, replace


putdocx append Fichier_Final 	Graphique4	 , pagebreak pgnumrestart saving(Doc_Epidemio,replace) headsrc(own)   stylesrc(own) // à voir le calcul des pages, commence dès la page de garde


