* se trouve maintenant dans 11



* Répertoire 0û vont se trouve les fichiers intermédiaires
local donnees="C:\INCIDENCE_RGT\DONNEES\"

cd `donnees'


* ON VA LANCER LES GRAPHIQUES

* EVOLUTION DES TAUX D'INCIDENCE PAR LOCALISATION



*diagramme en bar des principales localisations cancéreuses
**# INVASIFS

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
	

putdocx clear
putdocx begin, pagenum(decimal)  header(eve_header) font(arial,7,black)  pagesize(A4) // format paysage

 putdocx table hdr = (1, 3), border(all, nil) toheader(eve_header)
 putdocx table hdr(1, 1) = ("Le Cancer dans le Canton de Genève")
 putdocx table hdr(1, 2) = ("2020-2021"), halign(center)
 


putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 
putdocx text ("Figure 4 : Taux standardisés d'incidence des cancers invasifs dans le canton de Genève pour la période 2020-2021"), bold
putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 

 putdocx table  tbl14 = (1,2), border(all,nil) // note("Figure 1 : Taux standardisés d'incidence par cancer dans le canton de Genève, tous âges confondus pour la période 2016-2020") halign(center) 
 putdocx table tbl14(1,1)=image(Gr1_hommes_11_principales_localisations_incidentes_invasives.emf)
 *putdocx table tbl5(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl14(1,2)=image(Gr2_femmes_11_principales_localisations_incidentes_invasives.emf)
 *putdocx table tbl5(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl5(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
 
 
/*
putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 
putdocx text ("Figure 5 : Taux standardisés d'incidence par cancer in-situ dans le canton de Genève, tous âges confondus pour la période 2020-2021"), bold
putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 

 putdocx table  tbl15 = (1,2), border(all,nil) // note("Figure 1 : Taux standardisés d'incidence par cancer dans le canton de Genève, tous âges confondus pour la période 2016-2020") halign(center) 
 putdocx table tbl15(1,1)=image(Gr3_hommes_11_principales_localisations_incidentes_IN_SITU.emf)
 *putdocx table tbl5(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl15(1,2)=image(Gr4_femmes_11_principales_localisations_incidentes_IN_SITU.emf)
 *putdocx table tbl5(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl5(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
 
 
 

putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 
putdocx text ("Figure 6 : Taux standardisés d'incidence par cancer bénins dans le canton de Genève, tous âges confondus pour la période 2020-2021"), bold
putdocx paragraph , spacing(before,0.02)  spacing(after,0.02) 

 putdocx table  tbl16 = (1,2), border(all,nil) // note("Figure 1 : Taux standardisés d'incidence par cancer dans le canton de Genève, tous âges confondus pour la période 2016-2020") halign(center) 
 putdocx table tbl16(1,1)=image(Gr5_hommes_11_principales_localisations_incidentes_benins.emf)
 *putdocx table tbl5(1,1)=("(a) Hommes"), append halign(center)
 putdocx table tbl16(1,2)=image(Gr6_femmes_11_principales_localisations_incidentes_benins.emf)
 *putdocx table tbl5(1,2)=("(b) Femmes"), append halign(center)
 *putdocx table tbl5(2,.), halign(center) bold // format the last row, ici la note rajoutée en option en ligne 1
 
 */
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
  

 putdocx save Graphique1, replace
 