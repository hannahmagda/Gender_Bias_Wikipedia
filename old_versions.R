library(httr)
library(jsonlite)
library(dplyr)



############################################################################################


# das klappt auf deutsch für adolf arndt

wikititle <- "Alois_Graf_von_Waldburg-Zeil"
ten_years_ago <- format(Sys.Date() - 3650, "%Y%m%d%H%M%S")

url <- paste0("https://de.wikipedia.org/w/api.php?action=query&prop=revisions&titles=", 
              wikititle, "&rvlimit=1&rvdir=older&rvstart=", ten_years_ago, 
              "&format=json&formatversion=2")

response <- GET(url)
response_content <- content(response, "text", encoding = "UTF-8")
parsed_content <- fromJSON(response_content)

# Extrahiere die revisions_id
revision_id <- parsed_content$query$pages$revisions[[1]]$revid

content_url <- paste0("https://de.wikipedia.org/w/api.php?action=parse&oldid=", 
                      revision_id, "&format=json&prop=text")

content_response <- GET(content_url)
content_response_content <- content(content_response, "text", encoding = "UTF-8")
parsed_content_response <- fromJSON(content_response_content)

# Extrahiere den HTML-Inhalt
html_content <- parsed_content_response$parse$text$`*`

print(html_content)

############################################################################################
##plain text 

# Lade den HTML-Inhalt in ein HTML-Dokument
html_doc <- read_html(html_content)

# Extrahiere den reinen Text
plain_text <- html_text(html_doc)

# Gib den reinen Text aus
print(plain_text)




##################################### funktion

library(httr)
library(jsonlite)

get_wikipedia_content_from_past <- function(wikititle) {
  
  Sys.sleep(runif(1, 1, 2))
  
  rvest_session <- session(url, 
                           add_headers(`From` = "hannahschweren@gmail.com", 
                                       `User-Agent` = R.Version()$version.string))
  
  ten_years_ago <- format(Sys.Date() - 3650, "%Y%m%d%H%M%S")
  url <- paste0("https://de.wikipedia.org/w/api.php?action=query&prop=revisions&titles=", 
                wikititle, "&rvlimit=1&rvdir=older&rvstart=", ten_years_ago, 
                "&format=json&formatversion=2")
  
  response <- GET(url)
  response_content <- content(response, "text", encoding = "UTF-8")
  parsed_content <- fromJSON(response_content)
  
  # Extrahiere die revisions_id
  revision_id <- parsed_content$query$pages$revisions[[1]]$revid
  
  content_url <- paste0("https://de.wikipedia.org/w/api.php?action=parse&oldid=", 
                        revision_id, "&format=json&prop=text")
  
  content_response <- GET(content_url)
  content_response_content <- content(content_response, "text", encoding = "UTF-8")
  parsed_content_response <- fromJSON(content_response_content)
  
  # Extrahiere den HTML-Inhalt
  html_content <- parsed_content_response$parse$text$`*`
  html_doc <- read_html(html_content)
  
  # Extrahiere den reinen Text
  plain_text <- html_text(html_doc)
  
  return(plain_text)
}

wikiname <- "Erich_Riedl"
html_content <- get_wikipedia_content_from_past(wikiname)

print(html_content)

#####################funktion anwenden

library(httr)
library(jsonlite)
library(rvest)
library(pbapply)


# Angenommen, df ist Ihr Dataframe und wikititle ist die Spalte mit den Wikipedia-Titeln
apply_function_with_progress <- function(df) {
  df$old_text <- pblapply(df$wikititle, function(title) {
    tryCatch({
      get_wikipedia_content_from_past(title)
    }, error = function(e) {
      NA  # Setzen Sie NA oder eine geeignete Nachricht, wenn ein Fehler auftritt
    })
  })
  return(df)
}

# Funktion anwenden
deu_text_old <- apply_function_with_progress(deu_text)

deu_text_old$old_text <- sapply(deu_text_old$old_text, function(x) {
  if (is.list(x)) {
    paste(unlist(x), collapse=", ")
  } else {
    x
  }
})


#save the result
write.csv(deu_text_old, "deu_text_old")


