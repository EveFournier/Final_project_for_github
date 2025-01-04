

* Répertoire 0û vont se trouve les fichiers intermédiaires
cd "C:\INCIDENCE_RGT\DONNEES\"




use  "22_taux_incidence_morta_par_periode.dta", clear





putdocx clear
putdocx begin, pagenum(decimal) header(eve_header) font(arial,7,black)  pagesize(A4) // format paysage  footer(evefooter) 


 putdocx table hdr = (1, 3), border(all, nil) toheader(eve_header)
 putdocx table hdr(1, 1) = ("Le Cancer dans le canton de Genève")
 putdocx table hdr(1, 2) = ("2020-2021"), halign(center)
 

putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 44 : Evolution des taux standardisés d'incidence et de mortalité par cancer invasifs dans le canton de Genève [1971-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl5 = (1,1), border(all,nil) // note("Figure 5 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl5(1,1)=image(Gr50_Evolution_toutes_localisations.emf)
   
   
   putdocx pagebreak
   

putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 45 : Evolution des taux standardisés d'incidence et de mortalité par cancer des lèvres-bouche-pharynx dans le canton de Genève [1971-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl6 = (1,1), border(all,nil)  
 putdocx table tbl6(1,1)=image(Gr51_Evolution_LBP.emf)
 
 

putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 46 : Evolution des taux standardisés d'incidence et de mortalité par cancer de l'estomac dans le canton de Genève [1971-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl7 = (1,1), border(all,nil) 
 putdocx table tbl7(1,1)=image(Gr52_Evolution_Estomac.emf)
 
 
   putdocx pagebreak
   
 
putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 47 : Evolution des taux standardisés d'incidence et de mortalité par cancer colo-rectal dans le canton de Genève [1971-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl8 = (1,1), border(all,nil) 
 putdocx table tbl8(1,1)=image(Gr53_Evolution_CRC.emf)
 
 
 
 
putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 48 : Evolution des taux standardisés d'incidence et de mortalité par cancer du foie dans le canton de Genève [1971-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl9 = (1,1), border(all,nil) 
 putdocx table tbl9(1,1)=image(Gr54_Evolution_Foie.emf)
 
 
   putdocx pagebreak
   
 
putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 49 : Evolution des taux standardisés d'incidence et de mortalité par cancer du pancréas dans le canton de Genève [1971-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl10 = (1,1), border(all,nil) 
 putdocx table tbl10(1,1)=image(Gr55_Evolution_Pancreas.emf)
 
putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 50 : Evolution des taux standardisés d'incidence et de mortalité par cancer du poumon dans le canton de Genève [1971-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl11 = (1,1), border(all,nil) 
 putdocx table tbl11(1,1)=image(Gr56_Evolution_Poumon.emf)
 
   putdocx pagebreak
   
 
putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 51 : Evolution des taux standardisés d'incidence et de mortalité par cancer du poumon dans le canton de Genève [1971-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl12 = (1,1), border(all,nil) 
 putdocx table tbl12(1,1)=image(Gr57_Evolution_Melanome.emf)
 
putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 52 : Evolution des taux standardisés d'incidence et de mortalité par cancer du sein dans le canton de Genève [1971-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl13 = (1,1), border(all,nil) 
 putdocx table tbl13(1,1)=image(Gr58_Evolution_Sein.emf)
 
 
   putdocx pagebreak
   
putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 53 : Evolution des taux standardisés d'incidence et de mortalité par cancer du corps de l'utérus dans le canton de Genève [1971-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl14 = (1,1), border(all,nil) 
 putdocx table tbl14(1,1)=image(Gr59_Evolution_Corps_uterus.emf)
 
 
 
putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 54 : Evolution des taux standardisés d'incidence et de mortalité par cancer de la prostate dans le canton de Genève [1971-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl15 = (1,1), border(all,nil) 
 putdocx table tbl15(1,1)=image(Gr60_Evolution_Prostate.emf)
 
   putdocx pagebreak
   
   
   
 
putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 55 : Evolution des taux standardisés d'incidence et de mortalité par cancer du rein dans le canton de Genève [1971-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl16 = (1,1), border(all,nil) 
 putdocx table tbl16(1,1)=image(Gr61_Evolution_Rein.emf)
 
 
putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 56 : Evolution des taux standardisés d'incidence et de mortalité par cancer de la vessie dans le canton de Genève [1971-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl17 = (1,1), border(all,nil) 
 putdocx table tbl17(1,1)=image(Gr62_Evolution_Vessie.emf)
 
 
 
   putdocx pagebreak
   
putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 57 : Evolution des taux standardisés d'incidence et de mortalité par cancer de la thyroide dans le canton de Genève [1971-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl18 = (1,1), border(all,nil) 
 putdocx table tbl18(1,1)=image(Gr63_Evolution_Thyroide.emf)
 
 
 
putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 58 : Evolution des taux standardisés d'incidence et de mortalité par Lymphome Malin Non Hodgkinien dans le canton de Genève [1971-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl19 = (1,1), border(all,nil) 
 putdocx table tbl19(1,1)=image(Gr64_Evolution_LMNH.emf)
 
 
 putdocx save Graphique5, replace




putdocx append Doc_Epidemio Graphique5	 , pagebreak pgnumrestart saving(Doc_Epidemio_20240620,replace) headsrc(own)   stylesrc(own) // à voir le calcul des pages, commence dès la page de garde



