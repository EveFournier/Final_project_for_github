

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

 putdocx textblock begin
Les figures 2 et 3 illustrent la distribution des cas incidents ou des décès selon le sexe.

putdocx textblock end
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
   
 
 
**# Bookmark #1
   *----------------------------------------------------------------------FIGURES 4 ET 5 DES TAUX D'INCIDENCE
   * initialement dans 11_GRAPHIQUES_1_2_graph_bar_incid_morta.do
  

* Invasifs

use "TI_TM_Geneve_Final.dta", clear
tab loc3num,m
keep if adiag=="[2020-2021]"
keep if cat==1
keep if loc3num!=1000 & loc3num!=1001
drop if loc3num==440 // peau autre
drop if loc3num==998
drop if loc3num==999

keep indic nbcas* taux_std* loc3*
destring taux_std*, replace force
reshape long nbcas taux_std, i(indic loc3 loc3num) j(sexe)
gen indic2=1 if indic=="Incidence"
replace indic2=2 if indic=="Mortalité"
drop indic
drop if nbcas==.
reshape wide nbcas taux_std,i(sexe loc3 loc3num) j(indic2)   

gsort sexe   -nbcas1 loc3num
by sexe   : gen rang_nbcas1=_n
by sexe   : gen rang_nbcas2=_n
gsort sexe   -taux_std1 loc3num
by sexe   : gen rang_taux_std1=_n
by sexe   : gen rang_taux_std2=_n
drop if nbcas1==.
gen nl=_n
reshape long nbcas taux_std rang_nbcas rang_taux_std, i(nl) j(indic2)
drop nl

replace nbcas=round(nbcas/2)

gen indic="Incidence" if indic2==1
replace indic="Mortalité" if indic2==2

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
820	"LMNH"	 ///
880	"Myélome multiple"	 ///
910	"Leucémie lymphoïde"	 ///
920	"Leucémie myéloïde"	 ///
930	"Leucémie SAI"	 ///
998	"Autres*"	 ///
999	"Site primitif inconnu" ///
1000 "Total invasifs" ///
1001 "Total invasifs avec C44" ///
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
label val loc3num loc3num
save  "1_graphique_nb_cas_incidents_mortalite_cas_invasifs.dta",replace



use  "1_graphique_nb_cas_incidents_mortalite_cas_invasifs.dta", clear

gen indic3=indic
replace indic3="Taux d'incidence" if indic=="Incidence"
replace indic3="Taux de mortalité" if indic=="Mortalité"


save  "1_graphique_nb_cas_incidents_mortalite_cas_invasifs.dta",replace


use  "1_graphique_nb_cas_incidents_mortalite_cas_invasifs.dta", clear

