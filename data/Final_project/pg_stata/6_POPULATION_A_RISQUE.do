
* PREPARATION DU FICHIER DE POPULATION


* on part du fichier de Robin 21/04/2023
/*
fichier pop
   +------------------------------+
     | sexe   adiag   clage     pop |
     |------------------------------|
  1. |    1    1980       0    1723 |
  2. |    1    1980       1    6902 |
  3. |    1    1980       5    9840 |
  4. |    1    1980      10   11011 |
  5. |    1    1980      15   12263 |
     |------------------------------|
  6. |    1    1980      20   12153 |
  7. |    1    1980      25   11909 |
  8. |    1    1980      30   14057 |
  9. |    1    1980      35   15362 |
 10. |    1    1980      40   13525 |
     +------------------------------+

	 */

import delimited "C:\INCIDENCE_RGT\POP\2023_02_24_Extraction.csv", clear
tab cant
*keep if cant==25 // GE
drop cant
rename année adiag
gen pop=( effectifau1erjanvier+ effectifau31décembre)/2
drop effectifau1erjanvier effectifau31décembre

replace age=subinstr(age," ans","",(.))
replace age=subinstr(age," an","",(.))
replace age="99" if age=="99 ou plus"
tab age
drop if age=="Age - total"
drop if sex=="Sexe - total"

replace sexe="1" if sexe=="Homme"
replace sexe="2" if sexe=="Femme"

destring age sexe, replace

egen clage=cut(age),at(0,1,5(5)85,150)
*rename sex sexe
tab sex
*drop if age==999
*drop if sexe==3
collapse (sum) pop, by(sexe adiag clage)

tab adiag sexe
sort sexe adiag clage 
save "pop_1981_2021.dta",replace

