* CE PG EST REALISE POUR LUCAS VALLOIS, JOURNALISTE lucas.vallois@emh.ch



use "3_base_registre_def.dta", clear
sort loc3
keep if loc3=="C18-C20"
save "C:\INCIDENCE_RGT\DONNEES\crc.dta", replace



use "C:\INCIDENCE_RGT\DONNEES\crc.dta", clear
sort clage
merge clage using clage
 contract   loc3 clage , zero
rename _freq nbcas
drop if loc3==""
tabstat nbcas, stat(sum)
save "crc_contract.dta",replace

use "3_morta_geneve.dta", clear
keep if loc3=="C18-C20"
sort clage
merge clage using clage
 contract   loc3 clage , zero
gen indic="Mortalité"
replace indic="Incidence" if indic==""
drop if loc3==""
rename _freq nbcas
tabstat nbcas, stat(sum)
di 204+193
save "C:\INCIDENCE_RGT\DONNEES\crc_morta_contrac.dta", replace
append using "crc_contract.dta"
replace indic="Incidence" if indic==""
tab indic
save "C:\INCIDENCE_RGT\DONNEES\crc_incid_morta_contrac.dta", replace



use pop_2016_2020.dta, clear
collapse (sum) pop, by(clage)
sort clage
save pop_collapse, replace
use crc_incid_morta_contrac.dta, clear
sort clage
merge clage using  pop_collapse
tab _merge
codebook clage
drop _merge
save "crc_incid_morta_contrac_avec_pop.dta",replace

distrate nbcas pop using "C:\INCIDENCE_RGT\POP\refeurope.dta", standstrata(clage)   by(indic)   ///
saving(C:\Temp\incidence_morta_crc.dta,replace) format(%8.2f) mult(100000) level(95)


use C:\Temp\incidence_morta_crc.dta, clear
save "incidence_morta_crc.dta", replace


rename N pop_risk
rename crude taux_brut
rename rateadj taux_std
rename lb_gam icmin
rename ub_gam icmax


order indic nbcas
label var nbcas "Nombre de cas"
label var pop_risk "Population à risque"
label var taux_brut "Taux brut"
label var taux_std "Taux Standardisé"
label var icmin  "IC 95% min"
label var icmax  "IC 95% max"

drop se_gam- ub_srr
save "incidence_morta_crc.dta", replace