* INCIDENCE
graph hbar  (asis) taux_std if sexe==1 & indic2==1 & rang_nbcas<12,  over(loc3num, sort(1) descending )  ///
	 bar(1, fcolor(dknavy) lcolor(dknavy)) ///
     bar(2, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(3, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(4, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(5, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(6, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(7, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(8, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(9, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(10, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(11, fcolor(dknavy) lcolor(dknavy)) ///
	 blabel(bar, format(%9.1f) size(medsmall)) 	 ///
	 ylabel(0(50)150, grid glcolor(ltblue)) ymtick(0(25)150, nolabels grid noticks)	 ///
	 ytitle("Taux pour 100 000 PA") 	 ///
	 graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white) lwidth(large)) ///
	 title(Incidence Hommes, size(medlarge) color(black) position(11) orientation(horizontal))
    graph export "Gr1_hommes_11_principales_localisations_incidentes_invasives.emf", replace
	
	graph hbar  (asis) taux_std if sexe==2 & indic2==1 & rang_nbcas<12,  over(loc3num, sort(1) descending )  ///
	 bar(1, fcolor(cranberry) lcolor(cranberry)) ///
     bar(2, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(3, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(4, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(5, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(6, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(7, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(8, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(9, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(10, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(11, fcolor(cranberry) lcolor(cranberry)) ///
	 blabel(bar, format(%9.1f) size(medsmall)) 	 ///
	 ylabel(0(50)150, grid glcolor(ltblue)) ymtick(0(25)150, nolabels grid noticks)	 ///
	 ytitle("Taux pour 100 000 PA") 	 ///
	 graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white) lwidth(large)) ///
	 title(Incidence Femmes, size(medlarge) color(black) position(11) orientation(horizontal))
    graph export "Gr2_femmes_11_principales_localisations_incidentes_invasives.emf", replace

	* MORTALITE
	graph hbar  (asis) taux_std if sexe==1 & indic2==2 & rang_nbcas<12,  over(loc3num, sort(1) descending )  ///
	 bar(1, fcolor(dknavy) lcolor(dknavy)) ///
     bar(2, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(3, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(4, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(5, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(6, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(7, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(8, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(9, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(10, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(11, fcolor(dknavy) lcolor(dknavy)) ///
	 blabel(bar, format(%9.1f) size(medsmall)) 	 ///
	 ylabel(0(10)50, grid glcolor(ltblue)) ymtick(0(5)50, nolabels grid noticks)	 ///
	 ytitle("Taux pour 100 000 PA") 	 ///
	 graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white) lwidth(large)) ///
	 title(Mortalité Hommes, size(medlarge) color(black) position(11) orientation(horizontal))
    graph export "Gr1b_hommes_11_principales_localisations_mortalite_invasives.emf", replace
	
graph hbar  (asis) taux_std if sexe==2 & indic2==2 & rang_nbcas<12,  over(loc3num, sort(1) descending )  ///
	 bar(1, fcolor(cranberry) lcolor(cranberry)) ///
     bar(2, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(3, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(4, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(5, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(6, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(7, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(8, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(9, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(10, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(11, fcolor(cranberry) lcolor(cranberry)) ///
	 blabel(bar, format(%9.1f) size(medsmall)) 	 ///
	 ylabel(0(10)50, grid glcolor(ltblue)) ymtick(0(5)50, nolabels grid noticks)	 ///
	 ytitle("Taux pour 100 000 PA") 	 ///
	 graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white) lwidth(large)) ///
	 title(Mortalité Femmes, size(medlarge) color(black) position(11) orientation(horizontal))
    graph export "Gr2b_femmes_11_principales_localisations_mortalite_invasives_invasives.emf", replace
	
	
	
	*https://gco.iarc.fr/today/data/factsheets/populations/756-switzerland-fact-sheets.pdf
	
	
**# IN SITU

use "TI_TM_Geneve_Final.dta", clear
tab loc3num,m
keep if adiag=="[2020-2021]"
keep if cat==2
drop if loc3num==2099 | loc3num==2009

keep indic nbcas* taux_std* loc3*
destring taux_std*, replace force
reshape long nbcas taux_std, i(indic loc3 loc3num) j(sexe)
gen indic2=1 if indic=="Incidence"
replace indic2=2 if indic=="Mortalité"
drop indic
drop if nbcas==.
reshape wide nbcas taux_std,i(sexe loc3 loc3num) j(indic2)   

gsort sexe   -nbcas1 loc3num
by sexe   : gen rang_nbcas1=_n
by sexe   : gen rang_nbcas2=_n
gsort sexe   -taux_std1 loc3num
by sexe   : gen rang_taux_std1=_n
by sexe   : gen rang_taux_std2=_n
drop if nbcas1==.
gen nl=_n
reshape long nbcas taux_std rang_nbcas rang_taux_std, i(nl) j(indic2)
drop nl

replace nbcas=round(nbcas/2)

gen indic="Incidence" if indic2==1
replace indic="Mortalité" if indic2==2

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
820	"LMNH"	 ///
880	"Myélome multiple"	 ///
910	"Leucémie lymphoïde"	 ///
920	"Leucémie myéloïde"	 ///
930	"Leucémie SAI"	 ///
998	"Autres*"	 ///
999	"Site primitif inconnu" ///
1000 "Total invasifs" ///
1001 "Total invasifs avec C44" ///
2000	"Bouche, œsophage, estomac"	 ///
2001	"Organes digestifs"	 ///
2002	"Oreille, appareil respiratoire"	 ///
2003	"Mélanome"	 ///
2004	"Peau"	 ///
2005	"Sein"	 ///
2006	"Col de l'utérus"	 ///
2007	"Organes génitaux"	 ///
2009	"Sièges autres et non précisés"	 ///
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
label val loc3num loc3num
save  "3_graphique_nb_cas_incidents_mortalite_cas_IN_SITU.dta",replace



use  "3_graphique_nb_cas_incidents_mortalite_cas_IN_SITU.dta", clear

gen indic3=indic
replace indic3="Taux d'incidence" if indic=="Incidence"
replace indic3="Taux de mortalité" if indic=="Mortalité"

save  "3_graphique_nb_cas_incidents_mortalite_cas_IN_SITU.dta",replace


use  "3_graphique_nb_cas_incidents_mortalite_cas_IN_SITU.dta", clear

* INCIDENCE
graph hbar  (asis) taux_std if sexe==1 & indic2==1 & rang_nbcas<12,  over(loc3num, sort(1) descending )  ///
	 bar(1, fcolor(dknavy) lcolor(dknavy)) ///
     bar(2, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(3, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(4, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(5, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(6, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(7, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(8, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(9, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(10, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(11, fcolor(dknavy) lcolor(dknavy)) ///
	 blabel(bar, format(%9.1f) size(medsmall)) 	 ///
	 ylabel(0(50)100, grid glcolor(ltblue)) ymtick(0(25)100, nolabels grid noticks)	 ///
	 ytitle("Taux pour 100 000 PA") 	 ///
	 graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white) lwidth(large)) ///
	 title(Incidence in-situ hommes, size(medlarge) color(black) position(11) orientation(horizontal))
    graph export "Gr3_hommes_11_principales_localisations_incidentes_IN_SITU.emf", replace
	
	graph hbar  (asis) taux_std if sexe==2 & indic2==1 & rang_nbcas<12,  over(loc3num, sort(1) descending )  ///
	 bar(1, fcolor(cranberry) lcolor(cranberry)) ///
     bar(2, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(3, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(4, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(5, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(6, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(7, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(8, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(9, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(10, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(11, fcolor(cranberry) lcolor(cranberry)) ///
	 blabel(bar, format(%9.1f) size(medsmall)) 	 ///
	 ylabel(0(50)100, grid glcolor(ltblue)) ymtick(0(25)100, nolabels grid noticks)	 ///
	 ytitle("Taux pour 100 000 PA") 	 ///
	 graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white) lwidth(large)) ///
	 title(Incidence in-situ femmes, size(medlarge) color(black) position(11) orientation(horizontal))
    graph export "Gr4_femmes_11_principales_localisations_incidentes_IN_SITU.emf", replace
/*
	* MORTALITE
	PAS DE DECES PAR CANCER IN SITU
	*/
	
	
	
**# CAS BENINS
	
	
	
	
use "TI_TM_Geneve_Final.dta", clear
tab loc3num,m
keep if adiag=="[2020-2021]"
keep if cat==3
drop if loc3num==3099 |loc3num== 3036

keep indic nbcas* taux_std* loc3*
destring taux_std*, replace force
reshape long nbcas taux_std, i(indic loc3 loc3num) j(sexe)
gen indic2=1 if indic=="Incidence"
replace indic2=2 if indic=="Mortalité"
drop indic
drop if nbcas==.
reshape wide nbcas taux_std,i(sexe loc3 loc3num) j(indic2)   

gsort sexe   -nbcas1 loc3num
by sexe   : gen rang_nbcas1=_n
by sexe   : gen rang_nbcas2=_n
gsort sexe   -taux_std1 loc3num
by sexe   : gen rang_taux_std1=_n
by sexe   : gen rang_taux_std2=_n
drop if nbcas1==.
gen nl=_n
reshape long nbcas taux_std rang_nbcas rang_taux_std, i(nl) j(indic2)
drop nl

replace nbcas=round(nbcas/2)

gen indic="Incidence" if indic2==1
replace indic="Mortalité" if indic2==2

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
820	"LMNH"	 ///
880	"Myélome multiple"	 ///
910	"Leucémie lymphoïde"	 ///
920	"Leucémie myéloïde"	 ///
930	"Leucémie SAI"	 ///
998	"Autres*"	 ///
999	"Site primitif inconnu" ///
1000 "Total invasifs" ///
1001 "Total invasifs avec C44" ///
2000	"Bouche, œsophage, estomac"	 ///
2001	"Organes digestifs"	 ///
2002	"Oreille, appareil respiratoire"	 ///
2003	"Mélanome"	 ///
2004	"Peau"	 ///
2005	"Sein"	 ///
2006	"Col de l'utérus"	 ///
2007	"Organes génitaux"	 ///
2009	"Sièges autres et non précisés"	 ///
3010	"Bouche et du pharynx"	 ///
3011	"Glandes salivaires principales"	 ///
3012	"Côlon, rectum, anus, canal anal"	 ///
3013	"Appareil digestif autre"	 ///
3014	"Oreille, appareil respiratoire"	 ///
3015	"Organes intrathoraciques"	 ///
3016	"Os et cartilage"	 ///
3017	"Tumeur lipomateuse"	 ///
3018	"Hémangiome et lymphangiome"	 ///
3019	"Tissu mésothélial"	 ///
3020	"Tissus mous du rétropéritoine et du péritoine"	 ///
3021	"Tissu conjonctif, autres tissus mous"	 ///
3022	"Nævus à mélanocytes"	 ///
3023	"Autres tumeurs bénignes de la peau"	 ///
3024	"Sein"	 ///
3025	"Léiomyome de l'utérus"	 ///
3026	"Autres tumeurs bénignes de l'utérus"	 ///
3027	"Ovaire"	 ///
3028	"Organes génitaux"	 /// femmes
3029	"Organes génitaux"	 /// hommes
3030	"Organes urinaires"	 ///
3031	"Oeil et ses annexes"	 ///
3032	"Méninges"	 ///
3033	"Encéphale et SNC"	 ///
3034	"Thyroïde"	 ///
3035	"Glandes endocrines, autres"	 ///
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
label val loc3num loc3num
save  "4_graphique_nb_cas_incidents_mortalite_cas_benin.dta",replace



use  "4_graphique_nb_cas_incidents_mortalite_cas_benin.dta", clear

gen indic3=indic
replace indic3="Taux d'incidence" if indic=="Incidence"
replace indic3="Taux de mortalité" if indic=="Mortalité"

save  "4_graphique_nb_cas_incidents_mortalite_cas_benins.dta",replace


use  "4_graphique_nb_cas_incidents_mortalite_cas_benins.dta", clear

* INCIDENCE
graph hbar  (asis) taux_std if sexe==1 & indic2==1 & rang_nbcas<12,  over(loc3num, sort(1) descending )  ///
	 bar(1, fcolor(dknavy) lcolor(dknavy)) ///
     bar(2, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(3, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(4, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(5, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(6, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(7, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(8, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(9, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(10, fcolor(dknavy) lcolor(dknavy)) ///
	 bar(11, fcolor(dknavy) lcolor(dknavy)) ///
	 blabel(bar, format(%9.1f) size(medsmall)) 	 ///
	 ylabel(0(2)20, grid glcolor(ltblue)) ymtick(0(2)20, nolabels grid noticks)	 ///
	 ytitle("Taux pour 100 000 PA") 	 ///
	 graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white) lwidth(large)) ///
	 title(Incidence tumeurs bénignes hommes, size(medlarge) color(black) position(11) orientation(horizontal))
    graph export "Gr5_hommes_11_principales_localisations_incidentes_benins.emf", replace
	
	graph hbar  (asis) taux_std if sexe==2 & indic2==1 & rang_nbcas<12,  over(loc3num, sort(1) descending )  ///
	 bar(1, fcolor(cranberry) lcolor(cranberry)) ///
     bar(2, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(3, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(4, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(5, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(6, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(7, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(8, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(9, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(10, fcolor(cranberry) lcolor(cranberry)) ///
	 bar(11, fcolor(cranberry) lcolor(cranberry)) ///
	 blabel(bar, format(%9.1f) size(medsmall)) 	 ///
	 ylabel(0(2)20, grid glcolor(ltblue)) ymtick(0(2)20, nolabels grid noticks)	 ///
	 ytitle("Taux pour 100 000 PA") 	 ///
	 graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white) lwidth(large)) ///
	 title(Incidence tumeurs bénignes femmes, size(medlarge) color(black) position(11) orientation(horizontal))
    graph export "Gr6_femmes_11_principales_localisations_incidentes_benins.emf", replace
/*
	* MORTALITE
	PAS DE DECES PAR CANCER IN SITU
	rincipales_localisations_mortalite_invasives_IN_SITU.emf", replace
	
	*/
	
	
	
	

* --- MISE EN COMMUN DE CES PREMIERS GRAPHIQUES	
	

 
putdocx textblock begin
Les figures 4 et 5 illustrent les taux standardisés d'incidence et de mortalité pour la période 2020-2021 dans le canton de Genève, pour les 11 principales localisations (classées selon le taux standardisé).
putdocx textblock end


putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 
putdocx text ("Figure 4 : Taux standardisés d'incidence des cancers invasifs dans le canton de Genève pour la période 2020-2021"), bold
putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 

 putdocx table  tbl14 = (1,2), border(all,nil) // note("Figure 1 : Taux standardisés d'incidence par cancer dans le canton de Genève, tous âges confondus pour la période 2016-2020") halign(center) 
 putdocx table tbl14(1,1)=image(Gr1_hommes_11_principales_localisations_incidentes_invasives.emf)
 *putdocx table tbl5(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl14(1,2)=image(Gr2_femmes_11_principales_localisations_incidentes_invasives.emf)
 *putdocx table tbl5(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl5(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
  
putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 
putdocx text ("Figure 5 : Taux standardisés de mortalité par cancer invasifs dans le canton de Genève pour la période 2020-2021"), bold
putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 

 putdocx table  tbl17 = (1,2), border(all,nil) // note("Figure 2 : Taux standardisés de mortalité par cancer dans le canton de Genève, tous âges confondus pour la période 2016-2020") halign(center) 
 putdocx table   tbl17(1,1)=image(Gr1b_hommes_11_principales_localisations_mortalite_invasives.emf)
 *putdocx table tbl5(1,1)=("(a) Hommes"), append halign(center)
 putdocx table   tbl17(1,2)=image(Gr2b_femmes_11_principales_localisations_mortalite_invasives_invasives.emf)
 *putdocx table tbl5(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl6(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
 
 
*putdocx paragraph, font(arial,6,black)  spacing(before,0.01)  spacing(after,0.1)  indent(left,0.8)
*putdocx text ("Tous âges confondus") , italic
  



  putdocx save Graphiques_1_4, replace
 
  
  putdocx append Intro Graphiques_1_4, saving(Partie1, replace)  pagebreak headsrc(own) stylesrc(own) 








 