
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


traffic_metrics <- function(traffic_data) {
  # Format the date
  traffic_data$date <- format(traffic_data$date, "%Y-%m")
  
  # Total per politician
  total_traffic_per_politician <- traffic_data %>%
    group_by(pageid) %>%
    summarise(total_traffic = sum(traffic))
  
  # Average per month per politician
  average_traffic_per_politician <- total_traffic_per_politician %>%
    mutate(average_traffic = total_traffic / n_distinct(traffic_data$date))
  
  # Convert pageid to numeric
  average_traffic_per_politician$pageid <- as.numeric(average_traffic_per_politician$pageid)
  
  # Return the result
  return(average_traffic_per_politician)
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
all_countries <- rbind(deu, cze, fra, usa, sco, irl, can, aut) #without esp, gbr 



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


################################## add traffic variable from get_traffic ###########################


deu_traffic <- get_traffic(legislature = "deu")
deu_average_traffic <- traffic_metrics(deu_traffic)
deu <- left_join(deu, select(deu_average_traffic, pageid, average_traffic), by = "pageid")

fra_traffic <- get_traffic(legislature = "fra")
fra_average_traffic <- traffic_metrics(fra_traffic)
fra <- left_join(fra, select(fra_average_traffic, pageid, average_traffic), by = "pageid")

gbr_traffic <- get_traffic(legislature = "gbr")
gbr_average_traffic <- traffic_metrics(gbr_traffic)
gbr <- left_join(gbr, select(gbr_average_traffic, pageid, average_traffic), by = "pageid")

can_traffic <- get_traffic(legislature = "can")
can_average_traffic <- traffic_metrics(can_traffic)
can <- left_join(can, select(can_average_traffic, pageid, average_traffic), by = "pageid")

aut_traffic <- get_traffic(legislature = "aut")
aut_average_traffic <- traffic_metrics(aut_traffic)
aut <- left_join(aut, select(aut_average_traffic, pageid, average_traffic), by = "pageid")


# error because of NAs
esp_traffic <- get_traffic(legislature = "esp")
esp_average_traffic <- traffic_metrics(esp_traffic)
esp <- left_join(esp, select(esp_average_traffic, pageid, average_traffic), by = "pageid")

cze_traffic <- get_traffic(legislature = "cze")
cze_average_traffic <- traffic_metrics(cze_traffic)
cze <- left_join(cze, select(cze_average_traffic, pageid, average_traffic), by = "pageid")

sco_traffic <- get_traffic(legislature = "sco")
sco_average_traffic <- traffic_metrics(sco_traffic)
sco <- left_join(sco, select(sco_average_traffic, pageid, average_traffic), by = "pageid")

irl_traffic <- get_traffic(legislature = "irl")
irl_average_traffic <- traffic_metrics(irl_traffic)
irl <- left_join(irl, select(irl_average_traffic, pageid, average_traffic), by = "pageid")

usa_house_traffic <- get_traffic(legislature = "usa_house")
usa_senate_traffic <- get_traffic(legislature = "usa_senate")

usa_traffic <- bind_rows(usa_house_traffic, usa_senate_traffic)
usa_average_traffic <- traffic_metrics(usa_traffic)
usa <- left_join(usa, select(usa_average_traffic, pageid, average_traffic), by = "pageid")



################## save cleaned data ################################################

write.csv(usa, file = "clean_data/usa.csv", row.names = FALSE)
write.csv(deu, file = "clean_data/deu.csv", row.names = FALSE)
write.csv(esp, file = "clean_data/esp.csv", row.names = FALSE)
write.csv(gbr, file = "clean_data/gbr.csv", row.names = FALSE)
write.csv(cze, file = "clean_data/cze.csv", row.names = FALSE)
write.csv(sco, file = "clean_data/sco.csv", row.names = FALSE)
write.csv(irl, file = "clean_data/irl.csv", row.names = FALSE)
write.csv(can, file = "clean_data/can.csv", row.names = FALSE)
write.csv(aut, file = "clean_data/aut.csv", row.names = FALSE)
write.csv(fra, file = "clean_data/fra.csv", row.names = FALSE)


#################### overview of page traffic ######################################

#boxsplot

ggplot(all_countries, aes(x = sex, y = average_traffic, fill = sex)) +
  geom_bar(stat = "identity") +
  facet_wrap(~country, scales = "free_y") +
  labs(title = "Average Traffic per Country and Sex",
       x = "Sex",
       y = "Average Traffic") +
  scale_fill_manual(values = c("male" = "blue", "female" = "pink")) +
  theme_minimal() +
  theme(legend.title = element_blank())


ggplot(all_countries, aes(x = sex, y = average_traffic, color = sex)) +
  geom_boxplot() +
  facet_wrap(~country, scales = "free_y") +
  labs(title = "Distribution of Average Traffic per Country and Sex",
       x = "Sex",
       y = "Average Traffic") +
  scale_color_manual(values = c("male" = "blue", "female" = "pink")) +
  theme_minimal() +
  theme(legend.position = "none")


ggplot(all_countries, aes(x = average_traffic, fill = sex)) +
  geom_histogram(position = "identity", alpha = 0.7, bins = 30) +
  facet_wrap(~country, scales = "free_y") +
  labs(title = "Distribution of Average Traffic per Country by Sex",
       x = "Average Traffic",
       y = "Count") +
  scale_fill_manual(values = c("male" = "blue", "female" = "pink")) +
  theme_minimal() +
  theme(legend.title = element_blank())
