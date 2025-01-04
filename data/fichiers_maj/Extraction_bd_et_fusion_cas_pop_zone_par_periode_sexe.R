




```{r incidence_data_extraction, include = FALSE, warning = FALSE,  message=FALSE  }
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Extraction of tumor and patients characteristics from ODBC nicer_64 ----
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# I save all my file as csv and import them after because i want to be able to work from my laptop and I do't have access to our secured database outside the registry
# Connection to ODBC connector of Geneva Cancer Registry MySQL database


conn <- odbcConnect("nicer_64")

# ------------------------ Patient's characteristics load, clean and filtering ----
# MySQL select statement extracting patient table fields
a_patient <- "select pid, sexe as gender from a_patient"
patient_raw <- sqlQuery(conn, a_patient)

# Patient filtering : Only patients with known gender
patient <- patient_raw %>% 
  filter(gender==1 | gender==2) %>% 
  mutate(gender=as.factor(gender))
# Check
tabyl(patient,gender)

write_csv(patient, here("data/patient.csv"))


# ------------------------ Patient's place of residence load, clean and filtering ----
# MySQL select statement extracting patient table fields
a_pat_demo <- "select PID, GNR, CITY_ID from a_pat_demo"
a_pat_demo_raw <- sqlQuery(conn, a_pat_demo)

write_csv(a_pat_demo_raw, here("data/a_pat_demo.csv"))





# ------------------------ Tumor load, clean and filtering
# Only cases from 2016 to 2020
# Only GE canton resident (resident_status= GE)
# Only validated tumor (tum_status= 3)
# Only invasive cancers (beginning with C in icd10)
# Without non melanoma skin cancers C44
# Deletion of intermediate variables

# pid and tid are respectively patient and tumor ID

a_tumor <- "select pid,tid, incidence_age as age, incidence_year as year, icd10, resident_status, tum_status,INCIDENCE_CITY_ID from a_tumor"
tumor_raw <- sqlQuery(conn, a_tumor) %>% 
  mutate(year=as.integer(year),
         age=as.integer(age),
         pid=as.integer(pid),
         tid=as.integer(tid),
         tum_status=as.integer(tum_status))

tumor<- tumor_raw %>% 
  filter(year>=1971 & year<=2021 &
           resident_status=="GE" &
           tum_status==3) %>% 
  mutate(icd10 = substr(icd10,1,3),
         behavior=substr(icd10,1,1)) %>% 
  filter(behavior=="C") %>%
  filter(icd10!="C44") %>% 
  dplyr::select(pid, tid, age, year, icd10,INCIDENCE_CITY_ID)  # Explicitly call select() from dplyr
# ------------------------ Export tumor file to enable me to work on my lapt 
write_csv(tumor, here("data/tumor.csv"))

# Extraction of geographic information
cities_db <- "select id as INCIDENCE_CITY_ID, NPA, GNR, EXP, TEXT_FR  from cities"
cities <- sqlQuery(conn, cities_db)
write_csv(cities, here("data/cities.csv"))

# Close the ODBC connection when done fetching data
odbcClose(conn)


# import all files and create data frame
tumor<-read_csv(here("data/tumor.csv") , show_col_types = FALSE)
cities<-read_csv(here("data/cities.csv") , show_col_types = FALSE)
patient<-read_csv(here("data/patient.csv") , show_col_types = FALSE)

a_pat_demo<-read_csv(here("data/a_pat_demo.csv") , show_col_types = FALSE) %>% 
  rename_with(tolower) %>% 
  rename(gnr_pat=gnr) %>% 
  mutate(gnr_pat_rec = case_when(
    gnr_pat==6999 ~ 9999,
    is.na(gnr_pat) ~ 9999,
    TRUE ~ gnr_pat))


tum_cities<-left_join(tumor,cities,by=("INCIDENCE_CITY_ID")) %>%  
    dplyr::select(-NPA) %>% 
    rename_with(tolower) %>% 
    mutate(gnr_rec = case_when(
              gnr==6699 ~ 9999,
              is.na(gnr) ~ 9999,
              TRUE ~ gnr))

pat_tum_cities<-left_join(tum_cities,patient,by=("pid"))

pat_tum_cities_with_pat_gnr<-left_join(pat_tum_cities,a_pat_demo,by=("pid")) %>% 
  mutate(gnr_final=case_when(
            gnr_rec==9999 ~ gnr_pat_rec,
            TRUE~gnr_rec)) %>% 
  dplyr::select(-gnr_rec,-gnr_pat_rec)

#  dplyr::select(gnr, gnr_rec,gnr_pat,gnr_pat_rec,gnr_final)

# Define custom labels for each category
labels_age <- c("0 to 4", "5 to 9", "10 to 14", "15 to 19", "20 to 24", "25 to 29", "30 to 34", "35 to 39", "40 to 44", "45 to 49", "50 to 54", "55 to 59", "60 to 64", "65 to 69", "70 to 74", "75 to 79", "80 to 84", "85 and older")
#labels_periods<-
  
  
# Age category definition and label attribution
pat_tum_cities <- pat_tum_cities %>%
  mutate(age_category = cut(age, breaks = c(0, seq(5, 85, by = 5), 150), right = FALSE, labels = labels)) %>%   
mutate(gender=as.factor(gender),
       tumor_category="",
       tumor_category=case_when(
         icd10 %in% c("C00", "C01", "C02", "C03", "C04", "C05", "C06", "C07", "C08", "C09",
                      "C10", "C11", "C12", "C13", "C14") ~ "C00-C14",
         icd10 == "C15" ~ "C15",
         icd10 == "C16" ~ "C16",
         icd10 == "C17" ~ "C17",
         icd10 %in% c("C18","C19","C20") ~ "C18-C20",
         icd10 == "C21" ~ "C21",
         icd10 == "C22" ~ "C22",
         icd10  %in% c("C23","C24") ~ "C23,C24",
         icd10 == "C25" ~ "C25",
         icd10 == "C26" ~ "C26,C80",
         icd10 == "C32" ~ "C32",
         icd10  %in% c("C33","C34") ~ "C33-C34",
         icd10 == "C38" ~ "C38,C45",
         icd10  %in% c("C40","C41") ~ "C40,C41",
         icd10 == "C43" ~ "C43",
         icd10 == "C45" ~ "C38,C45",
         icd10  %in% c("C47","C49") ~ "C47,C49",
         icd10 == "C50" ~ "C50",
         icd10 == "C53" ~ "C53",
         icd10 %in% c("C54", "C55") ~ "C54,C55",
         icd10 %in% c("C56", "C57") ~ "C56,C57",
         icd10 == "C61" ~ "C61",
         icd10 == "C62" ~ "C62",
         icd10 %in% c("C64") ~ "C64",
         icd10 %in% c("C65", "C66", "C68") ~ "C65-C66,C68",
         icd10 == "C67" ~ "C67",
         icd10 %in% c("C70", "C71", "C72") ~ "C70-C72",
         icd10 == "C73" ~ "C73",
         icd10 == "C80" ~ "C26,C80",
         icd10 == "C81" ~ "C81",
         icd10  %in% c("C82", "C83", "C84","C85","C96") ~ "C82-85, C96",
         icd10 == "C90" ~ "C90",
         icd10 == "C91" ~ "C91",
         icd10 == "C92" ~ "C92",
         icd10  %in% c("C93","C94","C95") ~ "C93-95",
         TRUE ~ "Autres*")) %>% 
  mutate(periode = cut(year, breaks = c(seq(1971, 2025, by = 3)), right = FALSE))   


# Check 1
tabyl(pat_tum_cities,age_category) 

# Check 2 : min and max of each category, to check the left and right endpoints
check<-pat_tum_cities %>% 
  group_by(age_category) %>% 
  summarise(min_age=min(age),
            max_age=max(age))
check 


# Check 1
tabyl(pat_tum_cities,periode) 

# Check 2 : min and max of each category, to check the left and right endpoints
check<-pat_tum_cities %>% 
  group_by(periode) %>% 
  summarise(min_periode=min(year),
            max_periode=max(year))
check 

pat_tum_cities<-pat_tum_cities %>% 
  dplyr::select(-text_fr,-gnr) 

cas_incidents<-pat_tum_cities %>% 
  mutate(gender=as.factor(gender),
         tumor_category=as.factor(tumor_category),
         periode=as.factor(periode),
         age_category=as.factor(age_category),
         gnr_rec=as.factor(gnr_rec)) %>% 
  group_by(gender,tumor_category,periode,age_category,gnr_rec,.drop=FALSE) %>% 
  summarise(nbcas=n()) %>% 
  ungroup()

tabyl(cas_incidents,periode) 
