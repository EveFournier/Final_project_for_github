

* Répertoire 0û vont se trouve les fichiers intermédiaires
local donnees="C:\INCIDENCE_RGT\DONNEES\"

cd `donnees'

 
 *- ON MET LES GRAPHIQUES ENSEMBLES
  
putdocx clear
putdocx begin, pagenum(decimal) header(eve_header) font(arial,7,black)  pagesize(A4) // format paysage  footer(evefooter) 

 putdocx table hdr = (1, 3), border(all, nil) toheader(eve_header)
 putdocx table hdr(1, 1) = ("Le Cancer dans le Canton de Genève")
 putdocx table hdr(1, 2) = ("2020-2021"), halign(center)
 
  
  * graphies hommes et femmes et incidence et mortalité séparés
	
putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 
putdocx text ("Figure 6 : Répartition des principales localisations cancéreuses dans le canton de Genève, tous âges confondus pour la période 2020-2021"), bold
putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 

 putdocx table tbl9 = (2,2), border(all,nil) // note("Figure 3 : Répartition des principales localisations cancéreuses dans le canton de Genève, tous âges confondus pour la période 2020-2021") halign(center) 
 putdocx table tbl9(1,1)=image("Gr13_Pie_Chart_Incidence_Homme.emf")
 putdocx table tbl9(1,1)=("(a) Incidence hommes"), append halign(center)
 putdocx table tbl9(1,2)=image("Gr14_Pie_Chart_Mortalite_Homme.emf")
 putdocx table tbl9(1,2)=("(b) Mortalité hommes"), append halign(center)
 putdocx table tbl9(2,1)=image("Gr15_Pie_Chart_Incidence_Femme.emf")
 putdocx table tbl9(2,1)=("(c) Incidence femmes"), append halign(center)
 putdocx table tbl9(2,2)=image("Gr16_Pie_Chart_Mortalite_Femme.emf")
 putdocx table tbl9(2,2)=("(d) Mortalité femmes"), append halign(center)
 *putdocx table tbl9(3,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1

    putdocx pagebreak
	
  putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 7 : Répartition des principales localisations cancéreuses dans le canton de Genève, chez les 20-49 ans pour la période 2020-2021"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 
 
 putdocx table tbl11 = (2,2), border(all,nil) // note("Figure 4b : Répartition des principales localisations cancéreuses dans le canton de Genève, chez les 20-49 ans pour la période 2020-2021") halign(center) 
 putdocx table tbl11(1,1)=image("Gr21_Clage20_Pie_Chart_Incidence_Homme.emf")
 putdocx table tbl11(1,1)=("(a) Incidence hommes"), append halign(center)
 putdocx table tbl11(1,2)=image("Gr22_Clage20_Pie_Chart_Mortalite_Homme.emf")
 putdocx table tbl11(1,2)=("(b) Mortalité hommes"), append halign(center)
 putdocx table tbl11(2,1)=image("Gr23_Clage20_Pie_Chart_Incidence_Femme.emf")
 putdocx table tbl11(2,1)=("(c) Incidence femmes"), append halign(center)
 putdocx table tbl11(2,2)=image("Gr24_Clage20_Pie_Chart_Mortalite_Femme.emf")
 putdocx table tbl11(2,2)=("(d) Mortalité femmes"), append halign(center)
 *putdocx table tbl11(3,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
putdocx text ("N: nombre total de cas incidents ou de décès sur la période 2020-2021, pour la classe d'âge et le sexe considéré ")
 putdocx pagebreak

  putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 8 : Répartition des principales localisations cancéreuses dans le canton de Genève, chez les 50-74 ans pour la période 2020-2021"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
  putdocx table tbl12 = (2,2), border(all,nil) // note("Figure 4c : Répartition des principales localisations cancéreuses dans le canton de Genève, chez les 50-74 ans pour la période 2020-2021") halign(center) 
 putdocx table tbl12(1,1)=image("Gr25_Clage50_Pie_Chart_Incidence_Homme.emf")
 putdocx table tbl12(1,1)=("(a) Incidence hommes"), append halign(center)
 putdocx table tbl12(1,2)=image("Gr26_Clage50_Pie_Chart_Mortalite_Homme.emf")
 putdocx table tbl12(1,2)=("(b) Mortalité hommes"), append halign(center)
 putdocx table tbl12(2,1)=image("Gr27_Clage50_Pie_Chart_Incidence_Femme.emf")
 putdocx table tbl12(2,1)=("(c) Incidence femmes"), append halign(center)
 putdocx table tbl12(2,2)=image("Gr28_Clage50_Pie_Chart_Mortalite_Femme.emf")
 putdocx table tbl12(2,2)=("(d) Mortalité femmes"), append halign(center)
 *putdocx table tbl12(3,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
putdocx text ("N: nombre total de cas incidents ou de décès sur la période 2020-2021, pour la classe d'âge et le sexe considéré ")
 putdocx pagebreak
 
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 9 : Répartition des principales localisations cancéreuses dans le canton de Genève, chez les 75 ans et plus pour la période 2020-2021"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
  
 putdocx table tbl13 = (2,2), border(all,nil) // note("Figure 4d : Répartition des principales localisations cancéreuses dans le canton de Genève, chez les 75 ans et plus pour la période 2020-2021") halign(center) 
 putdocx table tbl13(1,1)=image("Gr29_Clage75_Pie_Chart_Incidence_Homme.emf")
 putdocx table tbl13(1,1)=("(a) Incidence hommes"), append halign(center)
 putdocx table tbl13(1,2)=image("Gr30_Clage75_Pie_Chart_Mortalite_Homme.emf")
 putdocx table tbl13(1,2)=("(b) Mortalité hommes"), append halign(center)
 putdocx table tbl13(2,1)=image("Gr31_Clage75_Pie_Chart_Incidence_Femme.emf")
 putdocx table tbl13(2,1)=("(c) Incidence femmes"), append halign(center)
 putdocx table tbl13(2,2)=image("Gr32_Clage75_Pie_Chart_Mortalite_Femme.emf")
 putdocx table tbl13(2,2)=("(d) Mortalité femmes"), append halign(center)
 *putdocx table tbl13(3,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1

  
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
putdocx text ("N: nombre total de cas incidents ou de décès sur la période 2020-2021, pour la classe d'âge et le sexe considéré ")
 
 putdocx save Graphique2, replace
 