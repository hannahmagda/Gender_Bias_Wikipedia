library(httr)
library(jsonlite)

wikititle <- "Adolf_Arndt"  # Beispiel Wikipedia-Seitentitel
ten_years_ago <- format(Sys.Date() - 3650, "%Y%m%d%H%M%S")  # Datum vor ca. 10 Jahren

url <- paste0("https://en.wikipedia.org/w/api.php?action=query&prop=revisions&titles=", 
              wikititle, "&rvlimit=1&rvdir=older&rvstart=", ten_years_ago, 
              "&format=json&formatversion=2")

response <- GET(url)

response_content <- content(response, "text", encoding = "UTF-8")
parsed_content <- fromJSON(response_content)

content_url <- paste0("https://en.wikipedia.org/w/api.php?action=parse&oldid=", 
                      revision_id, "&format=json&prop=text")

content_response <- GET(content_url)
content_response_content <- content(content_response, "text", encoding = "UTF-8")
parsed_content_response <- fromJSON(content_response_content)

# Extrahiere den HTML-Inhalt
html_content <- parsed_content_response$parse$text$`*`

# Zeige einen Teil des HTML-Inhalts
cat(substr(html_content, 1, 500))




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

# Stellen Sie sicher, dass Ihre Funktion `get_wikipedia_content_from_past` hier definiert ist

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

# Beispiel-Dataframe
df <- data.frame(wikititle = c("Alois_Graf_von_Waldburg-Zeil", "Adolf_Arndt", "Beispiel_Titel"))

# Funktion anwenden
deu_text_old <- apply_function_with_progress(deu_text)

deu_text_old$old_text <- sapply(deu_text_old$old_text, function(x) {
  if (is.list(x)) {
    paste(unlist(x), collapse=", ")
  } else {
    x
  }
})

write.csv(deu_text_old, "deu_text_old")

