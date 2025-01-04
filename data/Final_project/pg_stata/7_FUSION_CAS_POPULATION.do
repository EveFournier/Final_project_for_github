

*FUSION DES CAS ET DE LA POPULATION
* 4 incidence POUR TOUTES LES LOCALISATIONS



local donnees="C:\INCIDENCE_RGT\DONNEES\"

cd `donnees'


use pop_1981_2021.dta, clear

keep if adiag>=2020 & adiag<=2021
tabstat pop, stat(sum)
/*
    Variable |       Sum
-------------+----------
         pop |   1013131
------------------------
*/

tab adiag
sort sexe adiag clage
tab adiag
save pop.dta, replace

/*
list in 1/10

     +--------------------------------+
     | adiag   sexe   clage       pop |
     |--------------------------------|
  1. |  2016      1       0      1296 |
  2. |  2016      1       1     10737 |
  3. |  2016      1       5     12994 |
  4. |  2016      1      10   12641.5 |
  5. |  2016      1      15   13517.5 |
     |--------------------------------|
  6. |  2016      1      20     14819 |
  7. |  2016      1      25     16623 |
  8. |  2016      1      30     17747 |
  9. |  2016      1      35     18389 |
 10. |  2016      1      40     18485 |
     +--------------------------------+

	 */

 
use  "5_nbcas_incident_et_morta.dta", clear
sort sexe adiag clage 
merge sexe adiag clage  using pop.dta
tab _merge // que des 3, pb sinon
/*
   

     _merge |      Freq.     Percent        Cum.
------------+-----------------------------------
          3 |      9,728      100.00      100.00
------------+-----------------------------------
      Total |      9,728      100.00




	  */
drop _merge
tabstat nbcas pop if loc3num==1000, by(indic) stat(sum)

/*
  indic |     nbcas       pop
-----------+--------------------
 Incidence |      5367   1013131
 Mortalité |      1738   1013131
-----------+--------------------
     Total |      7105   2026262
--------------------------------

*/
save "6_nbcas_incident_et_morta_pop.dta",replace




