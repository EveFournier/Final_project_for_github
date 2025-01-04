
****************NE PAS UTILISER A ETE INTEGRE AU DOCUMENT 10

 * Graphiques par sexe
**# Bookmark #2
 
 
 
* Répertoire 0û vont se trouve les fichiers intermédiaires
cd "C:\INCIDENCE_RGT\DONNEES\"
  * des graphiques par année pour illustrer
  
  * INCIDENCE 
use  "3_base_registre_def.dta", clear
numlabel, remove
 drop if cim10def=="C44"
 
 
quietly tab cat 
local nbcas_cat=`r(N)'/2

contract cat adiag
rename _freq nbcas
collapse (sum) nbcas,by(cat)
replace nbcas=nbcas/2

graph bar (asis) nbcas, over(cat) bar(1, fcolor(dknavy) lcolor(none)) blabel(bar, size(medium) format(%9.1f)) ytitle("Nombre moyen annuel de cas")   caption(Nombre moyen annuel=`nbcas_cat' cas, size(*0.75)) 
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

graph bar (asis) nbcas, over(cat) bar(1, fcolor(cranberry) lcolor(none)) blabel(bar, size(medium) format(%9.1f)) ytitle("Nombre moyen annuel de décès")   caption(Nombre moyen annuel=`nbcas_cat' cas, size(*0.75))  ylabel(0(200)1000)
graph export "Gr2_Behavior_morta.emf", replace

   
  
putdocx begin, pagenum(decimal)  header(eve_header) font(arial,7,black) pagesize(A4) ///
margin(left,1.5cm) ///
margin(right,1.5cm) //footer(evefooter) 

 
  putdocx paragraph , font(arial,6,black) spacing(after,0.01) spacing(before,0.01) 

 putdocx table hdr = (1, 3), border(all, nil) toheader(eve_header)
 putdocx table hdr(1, 1) = ("Le Cancer dans le Canton de Genève")
 putdocx table hdr(1, 2) = ("2020-2021"), halign(center)
putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 
putdocx text ("Figure 1 : Nombre de nouvelles tumeurs recensées en 2020 et 2021 selon le comportement tumoral"), bold
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
 