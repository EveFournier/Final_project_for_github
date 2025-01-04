

* OBJECTIF DU PROGRAMME : UTILISER LES OUTILS STATA POUR EXPORTER CORRECTEMENT LES RESULTATS
*-----------------------------------------------------------------------------------
*
*          DEBUT PROGRAMME
*
*-----------------------------------------------------------------------------------


* Répertoire 0û vont se trouve les fichiers intermédiaires

local donnees="C:\INCIDENCE_RGT\DONNEES\"

cd `donnees'






* PAS BESOINS D'UN FICHIER OUVERT A CE NIVEAU LA
*-----------PAGE DE GARDE ON NE MET PAS DE HEADERS ET FOOTER
putdocx clear
putdocx begin, pagenum(decimal) font(arial,7,black) pagesize(A4)
 
putdocx paragraph , indent(left,0.1)  
putdocx image "C:\INCIDENCE_RGT\IMAGES\medecine_couleur.png", width(2)


putdocx paragraph , indent(left,0.1)   spacing(before,2)   font(arial,15,black)
putdocx text ("Le cancer dans le canton de Genève")
putdocx paragraph , indent(left,0.1)   font(arial,15,black)
putdocx text ("Période 2020-2021")
putdocx paragraph , indent(left,0.1)    spacing(after,1)  font(arial,15,black)
putdocx text ("Incidence et Mortalité")


putdocx paragraph , indent(left,2.5)  
putdocx image "C:\INCIDENCE_RGT\IMAGES\Photo_jet_eau_Geneve.jpg" , width(2)  height(4)

putdocx pagebreak


 
putdocx paragraph , indent(left,0.1)  
putdocx text ("Equipe du Registre Genevois des tumeurs"),  font(arial,7,black) bold

putdocx paragraph , indent(left,1.3) spacing(before,0.1)  spacing(after,0.01)  
putdocx text ("Professeure Elisabetta Rapiti,")
putdocx text (" Directrice"), italic

putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01)  
putdocx text ("Docteure Pinelopi Argyriou,")
putdocx text (" Responsable enregistrement"), italic

putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01)  
putdocx text ("Professeure Simone Benhamou, ")
putdocx text ("Professeur titulaire"), italic


putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01)  
putdocx text ("Docteure Pauline Brindel, ")
putdocx text ("Epidémiologiste"), italic

putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01)  
putdocx text ("Claude Anne Bron, ")
putdocx text ("Enquêtrice"), italic

putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01)  
putdocx text ("Charlotte Denninger-Roux, ")
putdocx text ("Codeuse"), italic

putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01)  
putdocx text ("Docteure Evelyne Fournier, ")
putdocx text ("Data-Manager Statisticienne"), italic

putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01)  
putdocx text ("Nathalie Hide-Giesenfeld, ")
putdocx text ("Assitante administrative"), italic

putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01) 
putdocx text ("Raphael Melon, ")
putdocx text ("Codeur"), italic

putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01)  
putdocx text ("Nathalie Robert Viceriat, ")
putdocx text ("Codeuse"), italic

putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01)  
putdocx text ("Docteur Robin Schaffar, ")
putdocx text ("Epidémiologiste"), italic

putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01)  
putdocx text ("Hyma Schubert, ")
putdocx text ("Biologiste-Collecte des données"), italic

putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01)  
putdocx text ("Jessica Tchoulfayan, ")
putdocx text ("Codeuse"), italic

putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01)  
putdocx text ("Web")
putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01)  
putdocx text ("https://unige.ch/medecine/rgt/accueil/")




putdocx paragraph , indent(left,1.3) spacing(before,1)  spacing(after,0.01)  
putdocx text ("Lister et remercier nos sources de données ?")
putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.5)  
putdocx text ("Lister et remercier nos partenaires officiels style rectorat, DGS OFS ONEC-Le Registre genevois des tumeurs remercie vivement :?")



putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01)  
putdocx text ("Mettre un mot sur les données contenues dans le document, ex :")
putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01)  
putdocx text ("Ce document présente la situation épidémiologique descriptive de l'incidence et de la mortalité par cancer sur le canton de Genève sur la période 2020-2021.")
putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01)  
putdocx text ("Les données de mortalité proviennent de l'Office Fédéral de la Statistique. ")
putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.1)  
putdocx text ("https://www.bfs.admin.ch/bfs/fr/home.html")


putdocx paragraph , indent(left,0.1) spacing(before,1.3)  spacing(after,0.01)  
putdocx text ("Crédits photographies :"), bold
putdocx paragraph , indent(left,1.3) spacing(before,0.01)  spacing(after,0.01)  
putdocx text ("Page de garde : Elisabetta Rapiti, Genève et son jet d'eau")


putdocx save page_garde1, replace



 putdocx append page_garde1 Preambule, saving(page_garde, replace)  pagebreak headsrc(own) stylesrc(own) 
 


*----------------------------------------------------------------------------- Incidence et mortalité par cancer, graphiques 1 et 2


use  "3_base_registre_def.dta", clear
numlabel, remove
quietly tab cat 
local nbcas_cat_periode=`r(N)'

quietly tab cat if cat==1
local nbcas_invasif=`r(N)'

quietly tab cat if cat==2
local nbcas_insitu=`r(N)'

quietly tab cat if cat==3
local nbcas_benin=`r(N)'


quietly tab cat if cat==4
local nbcas_incertains=`r(N)'


quietly tab cim10def if cim10def=="C44" 
local nbcas_c44=`r(N)'


 
use "6_morta_geneve.dta" , clear
numlabel, remove
quietly tab cat 
local nbdc_cat_period=`r(N)'

quietly tab cat if cat==1
local nbdc_invasif=`r(N)'


  * graphique tumeurs incidentes  
use  "3_base_registre_def.dta", clear
numlabel, remove
quietly tab cat 
local nbcas_cat_periode=`r(N)'


 drop if cim10def=="C44"
 
 
quietly tab cat 
local nbcas_cat=`r(N)'/2

contract cat adiag
rename _freq nbcas
collapse (sum) nbcas,by(cat)
replace nbcas=nbcas/2

graph bar (asis) nbcas, over(cat) bar(1, fcolor(dknavy) lcolor(none)) blabel(bar, size(medium) format(%9.0f)) ytitle("Nombre moyen annuel de cas")   caption(Nombre moyen annuel de nouveaux cas=`nbcas_cat' cas, size(*1)) 
graph export "Gr0_Behavior_incidence.emf", replace

