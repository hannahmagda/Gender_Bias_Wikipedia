#####data acquisition Germany
setwd("~/Documents/Zukunft/Master/drittes semester/thesis/Code/Thesis")
#load necessary packages
library(legislatoR)
library(WikipediR)
library(rvest)
library(dplyr)
library(stringr) #für word count
library(ggplot2)
library(tm)
library(MatchIt)


#save
# write.csv(deu_html_text, file = "raw_data/deu_html_text.csv", row.names = FALSE)
#write.csv(deu_political, file = "raw_data/deu_political.csv", row.names = FALSE)
#write.csv(deu_traffic, file = "raw_data/deu_traffic.csv", row.names = FALSE)



# deu_core <- get_core(legislature = "deu")
# deu_political <- get_political(legislature = "deu")
# deu_traffic <- get_traffic(legislature = "deu")


deu_political <- read.csv("raw_data/deu_political.csv")
deu_traffic <- read.csv("raw_data/deu_traffic.csv")

deu_text <- read.csv("raw_data/deu_text.csv")
deu_html_text <- read.csv("raw_data/deu_html_text.csv")

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
de_html_pipeline <- function(page_name) {
  Sys.sleep(runif(1, 1, 2))
  
  # Überprüfen, ob page_name fehlt
  if (is.na(page_name) || page_name == "") {
    return("Kein Wikipedia-Seitenname angegeben oder fehlend.")
  }
  
  # Versuchen, Wikipedia-Inhalt abzurufen
  tryCatch({
    wp_content <- WikipediR::page_content("de", "wikipedia", page_name = page_name)
    html_content <- wp_content$parse$text$`*`
    return(html_content)
  }, error = function(e) {
    return(paste("Fehler beim Abrufen des Inhalts für die Seite:", page_name))
  })
}






# deu_text <- deu_core %>%
#   mutate(plain_text = sapply(wikititle, de_text_pipeline))
# 
# deu_html_text <- deu_core %>%
#   mutate(text = sapply(wikititle, de_html_pipeline))

deu_political$pageid <- as.integer(deu_political$pageid)
deu_text <- left_join(deu_text, select(deu_political, pageid, session, party, total_service), by = "pageid")
total_traffic_per_politician$pageid <- as.integer(total_traffic_per_politician$pageid)
deu_text <- left_join(deu_text, select(total_traffic_per_politician, pageid, total_traffic), by = "pageid")


# THIS WORKS aber nur für dene rsten absatz
# 

#parsed_html <- read_html(html_text)

# # Extracting section titles containing the word "Leben"
# section_titles <- parsed_html %>%
#   html_nodes(xpath = "//span[contains(@class, 'mw-headline') and contains(text(), 'Leben')]") %>%
#   html_text()
# 
# # Extracting section texts for sections containing the word "Leben"
# section_texts <- list()
# 
# for (title in section_titles) {
#   current_text <- parsed_html %>%
#     html_nodes(xpath = paste("//span[@class='mw-headline' and text()='", title, "']/following::p", sep = "")) %>%
#     html_text() %>%
#     toString() # Convert to character
#   # Remove comma between paragraphs
#   current_text <- gsub(", $", "", current_text)
#   section_texts[[title]] <- current_text
# }
# 
# # Printing or storing the results
# for (title in section_titles) {
#   cat(section_texts[[title]], "\n\n")
# }


#das gibt zu viel info, auch andere sections
# df <- head(deu_html_text,10)
# # 
# extract_text_from_html <- function(df, html_column_name, new_column_name) {
#   # Function to extract text from HTML content
#   extract_text <- function(html_text) {
#     parsed_html <- read_html(html_text)
# 
#     # Extracting section titles containing the word "Leben"
#     section_titles <- parsed_html %>%
#       html_nodes(xpath = "//span[contains(@class, 'mw-headline') and contains(text(), 'Leben')]") %>%
#       html_text()
# 
#     # Extracting section texts for sections containing the word "Leben"
#     section_texts <- list()
# 
#     for (title in section_titles) {
#       current_text <- parsed_html %>%
#         html_nodes(xpath = paste("//span[@class='mw-headline' and text()='", title, "']/following::p", sep = "")) %>%
#         html_text() %>%
#         toString() # Convert to character
#       # Remove comma between paragraphs
#       current_text <- gsub(", $", "", current_text)
#       section_texts[[title]] <- current_text
#     }
# 
#     # Concatenate the section texts
#     concatenated_text <- unlist(section_texts)
#     return(paste(concatenated_text, collapse = "\n"))
#   }
# 
#   # Apply the extract_text function to each row of the data frame
#   df[[new_column_name]] <- sapply(df[[html_column_name]], extract_text)
# 
#   return(df)
# }


