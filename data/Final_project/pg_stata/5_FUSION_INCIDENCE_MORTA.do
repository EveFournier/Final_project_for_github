







local donnees="C:\INCIDENCE_RGT\DONNEES\"

cd `donnees'





use "4_contract_total_incident_avec_localisations_detaillees.dta", clear
append using "4_contract_total_mortalite_avec_localisations_detaillees.dta"


gen cat=1 if loc3num<=1001
replace cat=2 if loc3num>=2000 & loc3num<3000
replace cat=3 if loc3num>=3000 & loc3num<4000
replace cat=4 if loc3num>=4000 & loc3num<5000
label def cat 1 "Invasif" 2 "In-Situ" 3 "Bénin" 4 "Incertain"
label val cat cat




save "5_nbcas_incident_et_morta.dta",replace










tabstat nbcas if loc3num==1000 & indic_num==1, stat(sum) by(cat)

tabstat nbcas if loc3num<1000 & loc3num!=440  & indic_num==1, stat(sum) 


tabstat nbcas if loc3num==1000  , stat(sum)  by(indic)
  tabstat nbcas if loc3num==1001  , stat(sum)  by(indic)
 
/*
tab clage sexe if loc3num==1000,m

           |         SEXE
     clage |         1          2 |     Total
-----------+----------------------+----------
         0 |        10         10 |        20 
         1 |        10         10 |        20 
         5 |        10         10 |        20 
        10 |        10         10 |        20 
        15 |        10         10 |        20 
        20 |        10         10 |        20 
        25 |        10         10 |        20 
        30 |        10         10 |        20 
        35 |        10         10 |        20 
        40 |        10         10 |        20 
        45 |        10         10 |        20 
        50 |        10         10 |        20 
        55 |        10         10 |        20 
        60 |        10         10 |        20 
        65 |        10         10 |        20 
        70 |        10         10 |        20 
        75 |        10         10 |        20 
        80 |        10         10 |        20 
        85 |        10         10 |        20 
-----------+----------------------+----------
     Total |       190        190 |       380 

	 car 2 indicateurs
	 */
	 
	 