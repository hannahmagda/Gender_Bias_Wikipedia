#dfm mit quanteda
library(quanteda)

summary_df <- matched_data %>%
  group_by(sex) %>%
  summarise(text = paste(extracted_text, collapse = " ")) %>%
  ungroup()%>%
  mutate(sex = ifelse(sex == 1, "female", "male"))


#write.csv(summary_df, file = "raw_data/text_names_removal.csv", row.names = FALSE)


# Erstellen des Corpus
corpus <- corpus(summary_df, docid_field = "sex")


#dfmat erstellen #1 ohne berufsbezeichnung
# dfmat <- corpus %>%
#   corpus() %>%
#   corpus_reshape(to = "documents") %>%
#   tokens(remove_punct = TRUE, remove_numbers = TRUE, remove_symbols = TRUE, remove_hyphens = TRUE) %>%
#   tokens_wordstem(language = "german") %>%
#   dfm()
# dfmat
# 

# #covert to df
# corpus_df <- convert(dfmat, to = "data.frame")
# 
# #only keep words that appear in both genders
# corpus_common <- corpus_df[, apply(corpus_df, 2, function(x) !any(x == 0))]
# 
# 
# #swap rows and columns
# corpus_transposed <- t(corpus_common)
# 
# # Umwandeln der transponierten Matrix zurück in einen DataFrame
# corpus_transposed <- as.data.frame(corpus_transposed)




######gender problem:

# Ersatzwörter-Vektor
gender_neutral_replacements <- c(
  "Politikerin" = "Politiker",
  "Lehrerin" = "Lehrer",
  "Sprecherin" = "Sprecher",
  "Wissenschaftlerin" = "Wissenschaftler",
  "direktkandidatin" = "direktkandidat",
  "staatssekretärin" = "Staatssekretär",
  "Mitarbeiterin" = "Mitarbeiter",
  "Leiterin" = "Leiter",
  "Geschäftsführerin" ="Geschäftsführer",
  "referentin" ="referent",
  "Spitzenkandidatin" ="Spitzenkandidat",
  "Staatsministerin" = "Staatsminister",
  "Ministerin" ="Minister",
  "Rechtsanwältin" ="Rechtsanwalt",
  "Statträtin" = "Stadtrat",
  "Generalsekretärin" ="Generalsekretär",
  "Senatorin" = "Senator",
  "Richterin" ="Richter",
  "assistentin" = "assistent",
  "Bürgermeisterin" = "Bürgermeister",
  "Präsidentin" = "Präsident",
  "vizeprasidentin" = "Vizepräsident",
  "Obfrau" = "Obmann",
  "Kandidatin"= "Kandidat"
)

tokens <- corpus %>%
  tokens(remove_punct = TRUE, remove_numbers = TRUE, remove_symbols = TRUE, remove_hyphens = TRUE) %>%
  tokens_replace(pattern = names(gender_neutral_replacements), replacement = gender_neutral_replacements, case_insensitive = TRUE)

# Entfernen von Stopwörtern
tokens <- tokens %>%
  tokens_remove(pattern = stopwords("de"), padding = FALSE) %>%
  tokens_wordstem(language = "german")

# Erstellen des DFM
dfmat <- tokens %>%
  dfm()

# Überprüfen Sie das Ergebnis
print(dfmat)

#covert to df
corpus_df <- convert(dfmat, to = "data.frame")

# Setzen der ersten Spalte als Zeilennamen
rownames(corpus_df) <- corpus_df[, 1]

# Entfernen der ersten Spalte aus dem DataFrame
corpus_df <- corpus_df[, -1]

#only keep words that appear in both genders
# Zählen der Nullen in jeder Spalte
zero_count_per_column <- colSums(corpus_df == 0)

# Filtern der Spalten, bei denen keine Nullen vorhanden sind
corpus_common <- corpus_df[, zero_count_per_column == 0]


#swap rows and columns
corpus_transposed <- t(corpus_common)

# Umwandeln der transponierten Matrix zurück in einen DataFrame
corpus_transposed <- as.data.frame(corpus_transposed)
corpus_transposed$word <- rownames(corpus_transposed)
rownames(corpus_transposed) <- NULL

##############namen problem


