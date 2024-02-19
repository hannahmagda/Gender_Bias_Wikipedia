library(ggplot2)

###skript, um die Länge der ebens/ersten Section von Frauen/Mänenr zu vergleichen


length <- matched_data %>%
  mutate(text_length = nchar(extracted_text))

# Schritt 2: Berechnung der durchschnittlichen Textlänge für jedes Geschlecht
average_lengths <- length %>%
  group_by(sex) %>%
  summarise(average_length = mean(text_length, na.rm = TRUE))

average_lengths <- average_lengths %>%
  mutate(sex = ifelse(sex == 1, "female", "male"))


# Schritt 3: Plotting der Durchschnittslängen
ggplot(average_lengths, aes(x = sex, y = average_length, fill = sex)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Durchschnittliche Textlänge nach Geschlecht", x = "Geschlecht", y = "Durchschnittliche Länge")


error <- subset(length, text_length<61)
#########signifikanz testen mit chi test!
#########Firts women , second sex: The mean article length is 5,955 characters for men and 6,013 characters for women (a significant difference according to a t-test for independent samples: p < 0.01, Cohen’s d = 0.01)

t_test_result <- t.test(text_length ~ sex, data = length)

# Ergebnisse anzeigen
print(t_test_result)
