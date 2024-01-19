
############# Data cleaning ###############################################################



#load necessary packages

library(rvest)
library(dplyr)
library(stringr) #für word count
library(ggplot2)




#import raw data

cze_alive_text <- read_csv("raw_data/cze_alive_text.csv")

deu_alive_text <- read_csv("raw_data/deu_alive_text.csv")

fr_alive_text <- read_csv("raw_data/fr_alive_text.csv")

usa_alive_text <- read_csv("raw_data/usa_alive_text.csv")

gbr_alive_text <- read_csv("raw_data/gbr_alive_text.csv")

sco_alive_text <- read_csv("raw_data/sco_alive_text.csv")

irl_alive_text <- read_csv("raw_data/irl_alive_text.csv")

esp_alive_text <- read_csv("raw_data/esp_alive_text.csv")

can_alive_text <- read_csv("raw_data/can_alive_text.csv")

aut_alive_text <- read_csv("raw_data/aut_alive_text.csv") 




######### functions ##################################################################



#word count
count_words <- function(text) {
  words <- str_extract_all(text, "\\b\\w+\\b")[[1]]
  return(length(words))
}


#clean data

# clean_data <- function(df) {
#   df$plain_text <- str_remove_all(df$plain_text, "\\..*?\\{.*?\\}")
#   df <- df %>%
#     filter(!grepl("^Redirect to:", plain_text, ignore.case = TRUE) &
#              !grepl("may refer to:", plain_text, ignore.case = TRUE))
#   # Add more cleaning steps if needed
#   
#   return(df)
# }

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


###########################################################################################


#clean and analyse data missingness of the dataframes for each country

cze <- clean_data(cze_alive_text)
fra <- clean_data(fr_alive_text)
deu <- clean_data(deu_alive_text)
usa <- clean_data(usa_alive_text)
gbr <- clean_data(gbr_alive_text)
irl <- clean_data(irl_alive_text)
sco <- clean_data(sco_alive_text)
esp <- clean_data(esp_alive_text)
aut <- clean_data(aut_alive_text)
can <- clean_data(can_alive_text)


###########################################################################################

# get an overview of the data


#combine all data in one df
all_countries <- rbind(deu, cze, fra, usa, gbr, sco, irl, esp, can, aut)



library(ggplot2)

ggplot(all_countries, aes(x = sex, fill = sex)) +
  geom_bar() +
  facet_wrap(~country, scales = "free_y") +
  labs(title = "Number of male/female politicians per country") +
  xlab("sex") +
  ylab("number") +
  scale_fill_manual(values = c("male" = "blue", "female" = "pink")) +
  theme_minimal() +
  theme(legend.title = element_blank())


############# add data about traffic ##############################################################################

sco_traffic_subset <- dplyr::inner_join(x = dplyr::select(get_core(legislature = "sco"),
                                                          pageid, wikidataid),
                                        y = sco_traffic,
                                        by = "pageid")


sco_traffic <- get_traffic(legislature = "sco")
sco_traffic$date <- format(sco_traffic$date, "%Y-%m")

#####funktioniert aber gibt keinen df aus
# total per politician

total_traffic_per_politician <- sco_traffic %>%
  group_by(pageid) %>%
  summarise(total_traffic = sum(traffic))

#sanity check - genauso viele views wie in sco_traffic, nur nach politician geordnet
sum(total_traffic_per_politician$total_traffic)


## averge per month per politician
average_traffic_per_politician <- total_traffic_per_politician %>%
  mutate(average_traffic = total_traffic / n_distinct(sco_traffic$date))


#############



average_traffic_per_politician <- average_traffic_per_politician %>%
  mutate(pageid = as.numeric(pageid))

# Perform the left join
sco <- left_join(sco, select(average_traffic_per_politician, pageid, average_traffic), by = "pageid")


