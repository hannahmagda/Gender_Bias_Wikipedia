#####data acquisition Germany

#load necessary packages
library(legislatoR)
library(WikipediR)
library(rvest)
library(dplyr)
library(stringr) #für word count
library(ggplot2)



deu_core <- get_core(legislature = "deu")



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


deu_text <- deu_core %>%
  mutate(plain_text = sapply(wikititle, de_text_pipeline))
#save
write.csv(deu_text, file = "raw_data/deu_text.csv", row.names = FALSE)



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
deu <- deu[complete.cases(deu$sex), ]


#imputing with most often label
# deu$religion[is.na(deu$religion)] <- levels(deu$religion)[which.max(table(deu$religion))]
# deu$ethnicity[is.na(deu$ethnicity)] <- levels(deu$ethnicity)[which.max(table(deu$ethnicity))]

deu$religion[is.na(deu$religion)] <- "Unknown"
deu$ethnicity[is.na(deu$ethnicity)] <- "Unknown"


#binary
deu$sex <- ifelse(deu$sex == "male", 0, 1)

library(MatchIt)

missing_share <- colMeans(is.na(deu))
print(missing_share)


#Using the mathcit function from MatchIt to match each smoker with a non-smoker (1 to 1 matching) based on
#sex, indigeneity status, high school completion, marital status (partnered or not),
#region of residence (major cities, inner regional, outer regional), language background (English speaking Yes/No) 
#and risky alcohol drinking (Yes/No)
match_obj <- matchit(sex ~ birthyear + religion + ethnicity,
                     data = deu, method = "nearest", distance ="glm",
                     ratio = 1,
                     replace = FALSE)

matched_data <- match.data(match_obj)

summary(match_obj)
#plotting the balance between smokers and non-smokers
plot(match_obj, type = "jitter", interactive = FALSE)
plot(summary(match_obj), abs = FALSE)