library(dplyr)

#clean the old data
library(dplyr)
library(stringr)

clean_data <- function(df) {
  initial_rows <- nrow(df)
  
  # Remove CSS-like structures from both 'plain_text' and 'old_text' columns
  df$plain_text <- str_remove_all(df$plain_text, "\\..*?\\{.*?\\}")
  df$old_text <- ifelse(is.na(df$old_text), df$old_text, str_remove_all(df$old_text, "\\..*?\\{.*?\\}"))
  
  # Initialize counters for removal reasons for both columns combined
  removal_reason_redirect <- sum(grepl("^(Redirect to:|Weiterleitung nach:|Rediriger vers:|Redirige a:|Přesměrování na:)", df$plain_text, ignore.case = TRUE) | grepl("^(Redirect to:|Weiterleitung nach:|Rediriger vers:|Redirige a:|Přesměrování na:)", df$old_text, ignore.case = TRUE))
  removal_reason_refering_page <- sum(grepl("may refer to:|ist der Name folgender Personen:|Cette page d'homonymie répertorie différentes personnes|může být:", df$plain_text, ignore.case = TRUE) | grepl("may refer to:|ist der Name folgender Personen:|Cette page d'homonymie répertorie différentes personnes|může být:", df$old_text, ignore.case = TRUE))
  removal_reason_not_found <- sum(grepl("^(Error fetching content for page:|No Wikipedia page name provided or missing|Es wurde kein Wikipedia-Seitenname angegeben)", df$plain_text, ignore.case = TRUE) | grepl("^(Error fetching content for page:|No Wikipedia page name provided or missing|Es wurde kein Wikipedia-Seitenname angegeben)", df$old_text, ignore.case = TRUE))
  
  # Filter rows based on specific conditions in both 'plain_text' and 'old_text'
  df <- df %>%
    filter(!(grepl("^(Redirect to:|Weiterleitung nach:|Rediriger vers:|Redirige a:|Přesměrování na:)", plain_text, ignore.case = TRUE) | grepl("^(Redirect to:|Weiterleitung nach:|Rediriger vers:|Redirige a:|Přesměrování na:)", old_text, ignore.case = TRUE)) &
             !(grepl("may refer to:|ist der Name folgender Personen:|Cette page d'homonymie répertorie différentes personnes|může být:", plain_text, ignore.case = TRUE) | grepl("may refer to:|ist der Name folgender Personen:|Cette page d'homonymie répertorie différentes personnes|může být:", old_text, ignore.case = TRUE)) &
             !(grepl("Error fetching content for page:|No Wikipedia page name provided or missing|Es wurde kein Wikipedia-Seitenname angegeben", plain_text, ignore.case = TRUE) | grepl("Error fetching content for page:|No Wikipedia page name provided or missing|Es wurde kein Wikipedia-Seitenname angegeben", old_text, ignore.case = TRUE)))
  
  # Calculate the number of rows removed
  rows_removed <- initial_rows - nrow(df)
  
  # Print statistics about the removal reasons for both columns
  cat("Removal reasons:\n")
  cat("  - Redirect:", removal_reason_redirect, "\n")
  cat("  - Reference Page:", removal_reason_refering_page, "\n")
  cat("  - Not Found/no name provided:", removal_reason_not_found, "\n")
  
  # Create a message about the cleaning process
  cat("Cleaned data: Removed", rows_removed, "rows from both plain_text and old_text columns.\n")
  
  # Return the cleaned data frame
  return(df)
}


#apply function
deu_old <- clean_data(deu_text_old)

#extract life sections
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

#apply extraction of life section
deu_old <- deu_old %>%
  mutate(extracted_text = map_chr(plain_text, possibly(extract_content, otherwise = NA_character_)))

deu_old <- deu_old %>%
  mutate(extracted_text_old = map_chr(old_text, possibly(extract_content, otherwise = NA_character_)))

#write.csv(deu_old, "deu_old")

deu_old <- read_csv("deu_old")


#only keep rows that are included in both, current, and 10 year old coloumns 
deu_old <- deu_old %>%
  filter(
  extracted_text != "" & extracted_text_old != ""
)
