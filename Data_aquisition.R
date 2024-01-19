

############# Data aquisition ###############################################################



#load necessary packages
library(legislatoR)
library(WikipediR)
library(rvest)
library(dplyr)



#load legislatoR Core data for each country and filter for politicians that are alive

# fr_core <-  get_core((legislature = "fra"))
# fr_core_alive <- fr_core %>% filter(is.na(death))

# deu_core <- get_core(legislature = "deu")
# deu_core_alive <- deu_core %>% filter(is.na(death))

# aut_core <- get_core(legislature = "aut")
# aut_core_alive <- aut_core %>% filter(is.na(death))

# can_core <- get_core(legislature = "can")
# can_core_alive <- can_core %>% filter(is.na(death))

# cze_core <- get_core(legislature = "cze")
# cze_core_alive <- cze_core %>% filter(is.na(death))

# esp_core <- get_core(legislature = "esp")
# esp_core_alive <- esp_core %>% filter(is.na(death))

# irl_core <- get_core(legislature = "irl")
# irl_core_alive <- irl_core %>% filter(is.na(death))

# sco_core <- get_core(legislature = "sco")
# sco_core_alive <- sco_core %>% filter(is.na(death))

# gbr_core <- get_core(legislature = "gbr")
# gbr_core_alive <- gbr_core %>% filter(is.na(death))

# usa_house <- get_core(legislature = "usa_house")
# usa_senate <- get_core(legislature = "usa_senate")
# 
# usa_core <- bind_rows(usa_house, usa_senate)
# usa_core_alive <- usa_core %>% filter(is.na(death))


########### Functions #######################################################################

###text aquisition german

de_text_pipeline <- function(page_name) {
  Sys.sleep(runif(1, 1, 2))
  
  # Check if page_name is missing
  if (is.na(page_name) || page_name == "") {
    return("No Wikipedia page name provided or missing.")
  }
  
  # Try fetching Wikipedia content
  tryCatch({
    wp_content <- WikipediR::page_content("de", "wikipedia", page_name = page_name)
    plain_text <- html_text(read_html(wp_content$parse$text$`*`))
    return(plain_text)
  }, error = function(e) {
    return(paste("Error fetching content for page:", page_name))
  })
}

########### functions ###################################################################################


### function for wiki text aquisition, switch language to desired language per country eg. fr, es, en etc.

de_text_pipeline <- function(page_name) {
  Sys.sleep(runif(1, 1, 2))
  
  # Check if page_name is missing
  if (is.na(page_name) || page_name == "") {
    return("No Wikipedia page name provided or missing.")
  }
  
  # Try fetching Wikipedia content
  tryCatch({
    wp_content <- WikipediR::page_content("de", "wikipedia", page_name = page_name)
    plain_text <- html_text(read_html(wp_content$parse$text$`*`))
    return(plain_text)
  }, error = function(e) {
    return(paste("Error fetching content for page:", page_name))
  })
}

######################################################################################################

# #iterate over dataset, once for each country and save the dataset containing the wikipedia text

# deu_alive_text <- deu_core_alive %>%
#   mutate(plain_text = sapply(wikititle, de_text_pipeline))
#save
#write.csv(deu_alive_text, file = "raw_data/deu_alive_text.csv", row.names = FALSE)


# aut_alive_text <- aut_core_alive %>%
#   mutate(plain_text = sapply(wikititle, de_text_pipeline))
# write.csv(aut_alive_text, file = "raw_data/aut_alive_text.csv", row.names = FALSE)


# esp_alive_text <- esp_core_alive %>%
#    mutate(plain_text = sapply(wikititle, esp_text_pipeline))
#add ethnicity for coherence with other countries
# esp_alive_text <- esp_alive_text %>%
#   mutate(ethnicity = NA) %>%
#   relocate(ethnicity, .after = 6)
#  write.csv(esp_alive_text, file = "raw_data/esp_alive_text.csv", row.names = FALSE)


#  gbr_alive_text <- gbr_core_alive %>%
#    mutate(plain_text = sapply(wikititle, en_text_pipeline))
#  write.csv(gbr_alive_text, file = "raw_data/gbr_alive_text.csv", row.names = FALSE)


#  irl_alive_text <- irl_core_alive %>%
#    mutate(plain_text = sapply(wikititle, en_text_pipeline))
#  write.csv(irl_alive_text, file = "raw_data/irl_alive_text.csv", row.names = FALSE)

#  
# can_alive_text <- can_core_alive %>%
#    mutate(plain_text = sapply(wikititle, en_text_pipeline))
#  write.csv(can_alive_text, file = "raw_data/can_alive_text.csv", row.names = FALSE)
#  
#  usa_alive_text <- usa_core_alive %>%
#    mutate(plain_text = sapply(wikititle, en_text_pipeline))
#  write.csv(usa_alive_text, file = "raw_data/usa_alive_text.csv", row.names = FALSE)

#  sco_alive_text <- sco_core_alive %>%
#   mutate(plain_text = sapply(wikititle, en_text_pipeline))
# write.csv(sco_alive_text, file = "raw_data/sco_alive_text.csv", row.names = FALSE)


#  cze_alive_text <- cze_core_alive %>%
#   mutate(plain_text = sapply(wikititle, sze_text_pipeline))
# write.csv(cze_alive_text, file = "raw_data/cze_alive_text.csv", row.names = FALSE)


# fr_alive_text <- fr_core_alive %>%
#   mutate(plain_text = sapply(wikititle, fra_text_pipeline))
# write.csv(fr_alive_text, file = "raw_data/fr_alive_text.csv", row.names = FALSE)

