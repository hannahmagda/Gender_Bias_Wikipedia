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




library(Hmisc)
cor_res <- rcorr(as.matrix(deu[, c("total_edits", "text_length", "number_of_links", 
                                   "total_service", "total_traffic")]))
korrelationsmatrix <- cor_res$r
p.mat <- cor_res$P

# Lade das benötigte Paket für die Darstellung
library(corrplot)

# Erstelle die Korrelationsmatrix-Plot
corrplot(korrelationsmatrix, method = "color", type = "upper", order = "hclust",
         tl.col = "black", tl.srt = 45, addCoef.col = "black",
         # Füge p-Werte hinzu
         p.mat = p.mat, sig.level = 0.05, insig = "blank")
plot(deu$total_traffic, deu$total_edits, main = "Scatterplot der Daten", xlab = "text_length", ylab = "total_edits", pch = 19, col = "blue")

######

library(tidyverse)
library(Hmisc)
library(ggplot2)

cors <- function(df) {
  M <- Hmisc::rcorr(as.matrix(df)) 
  return(list(cor = as.data.frame(M$r), p = as.data.frame(M$P))) 
}

formatted_cors <- function(df) {
  Mdf <- cors(df)
  cor_long <- Mdf$cor %>% 
    rownames_to_column("Var1") %>% 
    pivot_longer(cols = -Var1, names_to = "Var2", values_to = "cor") 
  p_long <- Mdf$p %>% 
    rownames_to_column("Var1") %>% 
    pivot_longer(cols = -Var1, names_to = "Var2", values_to = "p") 

  combined <- full_join(cor_long, p_long, by = c("Var1", "Var2")) %>% 
    mutate(sig_p = p < .05,
           r_if_sig = ifelse(sig_p, cor, NA),
           p_if_sig = ifelse(sig_p, p, NA)) 

  return(combined)
}

# Using your actual dataframe 'deu'
formatted_cors(deu[, c("total_edits", "text_length", "number_of_links", 
                       "total_service", "total_traffic")]) %>% 
  filter(sig_p) %>%
  ggplot(aes(x = Var1, y = Var2, fill = r_if_sig, label = round(r_if_sig, 2))) +
  geom_tile() + 
  geom_text() +
  labs(fill = "Correlation (Pearson's)", 
       subtitle = "Only significant Pearson's correlation coefficients shown") + 
  scale_fill_gradient2(mid = "#9ecae1", low = "#deebf7", high = "#3182bd", limits = c(-1, 1)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))


############