*graph bar (count) if cim10def!="C44", over(cat) bar(1, fcolor(navy) lcolor(dknavy)) blabel(bar, size(medium)) ytitle("Nombre de cas") ylabel(0(500)4000)  caption(N=`nbcas_cat', size(*1)) 

 
 
use "6_morta_geneve.dta" , clear
numlabel, remove
drop if cim10def=="C44"
quietly tab cat 
local nbcas_cat=`r(N)'/2

contract cat adiag
rename _freq nbcas
collapse (sum) nbcas,by(cat)
replace nbcas=nbcas/2

graph bar (asis) nbcas, over(cat) bar(1, fcolor(cranberry) lcolor(none)) blabel(bar, size(medium) format(%9.0f)) ytitle("Nombre moyen annuel de décès")   caption(Nombre moyen annuel de nouveaux cas=`nbcas_cat' cas, size(*1))  ylabel(0(200)1000)
graph export "Gr2_Behavior_morta.emf", replace


  
putdocx clear

putdocx begin, pagenum(decimal)  header(eve_header) font(arial,7,black) pagesize(A4) // format paysage footer(evefooter) 

 putdocx table hdr = (1, 3), border(all, nil) toheader(eve_header)
 putdocx table hdr(1, 1) = ("Le Cancer dans le Canton de Genève")
 putdocx table hdr(1, 2) = ("2020-2021"), halign(center)
 
putdocx paragraph, style(Heading1)
putdocx text ("Incidence et mortalité par cancer")

putdocx textblock begin
Sur la période 2020-2021, un total de <<dd_docx_display: `nbcas_cat_periode'>> nouveaux cas de cancers ont été diagnostiqués sur le canton de Genève : <<dd_docx_display: `nbcas_invasif'>> cancers invasifs (dont <<dd_docx_display: `nbcas_c44'>> cancers de la peau hors mélanome), <<dd_docx_display: `nbcas_insitu'>> cancers in-situ, <<dd_docx_display: `nbcas_benin'>> cancers bénins et <<dd_docx_display: `nbcas_incertains'>> cancers de comportement incertain.
putdocx textblock end

putdocx textblock begin
Sur cette même période,  <<dd_docx_display: `nbdc_cat_period'>>  décès par cancer étaient enregistrés.
putdocx textblock end

putdocx textblock begin
La figure 1 illustre la distribution par comportement tumoral.
putdocx textblock end


putdocx textblock end
 
putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 
putdocx text ("Figure 1 : Nombre moyen annuel nouvelles tumeurs et de décès en 2020 et 2021 selon le comportement tumoral"), bold
putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 

 putdocx table tbl00 = (1,2), border(all,nil)
 putdocx table tbl00(1,1)=image("Gr0_Behavior_incidence.emf")
 putdocx table tbl00(1,1)=("(a) Incidence"), append halign(center)
 putdocx table tbl00(1,2)=image("Gr2_Behavior_morta.emf")
 putdocx table tbl00(1,2)=("(b) Mortalité"), append halign(center)
 
 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Invasif : hors cancers de la peau non mélanomique"), italic 
  
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Mortalité par cancer : source Office Fédéral de la Statistique"), italic 
 
  putdocx save Graphiques_pour_tableau_1_2_TI_TM_Total, replace
 

 putdocx append page_garde Graphiques_pour_tableau_1_2_TI_TM_Total, saving(Intro, replace)  pagebreak headsrc(own) stylesrc(own) 
 
*----------------------------------------------------------------------Figure 2 : distribution par sexe
 
**# Bookmark #3
 
 
   
  * des graphiques par se pour illustrer
  
  * INCIDENCE 
use  "3_base_registre_def.dta", clear
numlabel, remove
quietly tab sexe if cim10def!="C44" & cat==1 
local nbcas=round(`r(N)'/2)
graph pie if cim10def!="C44" & cat==1 , over(sexe) pie(1, color(dknavy)) pie(2, color(cranberry)) plabel(_all percent, color(white) size(large)  format(%9.1f)) title("Invasifs") legend(order(1 "Homme" 2 "Femme") rows(1) position(6))  caption(Nombre moyen annuel de nouveaux cas=`nbcas', size(*1)) 
graph export "Gr01_sexe_incidence_Invasifs_2020_2021.emf", replace
 
 quietly tab sexe if cim10def!="C44" & cat==2 
local nbcas=round(`r(N)'/2)
graph pie if cim10def!="C44" & cat==2 , over(sexe) pie(1, color(dknavy)) pie(2, color(cranberry)) plabel(_all percent, color(white) size(large)  format(%9.1f)) title("In-Situ") legend(order(1 "Homme" 2 "Femme") rows(1) position(6))  caption(Nombre moyen annuel de nouveaux cas=`nbcas', size(*1)) 
graph export "Gr02_sexe_incidence_Insitu_2020_2021.emf", replace

quietly tab sexe if cim10def!="C44" & cat==3 
local nbcas=round(`r(N)'/2)
graph pie if cim10def!="C44" & cat==3 , over(sexe) pie(1, color(dknavy)) pie(2, color(cranberry)) plabel(_all percent, color(white) size(large)  format(%9.1f)) title("Bénin") legend(order(1 "Homme" 2 "Femme") rows(1) position(6))  caption(Nombre moyen annuel de nouveaux cas=`nbcas', size(*1)) 
graph export "Gr03_sexe_incidence_Benin_2020_2021.emf", replace

quietly tab sexe if cim10def!="C44" & cat==4 
local nbcas=round(`r(N)'/2)
graph pie if cim10def!="C44"  & cat==4 , over(sexe) pie(1, color(dknavy)) pie(2, color(cranberry)) plabel(_all percent, color(white) size(large)  format(%9.1f)) title("Incertain") legend(order(1 "Homme" 2 "Femme") rows(1) position(6))  caption(Nombre moyen annuel de nouveaux cas=`nbcas', size(*1)) 
graph export "Gr04_sexe_incidence_Incertain_2020_2021.emf", replace


 
use "6_morta_geneve.dta" , clear
numlabel, remove
quietly tab sexe if cim10def!="C44" & cat==1 
 local nbcas=round(`r(N)'/2)
graph pie if cim10def!="C44" & cat==1 , over(sexe) pie(1, color(dknavy)) pie(2, color(cranberry)) plabel(_all percent, color(white) size(large)  format(%9.1f)) title("Invasifs") legend(order(1 "Homme" 2 "Femme")  rows(1) position(6))  caption(Nombre moyen annuel de décès=`nbcas', size(*1)) 
graph export "Gr05_sexe_morta_Invasifs_2020_2021.emf", replace
 /*
 quietly tab sexe if cim10def!="C44" & cat==2 
graph pie if cim10def!="C44" & cat==2 , over(sexe) pie(1, color(dknavy)) pie(2, color(cranberry)) plabel(_all percent, color(white) size(large)  format(%9.1f)) title("In-Situ") legend(order(1 "Homme" 2 "Femme")  rows(1) position(6))  caption(N=`r(N)', size(*1)) 
graph export "Gr06_sexe_morta_Insitu_2020_2021.emf", replace

quietly tab sexe if cim10def!="C44" & cat==3 
graph pie if cim10def!="C44" & cat==3 , over(sexe) pie(1, color(dknavy)) pie(2, color(cranberry)) plabel(_all percent, color(white) size(large)  format(%9.1f)) title("Bénin") legend(order(1 "Homme" 2 "Femme") rows(1) position(6))  caption(N=`r(N)', size(*1)) 
graph export "Gr07_sexe_morta_Benin_2020_2021.emf", replace

quietly tab sexe if cim10def!="C44" & cat==4 
graph pie if cim10def!="C44"  & cat==4 , over(sexe) pie(1, color(dknavy)) pie(2, color(cranberry)) plabel(_all percent, color(white) size(large)  format(%9.1f)) title("Incertain") legend(order(1 "Homme" 2 "Femme") rows(1) position(6))  caption(N=`r(N)', size(*1)) 
graph export "Gr08_sexe_morta_Incertain_2020_2021.emf", replace
*/
   
  
putdocx begin, pagenum(decimal)  header(eve_header) font(arial,7,black) pagesize(A4) ///
margin(left,1.5cm) ///
margin(right,1.5cm) //footer(evefooter) 

 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 

 putdocx table hdr = (1, 3), border(all, nil) toheader(eve_header)
 putdocx table hdr(1, 1) = ("Le Cancer dans le Canton de Genève")
 putdocx table hdr(1, 2) = ("2020-2021"), halign(center)
putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 
putdocx text ("Figure 2 : Distribution des nouveaux cas incidents 2020 et 2021 selon le sexe, pour chaque comportement tumoral"), bold
putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 

 putdocx table tbl001 = (2,2), border(all,nil)
 putdocx table tbl001(1,1)=image("Gr01_sexe_incidence_Invasifs_2020_2021.emf"), width(4)  halign(center)
 putdocx table tbl001(1,1)=(""), append halign(center)
 
 putdocx table tbl001(1,2)=image("Gr02_sexe_incidence_Insitu_2020_2021.emf"), width(4)  halign(center)
 putdocx table tbl001(1,2)=(""), append halign(center)
 putdocx table tbl001(2,1)=image("Gr03_sexe_incidence_Benin_2020_2021.emf"), width(4) halign(center)
 putdocx table tbl001(2,1)=(""), append halign(center)
 putdocx table tbl001(2,2)=image("Gr04_sexe_incidence_Incertain_2020_2021.emf"), width(4) halign(center)
 putdocx table tbl001(2,2)=(""), append halign(center)
 
 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Hors cancers de la peau non mélanomique"), italic 
  
   putdocx pagebreak
 putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 

putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 
putdocx text ("Figure 3 : Distribution des décès par cancer invasif 2020 et 2021 selon le sexe"), bold
putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 

 putdocx table tbl002 = (1,2), border(all,nil)
 putdocx table tbl002(1,1)=image("Gr05_sexe_morta_Invasifs_2020_2021.emf"), width(4) halign(center)
 putdocx table tbl002(1,1)=(""), append halign(center)
 /*
 putdocx table tbl002(1,2)=image("Gr06_sexe_morta_Insitu_2020_2021.emf")
 putdocx table tbl002(1,2)=(""), append halign(center)
 putdocx table tbl002(2,1)=image("Gr07_sexe_morta_Benin_2020_2021.emf")
 putdocx table tbl002(2,1)=(""), append halign(center)
 putdocx table tbl002(2,2)=image("Gr08_sexe_morta_Incertain_2020_2021.emf")
 putdocx table tbl002(2,2)=(""), append halign(center)
   */
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Mortalité par cancer : source OFS"), italic 
   
  putdocx save Graphiques_par_sexe, replace
 
  
  putdocx append Intro Graphiques_par_sexe, saving(Partie1, replace)  pagebreak headsrc(own) stylesrc(own) 
 
 
**# Bookmark #1
   *-------------------------------------------------FIGURES 4 ET 5 DES TAUX D'INCIDENCE
   * initialement dans 1111_GRAPHIQUES_1_2_graph_bar_incid_morta.do
  
 




















*----------------------------------TABLEAU 1 : NOMBRE DE CAS PAR AN ET TAUX D'INCIDENCE ET DE MORTALITE POUR CHAQUE ANNEE

use "TI_TM_Geneve_Final.dta", clear
keep if indic=="Incidence" & adiag=="[2020-2021]" &  inlist(loc3num,1000,1001,2099,3099,4099)
save "Tableau_1_TI_Geneve_periode.dta",replace

putdocx begin, pagenum(decimal)  header(eve_header) font(arial,7,black) landscape pagesize(A4) // format paysage footer(evefooter) 

 putdocx table hdr = (1, 3), border(all, nil) toheader(eve_header)
 putdocx table hdr(1, 1) = ("Le Cancer dans le Canton de Genève")
 putdocx table hdr(1, 2) = ("2020-2021"), halign(center)
  
* Incidence par année sur la période 2020-2021

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Tableau 1 : Incidence des cancers sur le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
  
  *title("Tableau 1 : Incidence des cancers sur le canton de Genève [2020-2021]")
 putdocx table tableau1 = data(loc3num  nbcas1 moy_an1 taux_brut1 taux_std1 ic951 vide nbcas2 moy_an2 taux_brut2 taux_std2 ic952)  ,  title("Tableau 1 : Incidence des cancers sur le canton de Genève [2020-2021]") layout(autofitwindow)    ///
 border(all, nil)  
 *border(top) ///
 *border(bottom)
 
 
 
  putdocx table tableau1(1,.), addrows(1)
  putdocx table tableau1(2,1)=("Comportement"), append halign(left) bold font(Arial,7,black)
  putdocx table tableau1(2,2)=("Total cas période (hommes)"), append halign(left) bold font(Arial,7,black)
  putdocx table tableau1(2,3)=("Cas/an (hommes)"), append halign(left) bold
  putdocx table tableau1(2,4)=("Taux brut"), append halign(left) bold
  putdocx table tableau1(2,5)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau1(2,6)=("IC95%"), append halign(left) bold
  putdocx table tableau1(2,7)=("   "), append halign(left) bold
  putdocx table tableau1(2,8)=("Total cas période (femmes)"), append halign(left) bold font(Arial,7,black)
  putdocx table tableau1(2,9)=("Cas/an (femmes)"), append halign(left) bold
  putdocx table tableau1(2,10)=("Taux brut"), append halign(left) bold
  putdocx table tableau1(2,11)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau1(2,12)=("IC95%"), append halign(left) bold
  *putdocx table tableau1(1,.), drop 
      

  putdocx table tableau1(2,.), border(top)
  putdocx table tableau1(2,.), border(bottom)
  *putdocx table tableau1(6,.), border(top)
  putdocx table tableau1(7,.), border(bottom)
  *putdocx table tableau1(6,.), bold

putdocx paragraph ,  spacing(before,0.1)  spacing(after,0.1)  font(arial,7,black)
putdocx text ("")

 
* Mortalité par année sur la période 2020-2021

use "TI_TM_Geneve_Final.dta", clear
keep if indic=="Mortalité" & adiag=="[2020-2021]" &  inlist(loc3num,1000,1001,2099,3099,4099)
save "Tableau_2_TM_Geneve_periode.dta",replace


 putdocx table tableau2 = data(loc3num nbcas1 moy_an1 taux_brut1 taux_std1 ic951 vide nbcas2 moy_an2 taux_brut2 taux_std2 ic952) , title("Tableau 2 : Mortalité par cancer sur le canton de Genève [2020-2021]")  ///
 layout(autofitwindow)    ///
 border(all, nil)  
 *border(top) ///
 *border(bottom)
  putdocx table tableau2(1,.), addrows(1)
  putdocx table tableau2(2,1)=("Comportement"), append halign(left) bold font(Arial,7,black)
  putdocx table tableau2(2,2)=("Total décès période (hommes)"), append halign(left) bold font(Arial,7,black)
  putdocx table tableau2(2,3)=("Décès/an (hommes)"), append halign(left) bold
  putdocx table tableau2(2,4)=("Taux brut"), append halign(left) bold
  putdocx table tableau2(2,5)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau2(2,6)=("IC95%"), append halign(left) bold
  putdocx table tableau2(2,7)=("   "), append halign(left) bold
  putdocx table tableau2(2,8)=("Total décès période (femmes)"), append halign(left) bold font(Arial,7,black)
  putdocx table tableau2(2,9)=("Décès/an (femmes)"), append halign(left) bold
  putdocx table tableau2(2,10)=("Taux brut"), append halign(left) bold
  putdocx table tableau2(2,11)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau2(2,12)=("IC95%"), append halign(left) bold
  *putdocx table tableau1(1,.), drop 
      
  putdocx table tableau2(2,.), border(top)
  putdocx table tableau2(2,.), border(bottom)
  *putdocx table tableau1(5,.), border(top)
  putdocx table tableau2(7,.), border(bottom)
  *putdocx table tableau1(5,.), bold

  
  *putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  *putdocx text ("Total invasifs, hors cancers de la peau non mélanomique"), italic 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux brut : taux pour 100 000 personnes/an"), italic 
   putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux standardisé : taux pour 100 000 personnes/an, standardisation européenne"), italic 
 
  
  

 putdocx save tableau_1_2_TI_TM_Total1, replace
 
 
 *putdocx append essai1 essai2, saving(total3)  pagebreak headsrc(own) stylesrc(own)
 
*----------------------------------------------ON ENVOIE SOUS WORD

*----------------------------------TABLEAU 3 : NOMBRE DE CAS PAR AN ET TAUX D'INCIDENCE ET DE MORTALITE POUR CHAQUE LOCALISATION

use "3_Tableau_global_TI_TM_par_localisation_periodes_incid_morta.dta", clear
keep if adiag=="[2020-2021]"
sort indic cat loc3num

putdocx begin, pagenum(decimal)  header(eve_header) font(arial,7,black) landscape pagesize(A4) ///
margin(left,1.5cm) ///
margin(right,1.5cm) //footer(evefooter) 


 putdocx table hdr = (1, 3), border(all, nil) toheader(eve_header)
 putdocx table hdr(1, 1) = ("Le Cancer dans le Canton de Genève")
 putdocx table hdr(1, 2) = ("2020-2021"), halign(center)
 
* Incidence par année sur la période 2020-2021
 putdocx table tableau3 = data(loc3num nbcas1 moy_an1 taux_brut1 taux_std1 ic951 vide nbcas2 moy_an2 taux_brut2 taux_std2 ic952) if indic=="Incidence" & cat==1, title("Tableau 3 : Incidence des cancers invasifs sur le canton de Genève [2020-2021]")  ///
 layout(autofitcontents)   border(all, nil) 
 *border(top) ///
 *border(bottom)
  putdocx table tableau3(1,.), addrows(1)
  putdocx table tableau3(2,1)=("Localisation cancéreuse                 "), append halign(left) bold font(Arial,7,black)
  putdocx table tableau3(2,2)=("Total cas (hommes)"), append halign(left) bold
  putdocx table tableau3(2,3)=("Cas/an (hommes)"), append halign(left) bold
  putdocx table tableau3(2,4)=("Taux brut"), append halign(left) bold
  putdocx table tableau3(2,5)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau3(2,6)=("IC95%         "), append halign(left) bold
  putdocx table tableau3(2,7)=(" "), append halign(left) bold
  putdocx table tableau3(2,8)=("Total cas (femmes)"), append halign(left) bold
  putdocx table tableau3(2,9)=("Cas/an (femmes)"), append halign(left) bold
  putdocx table tableau3(2,10)=("Taux brut"), append halign(left) bold
  putdocx table tableau3(2,11)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau3(2,12)=("IC95%         "), append halign(left) bold
  *putdocx table tableau1(1,.), drop 
      
*ALIGNEMENTS  
  putdocx table tableau3(.,2),   halign(right)
  putdocx table tableau3(.,3),   halign(right)
  putdocx table tableau3(.,4),   halign(right)
  putdocx table tableau3(.,5),    halign(right)
  putdocx table tableau3(.,6),   halign(right)
  putdocx table tableau3(.,7),   halign(right)
  putdocx table tableau3(.,8),   halign(right)
  putdocx table tableau3(.,9),   halign(right)
  putdocx table tableau3(.,10),  halign(right)
  putdocx table tableau3(.,11),  halign(right)
  putdocx table tableau3(.,12),  halign(right) 
  
  
  putdocx table tableau3(2,.), border(top)
  putdocx table tableau3(2,.), border(bottom)
  putdocx table tableau3(38,.), border(top)
  putdocx table tableau3(38,.), border(bottom)
  putdocx table tableau3(38,.), bold
  putdocx table tableau3(39,.), border(top)
  putdocx table tableau3(39,.), border(bottom)
  putdocx table tableau3(39,.), bold
  
  
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Autres* : C30,C31,C37,C39,C46,C48,C51,C52,C58,C60,C63,C69,C74,C76,C77,C78,C79,C86,C88"), italic 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux brut : taux pour 100 000 personnes/an"), italic 
   putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux standardisé : taux pour 100 000 personnes/an, standardisation européenne"), italic 
 
 
  
putdocx pagebreak


* Incidence par année sur la période 2020-2021
 putdocx table tableau4 = data(loc3num nbcas1 moy_an1 taux_brut1 taux_std1 ic951 vide nbcas2 moy_an2 taux_brut2 taux_std2 ic952) if indic=="Incidence" & cat==2, title("Tableau 4 : Incidence des cancers in-situ sur le canton de Genève [2020-2021]")  ///
 layout(autofitcontents)   border(all, nil) 
 *border(top) ///
 *border(bottom)
  putdocx table tableau4(1,.), addrows(1)
  putdocx table tableau4(2,1)=("Localisation cancéreuse                 "), append halign(left) bold font(Arial,7,black)
  putdocx table tableau4(2,2)=("Total cas (hommes)"), append halign(left) bold
  putdocx table tableau4(2,3)=("Cas/an (hommes)"), append halign(left) bold
  putdocx table tableau4(2,4)=("Taux brut"), append halign(left) bold
  putdocx table tableau4(2,5)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau4(2,6)=("IC95%         "), append halign(left) bold
  putdocx table tableau4(2,7)=(" "), append halign(left) bold
  putdocx table tableau4(2,8)=("Total cas (femmes)"), append halign(left) bold
  putdocx table tableau4(2,9)=("Cas/an (femmes)"), append halign(left) bold
  putdocx table tableau4(2,10)=("Taux brut"), append halign(left) bold
  putdocx table tableau4(2,11)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau4(2,12)=("IC95%         "), append halign(left) bold
  *putdocx table tableau1(1,.), drop 
      
*ALIGNEMENTS  
  putdocx table tableau4(.,2),   halign(right)
  putdocx table tableau4(.,3),   halign(right)
  putdocx table tableau4(.,4),   halign(right)
  putdocx table tableau4(.,5),    halign(right)
  putdocx table tableau4(.,6),   halign(right)
  putdocx table tableau4(.,7),   halign(right)
  putdocx table tableau4(.,8),   halign(right)
  putdocx table tableau4(.,9),   halign(right)
  putdocx table tableau4(.,10),  halign(right)
  putdocx table tableau4(.,11),  halign(right)
  putdocx table tableau4(.,12),  halign(right) 
  
  
  putdocx table tableau4(2,.), border(top)
  putdocx table tableau4(2,.), border(bottom)
    putdocx table tableau4(11,.), border(top)
  putdocx table tableau4(11,.), border(bottom)
  putdocx table tableau4(11,.), bold
   putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux brut : taux pour 100 000 personnes/an"), italic 
   putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux standardisé : taux pour 100 000 personnes/an, standardisation européenne"), italic 
 
  
  
  
putdocx pagebreak


* Incidence par année sur la période 2020-2021
 putdocx table tableau5 = data(loc3num nbcas1 moy_an1 taux_brut1 taux_std1 ic951 vide nbcas2 moy_an2 taux_brut2 taux_std2 ic952) if indic=="Incidence" & cat==3, title("Tableau 5 : Incidence des cancers bénins sur le canton de Genève [2020-2021]")  ///
 layout(autofitcontents)   border(all, nil) 
 *border(top) ///
 *border(bottom)
  putdocx table tableau5(1,.), addrows(1)
  putdocx table tableau5(2,1)=("Localisation cancéreuse                 "), append halign(left) bold font(Arial,7,black)
  putdocx table tableau5(2,2)=("Total cas (hommes)"), append halign(left) bold
  putdocx table tableau5(2,3)=("Cas/an (hommes)"), append halign(left) bold
  putdocx table tableau5(2,4)=("Taux brut"), append halign(left) bold
  putdocx table tableau5(2,5)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau5(2,6)=("IC95%         "), append halign(left) bold
  putdocx table tableau5(2,7)=(" "), append halign(left) bold
  putdocx table tableau5(2,8)=("Total cas (femmes)"), append halign(left) bold
  putdocx table tableau5(2,9)=("Cas/an (femmes)"), append halign(left) bold
  putdocx table tableau5(2,10)=("Taux brut"), append halign(left) bold
  putdocx table tableau5(2,11)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau5(2,12)=("IC95%         "), append halign(left) bold
  *putdocx table tableau1(1,.), drop 
      
*ALIGNEMENTS  
  putdocx table tableau5(.,2),   halign(right)
  putdocx table tableau5(.,3),   halign(right)
  putdocx table tableau5(.,4),   halign(right)
  putdocx table tableau5(.,5),    halign(right)
  putdocx table tableau5(.,6),   halign(right)
  putdocx table tableau5(.,7),   halign(right)
  putdocx table tableau5(.,8),   halign(right)
  putdocx table tableau5(.,9),   halign(right)
  putdocx table tableau5(.,10),  halign(right)
  putdocx table tableau5(.,11),  halign(right)
  putdocx table tableau5(.,12),  halign(right) 
  
  
  putdocx table tableau5(2,.), border(top)
  putdocx table tableau5(2,.), border(bottom)
    putdocx table tableau5(12,.), border(top)
  putdocx table tableau5(12,.), border(bottom)
  putdocx table tableau5(12,.), bold
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux brut : taux pour 100 000 personnes/an"), italic 
   putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux standardisé : taux pour 100 000 personnes/an, standardisation européenne"), italic 
 
  
  
putdocx pagebreak


* Incidence par année sur la période 2020-2021
 putdocx table tableau6 = data(loc3num nbcas1 moy_an1 taux_brut1 taux_std1 ic951 vide nbcas2 moy_an2 taux_brut2 taux_std2 ic952) if indic=="Incidence" & cat==4, title("Tableau 6 : Incidence des cancers de comportement incertain sur le canton de Genève [2020-2021]")  ///
 layout(autofitcontents)   border(all, nil) 
 *border(top) ///
 *border(bottom)
  putdocx table tableau6(1,.), addrows(1)
  putdocx table tableau6(2,1)=("Localisation cancéreuse                 "), append halign(left) bold font(Arial,7,black)
  putdocx table tableau6(2,2)=("Total cas (hommes)"), append halign(left) bold
  putdocx table tableau6(2,3)=("Cas/an (hommes)"), append halign(left) bold
  putdocx table tableau6(2,4)=("Taux brut"), append halign(left) bold
  putdocx table tableau6(2,5)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau6(2,6)=("IC95%         "), append halign(left) bold
  putdocx table tableau6(2,7)=(" "), append halign(left) bold
  putdocx table tableau6(2,8)=("Total cas (femmes)"), append halign(left) bold
  putdocx table tableau6(2,9)=("Cas/an (femmes)"), append halign(left) bold
  putdocx table tableau6(2,10)=("Taux brut"), append halign(left) bold
  putdocx table tableau6(2,11)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau6(2,12)=("IC95%         "), append halign(left) bold
  *putdocx table tableau1(1,.), drop 
      
*ALIGNEMENTS  
  putdocx table tableau6(.,2),   halign(right)
  putdocx table tableau6(.,3),   halign(right)
  putdocx table tableau6(.,4),   halign(right)
  putdocx table tableau6(.,5),    halign(right)
  putdocx table tableau6(.,6),   halign(right)
  putdocx table tableau6(.,7),   halign(right)
  putdocx table tableau6(.,8),   halign(right)
  putdocx table tableau6(.,9),   halign(right)
  putdocx table tableau6(.,10),  halign(right)
  putdocx table tableau6(.,11),  halign(right)
  putdocx table tableau6(.,12),  halign(right) 
  
  
  putdocx table tableau6(2,.), border(top)
  putdocx table tableau6(2,.), border(bottom)
    putdocx table tableau6(15,.), border(top)
  putdocx table tableau6(15,.), border(bottom)
  putdocx table tableau6(15,.), bold
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux brut : taux pour 100 000 personnes/an"), italic 
   putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux standardisé : taux pour 100 000 personnes/an, standardisation européenne"), italic 
 
 
 

  
putdocx pagebreak



* Mortalité par année sur la période 2020-2021
 putdocx table tableau7 = data(loc3num nbcas1 moy_an1 taux_brut1 taux_std1 ic951 vide nbcas2 moy_an2 taux_brut2 taux_std2 ic952) if indic=="Mortalité" & cat==1, title("Tableau 7 : Mortalité par cancer invasifs sur le canton de Genève [2020-2021]")  ///
 layout(autofitcontents)   border(all, nil)  
 *border(top) ///
 *border(bottom)
  putdocx table tableau7(1,.), addrows(1)
  putdocx table tableau7(2,1)=("Localisation cancéreuse                 "), append halign(left) bold font(Arial,7,black)
  putdocx table tableau7(2,2)=("Total décès (hommes)"), append halign(left) bold
  putdocx table tableau7(2,3)=("Décès/an (hommes)"), append halign(left) bold
  putdocx table tableau7(2,4)=("Taux brut"), append halign(left) bold
  putdocx table tableau7(2,5)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau7(2,6)=("IC95%         "), append halign(left) bold
  putdocx table tableau7(2,7)=(" "), append halign(left) bold
  putdocx table tableau7(2,8)=("Total décès (femmes)"), append halign(left) bold
  putdocx table tableau7(2,9)=("Décès/an (femmes)"), append halign(left) bold
  putdocx table tableau7(2,10)=("Taux brut"), append halign(left) bold
  putdocx table tableau7(2,11)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau7(2,12)=("IC95%         "), append halign(left) bold
  *putdocx table tableau1(1,.), drop 
      
	*ALIGNEMENTS  
  putdocx table tableau7(.,2),   halign(right)
  putdocx table tableau7(.,3),   halign(right)
  putdocx table tableau7(.,4),   halign(right)
  putdocx table tableau7(.,5),   halign(right)
  putdocx table tableau7(.,6),   halign(right)
  putdocx table tableau7(.,7),   halign(right)
  putdocx table tableau7(.,8),   halign(right)
  putdocx table tableau7(.,9),   halign(right)
  putdocx table tableau7(.,10),  halign(right)
  putdocx table tableau7(.,11),  halign(right)
  putdocx table tableau7(.,12),  halign(right) 
  
  
  
  putdocx table tableau7(2,.), border(top)
  putdocx table tableau7(2,.), border(bottom)
  putdocx table tableau7(38,.), border(top)
  putdocx table tableau7(38,.), border(bottom)
  putdocx table tableau7(38,.), bold
  putdocx table tableau7(39,.), border(top)
  putdocx table tableau7(39,.), border(bottom)
  putdocx table tableau7(39,.), bold

  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Autres* : C30,C31,C37,C39,C46,C48,C51,C52,C58,C60,C63,C69,C74,C76,C77,C78,C79,C86,C88"), italic  
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux brut : taux pour 100 000 personnes/an"), italic 
   putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux standardisé : taux pour 100 000 personnes/an, standardisation européenne"), italic 
   
putdocx pagebreak

* Mortalité par année sur la période 2020-2021
 putdocx table tableau8 = data(loc3num nbcas1 moy_an1 taux_brut1 taux_std1 ic951 vide nbcas2 moy_an2 taux_brut2 taux_std2 ic952) if indic=="Mortalité" & cat==3, title("Tableau 8 : Mortalité par cancer bénins sur le canton de Genève [2020-2021]")  ///
 layout(autofitcontents)   border(all, nil)  
 *border(top) ///
 *border(bottom)
  putdocx table tableau8(1,.), addrows(1)
  putdocx table tableau8(2,1)=("Localisation cancéreuse                 "), append halign(left) bold font(Arial,7,black)
  putdocx table tableau8(2,2)=("Total décès (hommes)"), append halign(left) bold
  putdocx table tableau8(2,3)=("Décès/an (hommes)"), append halign(left) bold
  putdocx table tableau8(2,4)=("Taux brut"), append halign(left) bold
  putdocx table tableau8(2,5)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau8(2,6)=("IC95%         "), append halign(left) bold
  putdocx table tableau8(2,7)=(" "), append halign(left) bold
  putdocx table tableau8(2,8)=("Total décès (femmes)"), append halign(left) bold
  putdocx table tableau8(2,9)=("Décès/an (femmes)"), append halign(left) bold
  putdocx table tableau8(2,10)=("Taux brut"), append halign(left) bold
  putdocx table tableau8(2,11)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau8(2,12)=("IC95%         "), append halign(left) bold
  *putdocx table tableau1(1,.), drop 
      
	*ALIGNEMENTS  
  putdocx table tableau8(.,2),   halign(right)
  putdocx table tableau8(.,3),   halign(right)
  putdocx table tableau8(.,4),   halign(right)
  putdocx table tableau8(.,5),   halign(right)
  putdocx table tableau8(.,6),   halign(right)
  putdocx table tableau8(.,7),   halign(right)
  putdocx table tableau8(.,8),   halign(right)
  putdocx table tableau8(.,9),   halign(right)
  putdocx table tableau8(.,10),  halign(right)
  putdocx table tableau8(.,11),  halign(right)
  putdocx table tableau8(.,12),  halign(right) 
  
  
  
  putdocx table tableau8(2,.), border(top)
  putdocx table tableau8(2,.), border(bottom)
  putdocx table tableau8(12,.), border(top)
  putdocx table tableau8(12,.), border(bottom)
  putdocx table tableau8(12,.), bold

  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux brut : taux pour 100 000 personnes/an"), italic 
   putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux standardisé : taux pour 100 000 personnes/an, standardisation européenne"), italic 
 
    
  
  
putdocx pagebreak
 

* Mortalité par année sur la période 2020-2021
 

* Mortalité par année sur la période 2020-2021
 putdocx table tableau9 = data(loc3num nbcas1 moy_an1 taux_brut1 taux_std1 ic951 vide nbcas2 moy_an2 taux_brut2 taux_std2 ic952) if indic=="Mortalité" & cat==4, title("Tableau 9 : Mortalité par cancer de comportement incertain sur le canton de Genève [2020-2021]")  ///
 layout(autofitcontents)   border(all, nil)  
 *border(top) ///
 *border(bottom)
  putdocx table tableau9(1,.), addrows(1)
  putdocx table tableau9(2,1)=("Localisation cancéreuse                 "), append halign(left) bold font(Arial,7,black)
  putdocx table tableau9(2,2)=("Total décès (hommes)"), append halign(left) bold
  putdocx table tableau9(2,3)=("Décès/an (hommes)"), append halign(left) bold
  putdocx table tableau9(2,4)=("Taux brut"), append halign(left) bold
  putdocx table tableau9(2,5)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau9(2,6)=("IC95%         "), append halign(left) bold
  putdocx table tableau9(2,7)=(" "), append halign(left) bold
  putdocx table tableau9(2,8)=("Total décès (femmes)"), append halign(left) bold
  putdocx table tableau9(2,9)=("Décès/an (femmes)"), append halign(left) bold
  putdocx table tableau9(2,10)=("Taux brut"), append halign(left) bold
  putdocx table tableau9(2,11)=("Taux standardisé"), append halign(left) bold
  putdocx table tableau9(2,12)=("IC95%         "), append halign(left) bold
  *putdocx table tableau1(1,.), drop 
      
	*ALIGNEMENTS  
  putdocx table tableau9(.,2),   halign(right)
  putdocx table tableau9(.,3),   halign(right)
  putdocx table tableau9(.,4),   halign(right)
  putdocx table tableau9(.,5),   halign(right)
  putdocx table tableau9(.,6),   halign(right)
  putdocx table tableau9(.,7),   halign(right)
  putdocx table tableau9(.,8),   halign(right)
  putdocx table tableau9(.,9),   halign(right)
  putdocx table tableau9(.,10),  halign(right)
  putdocx table tableau9(.,11),  halign(right)
  putdocx table tableau9(.,12),  halign(right) 
  
  
  
  putdocx table tableau9(2,.), border(top)
  putdocx table tableau9(2,.), border(bottom)
  putdocx table tableau9(15,.), border(top)
  putdocx table tableau9(15,.), border(bottom)
  putdocx table tableau9(15,.), bold

  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux brut : taux pour 100 000 personnes/an"), italic 
   putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux standardisé : taux pour 100 000 personnes/an, standardisation européenne"), italic 


 putdocx save tableau3_9_TI_TM_PAR_LOCALISATION, replace
 
 
 *---------------------------------------------------------------------------------------------------------------------------------------------------
 ************************************************************PAR TRANCHE AGE ET LOCALISATIONS
*---------------------------------------------------------------------------------------------------------------------------------------------------

* INCIDENCE

use "8_Tableau_nbcas_clage_periode.dta", clear
destring indic_num,replace
sort loc3num
putdocx clear
putdocx begin, pagenum(decimal)  header(eve_header) font(arial,7,black) landscape pagesize(A4) /// footer(evefooter) 
margin(left,1.5cm) ///
margin(right,1.5cm)


 putdocx table hdr = (1, 3), border(all, nil) toheader(eve_header)
 putdocx table hdr(1, 1) = ("Le Cancer dans le Canton de Genève")
 putdocx table hdr(1, 2) = ("2020-2021"), halign(center)
 
* Incidence par année sur la période 2020-2021 - codé periode=2022
 putdocx table tableau10 = data(loc3num Total nbcasmoy nbcas0 nbcas5 nbcas10 nbcas15 nbcas20 nbcas25 nbcas30 nbcas35 nbcas40 nbcas45 nbcas50 nbcas55 nbcas60 nbcas65 nbcas70 nbcas75 nbcas80 nbcas85  ) if sexe==1 & indic_num==1 & cat==1 & adiag=="Période", title("Tableau 10 : Nombre de cas incidents invasifs chez les hommes par tranche d'âge et localisation cancéreuse sur le canton de Genève pour la période [2020-2021]")  ///
 layout(autofitcontents)   border(all, nil) 
 *border(top) ///
 *border(bottom)
  putdocx table tableau10(1,.), addrows(1)
  putdocx table tableau10(2,1)=("Localisation cancéreuse                 "), append halign(left) bold font(arial,7,black)
  putdocx table tableau10(2,2)=("Total cas"), append halign(left) bold
  putdocx table tableau10(2,3)=("Cas/an"), append halign(left) bold
  putdocx table tableau10(2,4)=("<5"), append halign(left) bold
  putdocx table tableau10(2,5)=("5-9"), append halign(left) bold
  putdocx table tableau10(2,6)=("10-14"), append halign(left) bold
  putdocx table tableau10(2,7)=("15-19"), append halign(left) bold
  putdocx table tableau10(2,8)=("20-24"), append halign(left) bold
  putdocx table tableau10(2,9)=("25-29"), append halign(left) bold
  putdocx table tableau10(2,10)=("30-34"), append halign(left) bold
  putdocx table tableau10(2,11)=("35-39"), append halign(left) bold
  putdocx table tableau10(2,12)=("40-44"), append halign(left) bold
  putdocx table tableau10(2,13)=("45-49"), append halign(left) bold
  putdocx table tableau10(2,14)=("50-54"), append halign(left) bold
  putdocx table tableau10(2,15)=("55-59"), append halign(left) bold
  putdocx table tableau10(2,16)=("60-64"), append halign(left) bold
  putdocx table tableau10(2,17)=("65-69"), append halign(left) bold
  putdocx table tableau10(2,18)=("70-74"), append halign(left) bold
  putdocx table tableau10(2,19)=("75-79"), append halign(left) bold
  putdocx table tableau10(2,20)=("80-84"), append halign(left) bold
  putdocx table tableau10(2,21)=("85+"), append halign(left) bold
  
 
*ALIGNEMENTS  
  putdocx table tableau10(.,2),   halign(right)
  putdocx table tableau10(.,3),   halign(right)
  putdocx table tableau10(.,4),   halign(right)
  putdocx table tableau10(.,5),    halign(right)
  putdocx table tableau10(.,6),   halign(right)
  putdocx table tableau10(.,7),   halign(right)
  putdocx table tableau10(.,8),   halign(right)
  putdocx table tableau10(.,9),   halign(right)
  putdocx table tableau10(.,10),  halign(right)
  putdocx table tableau10(.,11),  halign(right)
  putdocx table tableau10(.,12),  halign(right) 
  putdocx table tableau10(.,13),  halign(right) 
  putdocx table tableau10(.,14),  halign(right)
  putdocx table tableau10(.,15),  halign(right)
  putdocx table tableau10(.,16),  halign(right)
  putdocx table tableau10(.,17),  halign(right)
  putdocx table tableau10(.,18),  halign(right)
  putdocx table tableau10(.,19),  halign(right)
  putdocx table tableau10(.,20),  halign(right)
  putdocx table tableau10(.,21),  halign(right)

 
  putdocx table tableau10(2,.), border(top)
  putdocx table tableau10(2,.), border(bottom)
  putdocx table tableau10(38,.), border(top)
  putdocx table tableau10(38,.), border(bottom)
  putdocx table tableau10(38,.), bold
  putdocx table tableau10(39,.), border(top)
  putdocx table tableau10(39,.), border(bottom)
  putdocx table tableau10(39,.), bold
  
  
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Autres* : C30,C31,C37,C39,C46,C48,C51,C52,C58,C60,C63,C69,C74,C76,C77,C86,C88"), italic 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("LMNH : Lymphome malin non Hodgkinien"), italic 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux brut : taux pour 100 000 personnes/an"), italic 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux standardisé : taux pour 100 000 personnes/an, standardisation européenne"), italic 
  
  

putdocx pagebreak
 
  
* putdocx save tableau_5_NBCAS_PAR_TRANCHE_AGE_ET_LOCALISATION_hommes, replace
 
 
* Incidence par année sur la période 2020-2021 
 putdocx table tableau11 = data(loc3num Total nbcasmoy nbcas0 nbcas5 nbcas10 nbcas15 nbcas20 nbcas25 nbcas30 nbcas35 nbcas40 nbcas45 nbcas50 nbcas55 nbcas60 nbcas65 nbcas70 nbcas75 nbcas80 nbcas85  ) if sexe==2 & indic_num==1 & cat==1 & adiag=="Période", title("Tableau 11 : Nombre de cas incidents invasifs chez les femmes par tranche d'âge et localisation cancéreuse sur le canton de Genève pour la période [2020-2021]")  ///
 layout(autofitcontents)   border(all, nil) 
 *border(top) ///
 *border(bottom)
  putdocx table tableau11(1,.), addrows(1)
  putdocx table tableau11(2,1)=("Localisation cancéreuse                 "), append halign(left) bold font(arial,7,black)
  putdocx table tableau11(2,2)=("Total cas"), append halign(left) bold
  putdocx table tableau11(2,3)=("Cas/an"), append halign(left) bold
  putdocx table tableau11(2,4)=("<5"), append halign(left) bold
  putdocx table tableau11(2,5)=("5-9"), append halign(left) bold
  putdocx table tableau11(2,6)=("10-14"), append halign(left) bold
  putdocx table tableau11(2,7)=("15-19"), append halign(left) bold
  putdocx table tableau11(2,8)=("20-24"), append halign(left) bold
  putdocx table tableau11(2,9)=("25-29"), append halign(left) bold
  putdocx table tableau11(2,10)=("30-34"), append halign(left) bold
  putdocx table tableau11(2,11)=("35-39"), append halign(left) bold
  putdocx table tableau11(2,12)=("40-44"), append halign(left) bold
  putdocx table tableau11(2,13)=("45-49"), append halign(left) bold
  putdocx table tableau11(2,14)=("50-54"), append halign(left) bold
  putdocx table tableau11(2,15)=("55-59"), append halign(left) bold
  putdocx table tableau11(2,16)=("60-64"), append halign(left) bold
  putdocx table tableau11(2,17)=("65-69"), append halign(left) bold
  putdocx table tableau11(2,18)=("70-74"), append halign(left) bold
  putdocx table tableau11(2,19)=("75-79"), append halign(left) bold
  putdocx table tableau11(2,20)=("80-84"), append halign(left) bold
  putdocx table tableau11(2,21)=("85+"), append halign(left) bold
  
 
*ALIGNEMENTS  
  putdocx table tableau11(.,2),   halign(right)
  putdocx table tableau11(.,3),   halign(right)
  putdocx table tableau11(.,4),   halign(right)
  putdocx table tableau11(.,5),    halign(right)
  putdocx table tableau11(.,6),   halign(right)
  putdocx table tableau11(.,7),   halign(right)
  putdocx table tableau11(.,8),   halign(right)
  putdocx table tableau11(.,9),   halign(right)
  putdocx table tableau11(.,10),  halign(right)
  putdocx table tableau11(.,11),  halign(right)
  putdocx table tableau11(.,12),  halign(right) 
  putdocx table tableau11(.,13),  halign(right) 
  putdocx table tableau11(.,14),  halign(right)
  putdocx table tableau11(.,15),  halign(right)
  putdocx table tableau11(.,16),  halign(right)
  putdocx table tableau11(.,17),  halign(right)
  putdocx table tableau11(.,18),  halign(right)
  putdocx table tableau11(.,19),  halign(right)
  putdocx table tableau11(.,20),  halign(right)
  putdocx table tableau11(.,21),  halign(right)

 
  putdocx table tableau11(2,.), border(top)
  putdocx table tableau11(2,.), border(bottom)
  putdocx table tableau11(38,.), border(top)
  putdocx table tableau11(38,.), border(bottom)
  putdocx table tableau11(38,.), bold
  putdocx table tableau11(39,.), border(top)
  putdocx table tableau11(39,.), border(bottom)
  putdocx table tableau11(39,.), bold
  
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Autres* : C30,C31,C37,C39,C46,C48,C51,C52,C58,C60,C63,C69,C74,C76,C77,C86,C88"), italic 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("LMNH : Lymphome malin non Hodgkinien"), italic 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux brut : taux pour 100 000 personnes/an"), italic 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux standardisé : taux pour 100 000 personnes/an, standardisation européenne"), italic 
  
   
 putdocx save tableaux_10_11_NBCAS_INCIDENTS_PAR_TRANCHE_AGE_ET_LOCALISATION, replace
 
 
putdocx clear
putdocx begin, pagenum(decimal) header(eve_header) font(arial,7,black) landscape pagesize(A4) ///
margin(left,1.5cm) ///
margin(right,1.5cm)


 putdocx table hdr = (1, 3), border(all, nil) toheader(eve_header)
 putdocx table hdr(1, 1) = ("Le Cancer dans le Canton de Genève")
 putdocx table hdr(1, 2) = ("2020-2021"), halign(center)
 
* MORTALITE par CLASSE AGE sur la période 2020-2021 CHEZ LES HOMMES
 putdocx table tableau12 = data(loc3num Total nbcasmoy nbcas0 nbcas5 nbcas10 nbcas15 nbcas20 nbcas25 nbcas30 nbcas35 nbcas40 nbcas45 nbcas50 nbcas55 nbcas60 nbcas65 nbcas70 nbcas75 nbcas80 nbcas85  ) if sexe==1 & indic_num==2 & cat==1 & adiag=="Période", title("Tableau 12 : Nombre de cas décès par cancer invasifs chez les hommes par tranche d'âge et localisation cancéreuse sur le canton de Genève pour la période [2020-2021]")  ///
 layout(autofitcontents)   border(all, nil) 
 *border(top) ///
 *border(bottom)
  putdocx table tableau12(1,.), addrows(1)
  putdocx table tableau12(2,1)=("Localisation cancéreuse                 "), append halign(left) bold font(arial,7,black)
  putdocx table tableau12(2,2)=("Total décès"), append halign(left) bold
  putdocx table tableau12(2,3)=("Décès/an"), append halign(left) bold
  putdocx table tableau12(2,4)=("<5"), append halign(left) bold
  putdocx table tableau12(2,5)=("5-9"), append halign(left) bold
  putdocx table tableau12(2,6)=("10-14"), append halign(left) bold
  putdocx table tableau12(2,7)=("15-19"), append halign(left) bold
  putdocx table tableau12(2,8)=("20-24"), append halign(left) bold
  putdocx table tableau12(2,9)=("25-29"), append halign(left) bold
  putdocx table tableau12(2,10)=("30-34"), append halign(left) bold
  putdocx table tableau12(2,11)=("35-39"), append halign(left) bold
  putdocx table tableau12(2,12)=("40-44"), append halign(left) bold
  putdocx table tableau12(2,13)=("45-49"), append halign(left) bold
  putdocx table tableau12(2,14)=("50-54"), append halign(left) bold
  putdocx table tableau12(2,15)=("55-59"), append halign(left) bold
  putdocx table tableau12(2,16)=("60-64"), append halign(left) bold
  putdocx table tableau12(2,17)=("65-69"), append halign(left) bold
  putdocx table tableau12(2,18)=("70-74"), append halign(left) bold
  putdocx table tableau12(2,19)=("75-79"), append halign(left) bold
  putdocx table tableau12(2,20)=("80-84"), append halign(left) bold
  putdocx table tableau12(2,21)=("85+"), append halign(left) bold
  
 
*ALIGNEMENTS  
  putdocx table tableau12(.,2),   halign(right)
  putdocx table tableau12(.,3),   halign(right)
  putdocx table tableau12(.,4),   halign(right)
  putdocx table tableau12(.,5),    halign(right)
  putdocx table tableau12(.,6),   halign(right)
  putdocx table tableau12(.,7),   halign(right)
  putdocx table tableau12(.,8),   halign(right)
  putdocx table tableau12(.,9),   halign(right)
  putdocx table tableau12(.,10),  halign(right)
  putdocx table tableau12(.,11),  halign(right)
  putdocx table tableau12(.,12),  halign(right) 
  putdocx table tableau12(.,13),  halign(right) 
  putdocx table tableau12(.,14),  halign(right)
  putdocx table tableau12(.,15),  halign(right)
  putdocx table tableau12(.,16),  halign(right)
  putdocx table tableau12(.,17),  halign(right)
  putdocx table tableau12(.,18),  halign(right)
  putdocx table tableau12(.,19),  halign(right)
  putdocx table tableau12(.,20),  halign(right)
  putdocx table tableau12(.,21),  halign(right)

 
  putdocx table tableau12(2,.), border(top)
  putdocx table tableau12(2,.), border(bottom)
  putdocx table tableau12(37,.), border(top)
  putdocx table tableau12(37,.), border(bottom)
  putdocx table tableau12(37,.), bold
  putdocx table tableau12(38,.), border(top)
  putdocx table tableau12(38,.), border(bottom)
  putdocx table tableau12(38,.), bold
  
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Autres* : C30,C31,C37,C39,C46,C48,C51,C52,C58,C60,C63,C69,C74,C76,C77,C78,C79,C86,C88"), italic 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("LMNH : Lymphome malin non Hodgkinien"), italic 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux brut : taux pour 100 000 personnes/an"), italic 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux standardisé : taux pour 100 000 personnes/an, standardisation européenne"), italic 

    

putdocx pagebreak
 
  /*
 putdocx table hdr = (1, 3), border(all, nil) toheader(eve_header)
 putdocx table hdr(1, 1) = ("Le Cancer dans le Canton de Genève")
 putdocx table hdr(1, 2) = ("2020-2021"), halign(center)
 */
 
* MORTALITE par CLASSE AGE sur la période 2020-2021 CHEZ LES FEMMES
 putdocx table tableau13 = data(loc3num Total nbcasmoy nbcas0 nbcas5 nbcas10 nbcas15 nbcas20 nbcas25 nbcas30 nbcas35 nbcas40 nbcas45 nbcas50 nbcas55 nbcas60 nbcas65 nbcas70 nbcas75 nbcas80 nbcas85  ) if sexe==2 & indic_num==2 & cat==1 & adiag=="Période", title("Tableau 12 : Nombre de décès par cancer invasifs chez les femmes par tranche d'âge et localisation cancéreuse sur le canton de Genève pour la période [2020-2021]")  ///
 layout(autofitcontents)   border(all, nil) 
 *border(top) ///
 *border(bottom)
  putdocx table tableau13(1,.), addrows(1)
  putdocx table tableau13(2,1)=("Localisation cancéreuse                 "), append halign(left) bold font(arial,7,black)
  putdocx table tableau13(2,2)=("Total décès"), append halign(left) bold
  putdocx table tableau13(2,3)=("Décès/an"), append halign(left) bold
  putdocx table tableau13(2,4)=("<5"), append halign(left) bold
  putdocx table tableau13(2,5)=("5-9"), append halign(left) bold
  putdocx table tableau13(2,6)=("10-14"), append halign(left) bold
  putdocx table tableau13(2,7)=("15-19"), append halign(left) bold
  putdocx table tableau13(2,8)=("20-24"), append halign(left) bold
  putdocx table tableau13(2,9)=("25-29"), append halign(left) bold
  putdocx table tableau13(2,10)=("30-34"), append halign(left) bold
  putdocx table tableau13(2,11)=("35-39"), append halign(left) bold
  putdocx table tableau13(2,12)=("40-44"), append halign(left) bold
  putdocx table tableau13(2,13)=("45-49"), append halign(left) bold
  putdocx table tableau13(2,14)=("50-54"), append halign(left) bold
  putdocx table tableau13(2,15)=("55-59"), append halign(left) bold
  putdocx table tableau13(2,16)=("60-64"), append halign(left) bold
  putdocx table tableau13(2,17)=("65-69"), append halign(left) bold
  putdocx table tableau13(2,18)=("70-74"), append halign(left) bold
  putdocx table tableau13(2,19)=("75-79"), append halign(left) bold
  putdocx table tableau13(2,20)=("80-84"), append halign(left) bold
  putdocx table tableau13(2,21)=("85+"), append halign(left) bold
  
 
*ALIGNEMENTS  
  putdocx table tableau13(.,2),   halign(right)
  putdocx table tableau13(.,3),   halign(right)
  putdocx table tableau13(.,4),   halign(right)
  putdocx table tableau13(.,5),    halign(right)
  putdocx table tableau13(.,6),   halign(right)
  putdocx table tableau13(.,7),   halign(right)
  putdocx table tableau13(.,8),   halign(right)
  putdocx table tableau13(.,9),   halign(right)
  putdocx table tableau13(.,10),  halign(right)
  putdocx table tableau13(.,11),  halign(right)
  putdocx table tableau13(.,12),  halign(right) 
  putdocx table tableau13(.,13),  halign(right) 
  putdocx table tableau13(.,14),  halign(right)
  putdocx table tableau13(.,15),  halign(right)
  putdocx table tableau13(.,16),  halign(right)
  putdocx table tableau13(.,17),  halign(right)
  putdocx table tableau13(.,18),  halign(right)
  putdocx table tableau13(.,19),  halign(right)
  putdocx table tableau13(.,20),  halign(right)
  putdocx table tableau13(.,21),  halign(right)

 
  putdocx table tableau13(2,.), border(top)
  putdocx table tableau13(2,.), border(bottom)

  putdocx table tableau13(37,.), border(top)
  putdocx table tableau13(37,.), border(bottom)
  putdocx table tableau13(37,.), bold
  putdocx table tableau13(38,.), border(top)
  putdocx table tableau13(38,.), border(bottom)
  putdocx table tableau13(38,.), bold
  
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Autres* : C30,C31,C37,C39,C46,C48,C51,C52,C58,C60,C63,C69,C74,C76,C77,C86,C88"), italic 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("LMNH : Lymphome malin non Hodgkinien"), italic 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux brut : taux pour 100 000 personnes/an"), italic 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 
  putdocx text ("Taux standardisé : taux pour 100 000 personnes/an, standardisation européenne"), italic 
  
 putdocx save tableaux_12_13_NB_DC_PAR_TRANCHE_AGE_ET_LOCALISATION, replace
 
* FUSION DE TOUS LES TABLEAUX AVEC LA PAGE DE GARDE

 /*
putdocx append  tableau1_2_TI_TM_Total tableau3_9_TI_TM_PAR_LOCALISATION , pagebreak pgnumrestart saving(Partie_1_taux_incid,replace) headsrc(own)   stylesrc(own) 
putdocx append tableau_5_NBCAS_PAR_TRANCHE_AGE_ET_LOCALISATION_hommes tableau_6_NBCAS_PAR_TRANCHE_AGE_ET_LOCALISATION_femmes , pagebreak  saving(Partie_2_cas_par_tranche_age,replace) headsrc(own)  stylesrc(own) // pgnumrestart
putdocx append tableau_7_NB_DC_PAR_TRANCHE_AGE_ET_LOCALISATION_hommes tableau_8_NB_DC_PAR_TRANCHE_AGE_ET_LOCALISATION_femmes , pagebreak  saving(Partie_3_DC_par_tranche_age,replace) headsrc(own)  stylesrc(own)  // pgnumrestart
*/

 putdocx append tableau_1_2_TI_TM_Total1 Graphiques_pour_tableau_1_2_TI_TM_Total, saving(tableau_1_2_TI_TM_Total2, replace)  pagebreak headsrc(own) stylesrc(own) 
 
 
putdocx append  Page_garde  tableau_1_2_TI_TM_Total tableau3_9_TI_TM_PAR_LOCALISATION  tableaux_10_11_NBCAS_INCIDENTS_PAR_TRANCHE_AGE_ET_LOCALISATION tableaux_12_13_NB_DC_PAR_TRANCHE_AGE_ET_LOCALISATION, pagebreak  saving(Tableaux_finaux,replace) headsrc(own) stylesrc(own) //    pgnumrestart

 * fait la modif des <20 gris à la main
 *Page_garde.docx
 