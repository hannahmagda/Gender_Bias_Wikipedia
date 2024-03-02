#####data acquisition Germany
setwd("~/Documents/Zukunft/Master/drittes semester/thesis/Code")
#load necessary packages
library(legislatoR)
library(WikipediR)
library(rvest)
library(dplyr)
library(stringr) #für word count
library(ggplot2)
library(tm)
library(MatchIt)
library(purrr)

#save
# write.csv(deu_html_text, file = "raw_data/deu_html_text.csv", row.names = FALSE)
#write.csv(deu_political, file = "raw_data/deu_political.csv", row.names = FALSE)
#write.csv(deu_traffic, file = "raw_data/deu_traffic.csv", row.names = FALSE)



# deu_core <- get_core(legislature = "deu")
# deu_political <- get_political(legislature = "deu")
# deu_traffic <- get_traffic(legislature = "deu")


deu_political <- read.csv("deu_political.csv")
deu_traffic <- read.csv("deu_traffic.csv")
deu_text <- read.csv("deu_text.csv")
#deu_html_text <- read.csv("deu_html_text.csv")

#doppelte sessions: nur älteste behalten und service aufaddieren
deu_political <- deu_political %>%
  group_by(pageid) %>%
  mutate(
    total_service = if (n() > 1) sum(service, na.rm = TRUE) else if_else(!is.na(service), service, 0)
  ) %>%
  slice(which.min(session)) %>%
  ungroup()


#sum of traffic data per politician
total_traffic_per_politician <- deu_traffic %>%
  group_by(pageid) %>%
  summarise(total_traffic = sum(traffic))

# funtion für leben text selection
extract_content <- function(text) {
  tryCatch({
    parts <- str_split(text, "\\[Bearbeiten \\| Quelltext bearbeiten\\]")[[1]]
    
    if (length(parts) >= 3) {
      content_between = parts[2]
      paragraph_positions <- str_locate_all(content_between, "\n\n")[[1]][,1]
      
      if (length(paragraph_positions) > 0) {
        last_paragraph_pos <- max(paragraph_positions, na.rm = TRUE)
        return(substr(content_between, 1, last_paragraph_pos))
      } else {
        return(content_between)
      }
    } else {
      return(NA)
    }
  }, error = function(e) { 
    NA 
  })
}




# Funktion auf jede Zeile in der Spalte "Text" anwenden und in neuer Spalte "extracted_text" speichern
deu_text <- deu_text %>%
  mutate(extracted_text = map_chr(plain_text, possibly(extract_content, otherwise = NA_character_)))

print(head(deu_text$extracted_text, 10))

##function text acquisition

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

##html text
# de_html_pipeline <- function(page_name) {
#   Sys.sleep(runif(1, 1, 2))
#   
#   # Überprüfen, ob page_name fehlt
#   if (is.na(page_name) || page_name == "") {
#     return("Kein Wikipedia-Seitenname angegeben oder fehlend.")
#   }
#   
#   # Versuchen, Wikipedia-Inhalt abzurufen
#   tryCatch({
#     wp_content <- WikipediR::page_content("de", "wikipedia", page_name = page_name)
#     html_content <- wp_content$parse$text$`*`
#     return(html_content)
#   }, error = function(e) {
#     return(paste("Fehler beim Abrufen des Inhalts für die Seite:", page_name))
#   })
# }






# deu_text <- deu_core %>%
#   mutate(plain_text = sapply(wikititle, de_text_pipeline))
# 
# deu_html_text <- deu_core %>%
#   mutate(text = sapply(wikititle, de_html_pipeline))

deu_political$pageid <- as.integer(deu_political$pageid)
deu_text <- left_join(deu_text, select(deu_political, pageid, session, party, total_service), by = "pageid")
total_traffic_per_politician$pageid <- as.integer(total_traffic_per_politician$pageid)
deu_text <- left_join(deu_text, select(total_traffic_per_politician, pageid, total_traffic), by = "pageid")










clean_data <- function(df) {
  initial_rows <- nrow(df)
  
  # Remove CSS-like structures
  #df$plain_text <- str_remove_all(df$plain_text, "\\..*?\\{.*?\\}")

  # Initialize counters for removal reasons
  removal_reason_redirect <- sum(grepl("^(Redirect to:|Weiterleitung nach:|Rediriger vers:|Redirige a:|Přesměrování na:)", df$plain_text, ignore.case = TRUE))
  removal_reason_refering_page <- sum(grepl("may refer to:|ist der Name folgender Personen:|Cette page d'homonymie répertorie différentes personnes|může být:", df$plain_text, ignore.case = TRUE))
  removal_reason_not_found <- sum(grepl("^(Error fetching content for page:|No Wikipedia page name provided or missing|Es wurde kein Wikipedia-Seitenname angegeben)", df$plain_text, ignore.case = TRUE))
  
  
  # Filter rows based on specific conditions
  df <- df %>%
    filter(!grepl("^(Redirect to:|Weiterleitung nach:|Rediriger vers:|Redirige a:|Přesměrování na:)", plain_text, ignore.case = TRUE) &
             !grepl("may refer to:|ist der Name folgender Personen:|Cette page d'homonymie répertorie différentes personnes|může být:", plain_text, ignore.case = TRUE) &
             !grepl("Error fetching content for page:|No Wikipedia page name provided or missing|Es wurde kein Wikipedia-Seitenname angegeben", plain_text, ignore.case = TRUE))
  
  # Calculate the number of rows removed
  rows_removed <- initial_rows - nrow(df)
  
  # Print statistics about the removal reasons
  cat("Removal reasons:\n")
  cat("  - Redirect:", removal_reason_redirect, "\n")
  cat("  - Reference Page:", removal_reason_refering_page, "\n")
  cat("  - Not Found/no name_provided:", removal_reason_not_found, "\n")
  
  
  # Create a message about the cleaning process
  cat("Cleaned data: Removed", rows_removed, "rows.\n")
  
  # Return the cleaned data frame
  return(df)
}