# Example usage:
# Assuming df is your data frame, "html_content" is the column containing HTML text,
# and you want to create a new column named "extracted_text" to store the extracted text
#df <- extract_text_from_html(df, "text", "extracted_text")











clean_data <- function(df) {
  initial_rows <- nrow(df)
  
  # Remove CSS-like structures
  df$plain_text <- str_remove_all(df$plain_text, "\\..*?\\{.*?\\}")
  
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

deu$birthyear <- substr(deu$birth, 1, 4)

deu <- deu %>%
  mutate(service_group = case_when(
    total_service <= quantile(total_service, 0.25, na.rm = TRUE) ~ "Group 1",
    total_service <= quantile(total_service, 0.5, na.rm = TRUE) ~ "Group 2",
    total_service <= quantile(total_service, 0.75, na.rm = TRUE) ~ "Group 3",
    TRUE ~ "Group 4"
  ))

deu <- deu %>%
  mutate(traffic_group = case_when(
    total_traffic <= quantile(total_traffic, 0.25, na.rm = TRUE) ~ "Group 1",
    total_traffic <= quantile(total_traffic, 0.5, na.rm = TRUE) ~ "Group 2",
    total_traffic <= quantile(total_traffic, 0.75, na.rm = TRUE) ~ "Group 3",
    TRUE ~ "Group 4"
  ))


deu <- deu[complete.cases(deu$sex), ]


#imputing with most often label
# deu$religion[is.na(deu$religion)] <- levels(deu$religion)[which.max(table(deu$religion))]
# deu$ethnicity[is.na(deu$ethnicity)] <- levels(deu$ethnicity)[which.max(table(deu$ethnicity))]



#data is missing not at random, so we need to impute it in some way - create a group for missing data 
deu$religion[is.na(deu$religion)] <- "Unknown"
deu$ethnicity[is.na(deu$ethnicity)] <- "Unknown"


#binary
deu$sex <- ifelse(deu$sex == "male", 0, 1)


missing_share <- colMeans(is.na(deu))
print(missing_share)


#Using the mathcit function from MatchIt to match each smoker with a non-smoker (1 to 1 matching) based on
#sex, indigeneity status, high school completion, marital status (partnered or not),
#region of residence (major cities, inner regional, outer regional), language background (English speaking Yes/No) 
#and risky alcohol drinking (Yes/No)
match_obj <- matchit(sex ~ birthyear + religion + ethnicity + session + service_group + traffic_group,
                     data = deu, method = "nearest", distance ="glm",
                     ratio = 1,
                     replace = FALSE)

matched_data <- match.data(match_obj)


male_dataset <- matched_data %>% filter(sex == "0")
female_dataset <- matched_data %>% filter(sex == "1")

female_corpus <- Corpus(VectorSource(female_dataset$plain_text))

#female vocabulary
female_corpus <- tm_map(female_corpus, content_transformer(tolower))
female_corpus <- tm_map(female_corpus, removePunctuation)
female_corpus <- tm_map(female_corpus, removeNumbers)
female_corpus <- tm_map(female_corpus, removeWords, stopwords("german"))
female_corpus <- tm_map(female_corpus, stripWhitespace)
female_corpus <- tm_map(female_corpus, stemDocument)


inspect(female_corpus[1:5])

female_tdm <- TermDocumentMatrix(female_corpus)
female_m <- as.matrix(female_tdm)
female_word_counts <- rowSums(female_m)

female_vocabulary <- data.frame(word = names(female_word_counts), count = female_word_counts)


#male vocabulary

male_corpus <- Corpus(VectorSource(male_dataset$plain_text))


male_corpus <- tm_map(male_corpus, content_transformer(tolower))
male_corpus <- tm_map(male_corpus, removePunctuation)
male_corpus <- tm_map(male_corpus, removeNumbers)
male_corpus <- tm_map(male_corpus, removeWords, stopwords("german"))
male_corpus <- tm_map(male_corpus, stripWhitespace)
male_corpus <- tm_map(male_corpus, stemDocument)


inspect(male_corpus[1:5])

male_tdm <- TermDocumentMatrix(male_corpus)
male_m <- as.matrix(male_tdm)
male_word_counts <- rowSums(male_m)

rownames(male_word_counts) <- NULL

male_vocabulary <- data.frame(word = names(male_word_counts), count = male_word_counts)


# we only want to keep words hat are present in both vocabularies so that the pmi analysis makes sense
common_words <- intersect(female_vocabulary$word, male_vocabulary$word)

female_vocabulary_common <- female_vocabulary[female_vocabulary$word %in% common_words, ]
male_vocabulary_common <- male_vocabulary[male_vocabulary$word %in% common_words, ]
# 
