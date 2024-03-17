links <- page_links("de","wikipedia", limit = 300, page = "Achim_Kessler")

number_of_links <- length(links[["query"]][["pages"]][[as.character(links[["query"]][["pages"]][[1]][["pageid"]])]][["links"]])

get_links <- function(wiki_name) {
  # Initialize num_links as NA
  num_links <- NA
  
  tryCatch({
    # Introduce a delay of 1 or 2 seconds before the attempt
    Sys.sleep(sample(1:2, 1))
    
    # Call the page_links function to get the data for the specified wiki_name
    links_data <- page_links("de", "wikipedia", limit = 300, page = wiki_name)
    
    # Check if the 'links' list exists and is not empty
    if (!is.null(links_data[["query"]][["pages"]][[1]][["links"]]) && 
        length(links_data[["query"]][["pages"]][[1]][["links"]]) > 0) {
      # Extract the number of links
      num_links <- length(links_data[["query"]][["pages"]][[1]][["links"]])
    }
  }, error = function(e) {
    # If an error occurs, num_links will remain NA
  })
  
  return(num_links)
}




get_links("Achim_Kessler")

# Verwende sapply oder lapply, um die Funktion auf jede Zeile anzuwenden und speichere das Ergebnis in einer neuen Spalte
library(pbapply)

deu$number_of_links <- pbsapply(deu$wikititle, get_links)

# Überprüfe das Ergebnis
head(deu)

install.packages(c("ggplot2", "reshape2", "corrplot"))


deu_history <- get_history(legislature = "deu")

total_edits_per_politician <- deu_history %>%
  group_by(pageid) %>%
  summarise(total_edits = n()) 

total_edits_per_politician$pageid <- as.integer(total_edits_per_politician$pageid)
deu <- left_join(deu, total_edits_per_politician, by = "pageid")





deu <- deu %>%
  mutate(text_length = nchar(extracted_text))

deu <- deu %>%
  mutate(text_length_career = nchar(career_text))


korrelationsmatrix <- cor(deu[, c("total_edits", "text_length", "number_of_links", "total_service", "total_traffic" )], use = "complete.obs")

library(corrplot)

corrplot(korrelationsmatrix, method = "color", type = "upper", order = "hclust",
         tl.col = "black", tl.srt = 45, addCoef.col = "black")


plot(deu$total_traffic, deu$total_edits, main = "Scatterplot der Daten", xlab = "text_length", ylab = "total_edits", pch = 19, col = "blue")
