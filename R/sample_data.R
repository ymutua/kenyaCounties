# Sample data creation script
# This would typically be run once to create the package datasets

create_sample_governors <- function() {
  governors <- data.frame(
    county_code = 1:47,
    county_name = c("Mombasa", "Kwale", "Kilifi", "Tana River", "Lamu", "Taita Taveta", 
                   "Garissa", "Wajir", "Mandera", "Marsabit", "Isiolo", "Meru", 
                   "Tharaka Nithi", "Embu", "Kitui", "Machakos", "Makueni", "Nyandarua",
                   "Nyeri", "Kirinyaga", "Murang'a", "Kiambu", "Turkana", "West Pokot",
                   "Samburu", "Trans Nzoia", "Uasin Gishu", "Elgeyo Marakwet", "Nandi",
                   "Baringo", "Laikipia", "Nakuru", "Narok", "Kajiado", "Kericho",
                   "Bomet", "Kakamega", "Vihiga", "Bungoma", "Busia", "Siaya",
                   "Kisumu", "Homa Bay", "Migori", "Kisii", "Nyamira", "Nairobi"),
    governor_name = c("Abdulswamad Nassir", "Fatuma Achani", "Gideon Mung'aro", 
                     "Dhadho Godhana", "Issa Timamy", "Andrew Mwadime",
                     rep("Sample Governor", 41)), # Placeholder for remaining governors
    deputy_governor_name = rep("Sample Deputy", 47),
    political_party = sample(c("UDA", "ODM", "Wiper", "ANC", "FORD-K"), 47, replace = TRUE),
    term_start = rep("2022-08-25", 47),
    term_end = rep("2027-08-24", 47),
    previous_governor = rep(NA, 47),
    election_year = rep(2022, 47),
    stringsAsFactors = FALSE
  )
  return(governors)
}

# This function would be used to save the data
# save(governors, file = "data/governors.rda")
# save(county_boundaries, file = "data/county_boundaries.rda")  
# save(county_info, file = "data/county_info.rda")