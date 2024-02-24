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

wikititle <- "Erich_Riedl"
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

# Speichere den HTML-Inhalt in einer Datei (optional)
print(html_content)

############################################################################################