deu <- clean_data(deu_text)
#deu_html <- clean_data(deu_html_text)

deu$birthyear <- substr(deu$birth, 1, 4)

# deu <- deu %>%
#   mutate(service_group = case_when(
#     total_service <= quantile(total_service, 0.25, na.rm = TRUE) ~ "Group 1",
#     total_service <= quantile(total_service, 0.5, na.rm = TRUE) ~ "Group 2",
#     total_service <= quantile(total_service, 0.75, na.rm = TRUE) ~ "Group 3",
#     TRUE ~ "Group 4"
#   ))
# 
# deu <- deu %>%
#   mutate(traffic_group = case_when(
#     total_traffic <= quantile(total_traffic, 0.25, na.rm = TRUE) ~ "Group 1",
#     total_traffic <= quantile(total_traffic, 0.5, na.rm = TRUE) ~ "Group 2",
#     total_traffic <= quantile(total_traffic, 0.75, na.rm = TRUE) ~ "Group 3",
#     TRUE ~ "Group 4"
#   ))


deu <- deu[complete.cases(deu$sex), ]


#imputing with most often label
# deu$religion[is.na(deu$religion)] <- levels(deu$religion)[which.max(table(deu$religion))]
# deu$ethnicity[is.na(deu$ethnicity)] <- levels(deu$ethnicity)[which.max(table(deu$ethnicity))]



#data is missing not at random, so we need to impute it in some way - create a group for missing data 
# deu$religion[is.na(deu$religion)] <- "Unknown"
# deu$ethnicity[is.na(deu$ethnicity)] <- "Unknown"


#binary
deu$sex <- ifelse(deu$sex == "male", 0, 1)


missing_share <- colMeans(is.na(deu))
print(missing_share)




#propensity score matching

# match_obj <- matchit(sex ~ birthyear + religion + ethnicity + session + total_service + total_traffic,
#                      data = deu, method = "nearest", distance ="glm",
#                      ratio = 1,
#                      replace = FALSE)
# 
# matched_data <- match.data(match_obj)

# wenn auf groups geamchted: 1946 obs.

#coarsened matching

match_obj <- matchit(sex ~ birthyear + session + total_service + total_traffic,
                     data = deu, method = "cem")

matched_data <- match.data(match_obj)


# male_dataset <- matched_data %>% filter(sex == "0")
# female_dataset <- matched_data %>% filter(sex == "1")
# 
# female_corpus <- Corpus(VectorSource(female_dataset$plain_text))
# 
# #female vocabulary
# female_corpus <- tm_map(female_corpus, content_transformer(tolower))
# female_corpus <- tm_map(female_corpus, removePunctuation)
# female_corpus <- tm_map(female_corpus, removeNumbers)
# female_corpus <- tm_map(female_corpus, removeWords, stopwords("german"))
# female_corpus <- tm_map(female_corpus, stripWhitespace)
# female_corpus <- tm_map(female_corpus, stemDocument)
# 
# 
# inspect(female_corpus[1:5])
# 
# female_tdm <- TermDocumentMatrix(female_corpus)
# female_m <- as.matrix(female_tdm)
# female_word_counts <- rowSums(female_m)
# 
# female_vocabulary <- data.frame(word = names(female_word_counts), count = female_word_counts)
# 
# 
# #male vocabulary
# 
# male_corpus <- Corpus(VectorSource(male_dataset$plain_text))
# 
# 
# male_corpus <- tm_map(male_corpus, content_transformer(tolower))
# male_corpus <- tm_map(male_corpus, removePunctuation)
# male_corpus <- tm_map(male_corpus, removeNumbers)
# male_corpus <- tm_map(male_corpus, removeWords, stopwords("german"))
# male_corpus <- tm_map(male_corpus, stripWhitespace)
# male_corpus <- tm_map(male_corpus, stemDocument)
# 
# 
# inspect(male_corpus[1:5])
# 
# male_tdm <- TermDocumentMatrix(male_corpus)
# male_m <- as.matrix(male_tdm)
# male_word_counts <- rowSums(male_m)
# 
# rownames(male_word_counts) <- NULL
# 
# male_vocabulary <- data.frame(word = names(male_word_counts), count = male_word_counts)
# 
# 
# # we only want to keep words hat are present in both vocabularies so that the pmi analysis makes sense
# common_words <- intersect(female_vocabulary$word, male_vocabulary$word)
# 
# female_vocabulary_common <- female_vocabulary[female_vocabulary$word %in% common_words, ]
# male_vocabulary_common <- male_vocabulary[male_vocabulary$word %in% common_words, ]
# # 
