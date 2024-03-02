###Beispielcode zur Extrahierung der Sektion "leben/"Biographie" von Wikipedia Biographien

#packages
library(rvest)
library(dplyr)
library(purrr)

#Einlesen Test Datensatz
df <- read.csv("beispieldaten_untersektion.csv")


###x-path --> m.E: nach hätte eigentlich dieser xpath allein funktionieren sollen, um die entsprechenden Texte aus der Lebens Subsection zu extrahieren - er gibt jedoch zuviel aus (auch Teile aus der nächsten Sektion):

#"//h2[contains(span, 'Leben')]/following-sibling::p[preceding-sibling::h2[contains(span, 'Leben')][1]]"


#Deshalb habe ich dann diesen Weg ermittelt, das scheint für die meisten Artikel zu klappen,
#für manche verstehe ich aber nicht, warum es nicht klappt (Beispiel Adis Ahmetovic, Adolf_Ahrens_(Kapitän)), bzw. es werden für manche immer noch die darauffolgenden Abschnitte mitextrahiert (Beispiel Adalbert_Hudak)
#und generell gilt natürlich: bei unbekannteren Politiker:innen gibt es keine eigene Lebenssektion, diese wären von der Analyse dann ausgeschlossen



extract_paragraphs_text <- function(url, start_xpath, end_xpath, following_xpath) {
  
  Sys.sleep(runif(1, 1, 2))
  
  rvest_session <- session(url, 
                           add_headers(`From` = "hannahschweren@gmail.com", 
                                       `User-Agent` = R.Version()$version.string))
  
  page <- tryCatch({
    read_html(url)
  }, error = function(e) {
    return(NA)
  })
  
  if (!is.na(page)) {
    start_element <- html_node(page, xpath = start_xpath)
    end_element <- html_node(page, xpath = end_xpath)

    if (!is.na(start_element) && !is.na(end_element)) {
      paragraphs_xpath <- paste0(start_xpath, following_xpath)
      paragraphs <- html_nodes(page, xpath = paragraphs_xpath)
      paragraphs_text <- html_text(paragraphs) %>% paste(collapse = "\n")
      return(paragraphs_text)
    } else {
      return(NA)
    }
  } else {
    return(NA)
  }
}

# neue Spalte hinzufügen
add_extracted_content_to_df <- function(df, start_xpath, end_xpath, following_xpath) {
  df <- df %>%
    rowwise() %>%
    mutate(extracted_text = list(extract_paragraphs_text(wiki_url, start_xpath, end_xpath, following_xpath))) %>%
    ungroup() # Entfernen der rowwise Gruppierung
  
  return(df)
}
#paths, ich muss über diesen Ansatz die nachfolgenden Section names hard-coden

start_xpath <- '/html/body/div[3]/div[3]/div[5]/div[1]/h2[1]/span[1]'
end_xpath <- '/html/body/div[3]/div[3]/div[5]/div[1]/h2[2]/span[1]'
following_xpath <- '/following::p[following::span[@id="Politik"] or following::span[@id="Partei"] or following::span[@id="Beruf"] or following::span[@id="Politische Tätigkeiten"] or following::span[@id="Parteien"] or following::span[@id="Abgeordneter"]]'

df <- df %>%
  mutate(extracted_text = pblapply(wiki_url, possibly(~extract_paragraphs_text(.x, start_xpath, end_xpath, following_xpath), NA)))
df$extracted_text <- unlist(df$extracted_text)


print(df$extracted_text)
