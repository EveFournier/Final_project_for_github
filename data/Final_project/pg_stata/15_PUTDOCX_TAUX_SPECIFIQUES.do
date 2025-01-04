


* Répertoire 0û vont se trouve les fichiers intermédiaires
local donnees="C:\INCIDENCE_RGT\DONNEES\"

cd `donnees'


* --- MISE EN COMMUN DE CES GRAPHIQUES	
	

putdocx clear
putdocx begin, pagenum(decimal) header(eve_header) font(arial,7,black)  pagesize(A4) // format paysage  footer(evefooter) 


 putdocx table hdr = (1, 3), border(all, nil) toheader(eve_header)
 putdocx table hdr(1, 1) = ("Le Cancer dans le canton de Genève")
 putdocx table hdr(1, 2) = ("2020-2021"), halign(center)
 

putdocx paragraph , spacing(after,0.01) 

 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 10 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl5 = (1,2), border(all,nil) // note("Figure 5 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl5(1,1)=image(11_TOUSCANCERS_Gr_taux_spe.emf)
 putdocx table tbl5(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl5(1,2)=image(12_TOUSCANCERS_Gr_taux_spe.emf)
 putdocx table tbl5(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl5(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
 
 
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 11 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer des Lèvres-Bouche-Pharynx par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table  tbl6 = (1,2), border(all,nil) // note("Figure 6 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer des Lèvres-Bouche-Pharynx par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl6(1,1)=image(21_LBP_Gr_taux_spe.emf)
 putdocx table tbl6(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl6(1,2)=image(22_LBP_Gr_taux_spe.emf)
 putdocx table tbl6(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl6(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
 
 
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 12 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de l'oesophage par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table tbl7 = (1,2), border(all,nil) // note("Figure 7 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de l'oesophage par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl7(1,1)=image(31_Oesophage_Gr_taux_spe.emf)
 putdocx table tbl7(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl7(1,2)=image(32_Oesophage_Gr_taux_spe.emf)
 putdocx table tbl7(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl7(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
 
   putdocx pagebreak
   
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 13 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de l'estomac par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table tbl8 = (1,2), border(all,nil) // note("Figure 8 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de l'estomac par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl8(1,1)=image(41_Estomac_Gr_taux_spe.emf)
 putdocx table tbl8(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl8(1,2)=image(42_Estomac_Gr_taux_spe.emf)
 putdocx table tbl8(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl8(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
 
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 14 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de l'intestin grêle par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table tbl9 = (1,2), border(all,nil) // note("Figure 9 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de l'intestin grêle par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl9(1,1)=image(51_Intestin_grele_Gr_taux_spe.emf)
 putdocx table tbl9(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl9(1,2)=image(52_Intestin_grele_Gr_taux_spe.emf)
 putdocx table tbl9(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl9(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
 
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 15 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du côlon et du rectum par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table tbl10 = (1,2), border(all,nil) // note("Figure 10 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du côlon et du rectum par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl10(1,1)=image(61_CR_Gr_taux_spe.emf)
 putdocx table tbl10(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl10(1,2)=image(62_CR_Gr_taux_spe.emf)
 putdocx table tbl10(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl10(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
 
   putdocx pagebreak
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 16 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de l'anus par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 
 putdocx table tbl11 = (1,2), border(all,nil) // note("Figure 11 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de l'anus par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl11(1,1)=image(71_Anus_taux_spe.emf)
 putdocx table tbl11(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl11(1,2)=image(72_Anus_taux_spe.emf)
 putdocx table tbl11(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl11(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
 
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 17 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du foie par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 
 putdocx table tbl12 = (1,2), border(all,nil) // note("Figure 12 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du foie par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl12(1,1)=image(81_Foie_taux_spe.emf)
 putdocx table tbl12(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl12(1,2)=image(82_Foie_taux_spe.emf)
 putdocx table tbl12(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl12(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 18 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de la vésicule biliaire par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
  
 putdocx table tbl13 = (1,2), border(all,nil) // note("Figure 13 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de la vésicule biliaire par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl13(1,1)=image(91_Vesicule_taux_spe.emf)
 putdocx table tbl13(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl13(1,2)=image(92_Vesicule_taux_spe.emf)
 putdocx table tbl13(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl13(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
 
   putdocx pagebreak
   
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 19 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du pancréas par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
  
 putdocx table tbl14 = (1,2), border(all,nil) // note("Figure 14 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du pancréas par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl14(1,1)=image(101_Pancreas_taux_spe.emf)
 putdocx table tbl14(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl14(1,2)=image(102_Pancreas_taux_spe.emf)
 putdocx table tbl14(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl14(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
  
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 20 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du larynx par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table tbl15 = (1,2), border(all,nil) // note("Figure 15 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du larynx par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl15(1,1)=image(111_Larynx_taux_spe.emf)
 putdocx table tbl15(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl15(1,2)=image(112_Larynx_taux_spe.emf)
 putdocx table tbl15(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl15(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
  
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 21 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du poumon par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
  
 putdocx table tbl16 = (1,2), border(all,nil) // note("Figure 16 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du poumon par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl16(1,1)=image(121_Poumon_taux_spe.emf)
 putdocx table tbl16(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl16(1,2)=image(122_Poumon_taux_spe.emf)
 putdocx table tbl16(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl16(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   

  * j'avais dupoliqué les poumons la chronologie saute, tant pis
     
   putdocx pagebreak
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 22 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de la plèvre par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table tbl19 = (1,2), border(all,nil) // note("Figure 17 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de la plèvre par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl19(1,1)=image(131_Plevre_taux_spe.emf)
 putdocx table tbl19(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl19(1,2)=image(132_Plevre_taux_spe.emf)
 putdocx table tbl19(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl19(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
  
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 23 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer des os par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table tbl20 = (1,2), border(all,nil) // note("Figure 18 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer des os par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl20(1,1)=image(141_Os_taux_spe.emf)
 putdocx table tbl20(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl20(1,2)=image(142_Os_taux_spe.emf)
 putdocx table tbl20(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl20(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
 
   putdocx pagebreak
   
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 24 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de type mélanome par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 
 putdocx table tbl21 = (1,2), border(all,nil) // note("Figure 19 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de type mélanome par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl21(1,1)=image(151_Melanome_taux_spe.emf)
 putdocx table tbl21(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl21(1,2)=image(152_Melanome_taux_spe.emf)
 putdocx table tbl21(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl21(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
     
   
    
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 25 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de la peau hors mélanome par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 
 putdocx table tbl201 = (1,2), border(all,nil) // note("Figure 19 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de type mélanome par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl201(1,1)=image(1551_Peau_Autre_taux_spe.emf)
 putdocx table tbl201(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl201(1,2)=image(1552_Peau_Autre_taux_spe.emf)
 putdocx table tbl201(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl21(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
      
   
   putdocx pagebreak
   
      
   
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 26 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer des tissus mous par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 
 putdocx table tbl22 = (1,2), border(all,nil) // note("Figure 20 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer des tissus mous par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl22(1,1)=image(161_Tissus_Mous_taux_spe.emf)
 putdocx table tbl22(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl22(1,2)=image(162_Tissus_Mous_taux_spe.emf)
 putdocx table tbl22(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl22(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 27 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du sein par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
  
 putdocx table tbl23 = (1,2), border(all,nil) // note("Figure 21 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du sein par âge dans le canton de Genève [2020-2021]") halign(center) 
 *putdocx table tbl23(1,1)=image(171_Sein_taux_spe.emf)
 *putdocx table tbl23(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl23(1,2)=image(172_Sein_taux_spe.emf)
 putdocx table tbl23(1,2)=("          "), append halign(center)
 *putdocx table tbl23(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
  
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 28 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du col de l'utérus par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table tbl24 = (1,2), border(all,nil) // note("Figure 22 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du col de l'utérus par âge dans le canton de Genève [2020-2021]") halign(center) 
 *putdocx table tbl24(1,1)=image()
 *putdocx table tbl24(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl24(1,2)=image(182_Col_uterus_taux_spe.emf)
 putdocx table tbl24(1,2)=("          "), append halign(center)
 *putdocx table tbl24(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
     
   putdocx pagebreak
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 29 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du corps de l'utérus par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
  
 putdocx table tbl25 = (1,2), border(all,nil) note("Figure 23 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du corps de l'utérus par âge dans le canton de Genève [2020-2021]") halign(center) 
*putdocx table tbl25(1,1)=image()
 *putdocx table tbl25(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl25(1,2)=image(192_Corps_uterus_taux_spe.emf)
 putdocx table tbl25(1,2)=("          "), append halign(center)
 *putdocx table tbl25(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
  
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 30 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer des ovaires et annexes par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
 putdocx table tbl26 = (1,2), border(all,nil) // note("Figure 24 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer des Ovaires et annexes par âge dans le canton de Genève [2020-2021]") halign(center) 
 *putdocx table tbl26(1,1)=image()
 *putdocx table tbl26(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl26(1,2)=image(202_Ovaire_taux_spe.emf)
 putdocx table tbl26(1,2)=("          "), append halign(center)
 *putdocx table tbl26(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
 
   putdocx pagebreak
   
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 31 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de la prostate par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
  
 putdocx table tbl27 = (1,2), border(all,nil) // note("Figure 25 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de la prostate par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl27(1,1)=image(211_Prostate_taux_spe.emf)
 putdocx table tbl27(1,1)=("          "), append halign(center)
 *putdocx table tbl27(1,2)=image()
 putdocx table tbl27(1,2)=("          "), append halign(center) 
 *putdocx table tbl27(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
 
     
   
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 32 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer des testicules par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
 
  
 putdocx table tbl28 = (1,2), border(all,nil) // note("Figure 26 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer des testicules par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl28(1,1)=image(221_Testicules_taux_spe.emf)
 putdocx table tbl28(1,1)=("          "), append halign(center)
 *putdocx table tbl28(1,2)=image()
 putdocx table tbl28(1,2)=("          "), append halign(center)
 *putdocx table tbl28(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
 
   putdocx pagebreak
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 33 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du rein par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
  
 putdocx table tbl29 = (1,2), border(all,nil) // note("Figure 27 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du rein et des voies urinaires par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl29(1,1)=image(231_Rein_taux_spe.emf)
 putdocx table tbl29(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl29(1,2)=image(232_Rein_taux_spe.emf)
 putdocx table tbl29(1,2)=("(b) Femmes"), append halign(center)
 * putdocx table tbl29(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
   
   putdocx pagebreak
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 34 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer des voies urinaires par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
  
 putdocx table tbl292 = (1,2), border(all,nil) 
 putdocx table tbl292(1,1)=image(2331_Voix_Urinaires_taux_spe.emf)
 putdocx table tbl292(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl292(1,2)=image(2332_Voix_Urinaires_taux_spe.emf)
 putdocx table tbl292(1,2)=("(b) Femmes"), append halign(center)
   
 
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 35 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer des voies urinaires par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
  
 putdocx table tbl30 = (1,2), border(all,nil) // note("Figure 28 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de la vessie par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl30(1,1)=image(2331_Voix_Urinaires_taux_spe.emf)
 putdocx table tbl30(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl30(1,2)=image(2332_Voix_Urinaires_taux_spe.emf)
 putdocx table tbl30(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl30(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
     
   putdocx pagebreak
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 36 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du système nerveux central par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
  
 putdocx table tbl31 = (1,2), border(all,nil) // note("Figure 29 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer du système nerveux central par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl31(1,1)=image(251_SNC_taux_spe.emf)
 putdocx table tbl31(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl31(1,2)=image(252_SNC_taux_spe.emf)
 putdocx table tbl31(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl31(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 37 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de la thyroïde par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
  
 putdocx table tbl32 = (1,2), border(all,nil) // note("Figure 30 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de la thyroïde par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl32(1,1)=image(261_Thyroide_taux_spe.emf)
 putdocx table tbl32(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl32(1,2)=image(262_Thyroide_taux_spe.emf)
 putdocx table tbl32(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl32(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
 
     
   putdocx pagebreak
   
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 38 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de type Maladie de Hodgkin par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
  
 putdocx table tbl33 = (1,2), border(all,nil) // note("Figure 31 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de type Maladie de Hodgkin par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl33(1,1)=image(271_Hodgkin_taux_spe.emf)
 putdocx table tbl33(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl33(1,2)=image(272_Hodgkin_taux_spe.emf)
 putdocx table tbl33(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl33(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 39 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de type Lymphome malin non Hodgkinien par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
  
 putdocx table tbl34 = (1,2), border(all,nil) // note("Figure 32 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de type Lymphome malin non Hodgkinien par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl34(1,1)=image(281_LMNH_taux_spe.emf)
 putdocx table tbl34(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl34(1,2)=image(282_LMNH_taux_spe.emf)
 putdocx table tbl34(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl34(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
 
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 40 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de type myélome multiple par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   

   
 putdocx table tbl35 = (1,2), border(all,nil) note("Figure 33 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de type myélome multiple par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl35(1,1)=image(291_Myelome_Multiple_taux_spe.emf)
 putdocx table tbl35(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl35(1,2)=image(292_Myelome_Multiple_taux_spe.emf)
 putdocx table tbl35(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl35(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
   
       
   putdocx pagebreak
   
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 41 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de type leucémie lymphoide par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
  
 putdocx table tbl36 = (1,2), border(all,nil) // note("Figure 34 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de type leucémie lymphoide par âge dans le canton de Genève [2020-2021]") halign(center) 
 putdocx table tbl36(1,1)=image(301_Leucemie_Lymphoide_taux_spe.emf)
 putdocx table tbl36(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl36(1,2)=image(302_Leucemie_Lymphoide_taux_spe.emf)
 putdocx table tbl36(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl36(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
 
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)  
 putdocx text ("Figure 42 : Taux spécifiques d'incidence et de mortalité et nombre annuel de cas et décès par cancer de type leucémie myéloïde par âge dans le canton de Genève [2020-2021]"), bold
 putdocx paragraph ,  spacing(before,0.02)  spacing(after,0.02)   
  
 putdocx table tbl37 = (1,2), border(all,nil) 
 putdocx table tbl37(1,1)=image(311_Leucemie_Myeloide_taux_spe.emf)
 putdocx table tbl37(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl37(1,2)=image(312_Leucemie_Myeloide_taux_spe.emf)
 putdocx table tbl37(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl37(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
   
     
   
 putdocx save Graphique3, replace







 putdocx append Graphique1 Graphique2 Graphique3 , pagebreak  saving(graphiques, replace) headsrc(own)   stylesrc(own) 

putdocx append Tableaux_finaux 	graphiques	 , pagebreak pgnumrestart saving(Fichier_Final,replace) headsrc(own)   stylesrc(own) // à voir le calcul des pages, commence dès la page de garde



