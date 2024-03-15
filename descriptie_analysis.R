######text length##############################################################################
###############################################################################################


######whole sample#############################################################################

# deu <- deu %>%
#   mutate(text_length = nchar(plain_text))

average_lengths_deu <- deu %>%
  group_by(sex) %>%
  summarise(
    avg_length_live = mean(text_length_live, na.rm = TRUE),
    avg_length_career = mean(text_length_career, na.rm = TRUE),
    avg_length_plain = mean(text_length, na.rm = TRUE)
  ) %>%
  pivot_longer(-sex, names_to = "category", values_to = "avg_length") %>%
  mutate(category = factor(category, levels = c("avg_length_live", "avg_length_career", "avg_length_plain"),
                           labels = c("Live", "Career", "full article")))

ggplot(average_lengths_deu, aes(x = category, y = avg_length, fill = sex)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Text section", y = "average text length", fill = "gender") +
  theme_minimal() +
  scale_fill_manual(values = c("male" = "#67a9cf", "female" = "#ef8a62"))


#significance

t_test_result_full <- t.test(text_length ~ sex, data = deu)
print(t_test_result_full)

t_test_result_live <- t.test(text_length_live ~ sex, data = deu)
print(t_test_result_live)

t_test_result_career <- t.test(text_length_career ~ sex, data = deu)
print(t_test_result_career)



############matched data###########################################################################

# matched_data <- matched_data %>%
#   mutate(text_length = nchar(plain_text))

average_lengths_matched <- matched_data %>%
  group_by(sex) %>%
  summarise(
    avg_length_live = mean(text_length_live, na.rm = TRUE),
    avg_length_career = mean(text_length_career, na.rm = TRUE),
    avg_length_plain = mean(text_length, na.rm = TRUE)
  ) %>%
  pivot_longer(-sex, names_to = "category", values_to = "avg_length") %>%
  mutate(category = factor(category, levels = c("avg_length_live", "avg_length_career", "avg_length_plain"),
                           labels = c("Live", "Career", "full article")))

ggplot(average_lengths_matched, aes(x = category, y = avg_length, fill = sex)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "", y = "average text length", fill = "gender") +
  theme_minimal() +
  scale_fill_manual(values = c("male" = "#67a9cf", "female" = "#ef8a62"))

#####t-test

t_test_result_full <- t.test(text_length ~ sex, data = matched_data)
print(t_test_result_full)

t_test_result_live <- t.test(text_length_live ~ sex, data = matched_data)
print(t_test_result_live)

t_test_result_career <- t.test(text_length_career ~ sex, data = matched_data)
print(t_test_result_career)


#### effect size cohens d - both effect sizes < 0.2 so only small effect

n_male <- sum(matched_data$sex == "male", na.rm = TRUE) # Number of males
n_female <- sum(matched_data$sex == "female", na.rm = TRUE) # Number of females
s1_squared <- var(matched_data$text_length_career[matched_data$sex == "male"], na.rm = TRUE) # Variance for males
s2_squared <- var(matched_data$text_length_career[matched_data$sex == "female"], na.rm = TRUE) # Variance for females

s_pooled <- sqrt(((n_male - 1) * s1_squared + (n_female - 1) * s2_squared) / (n_male + n_female - 2))
mean_male <- mean(matched_data$text_length_career[matched_data$sex == "male"], na.rm = TRUE)
mean_female <- mean(matched_data$text_length_career[matched_data$sex == "female"], na.rm = TRUE)

cohens_d <- (mean_male - mean_female) / s_pooled
cohens_d

########

n_male <- sum(matched_data$sex == "male", na.rm = TRUE) # Number of males
n_female <- sum(matched_data$sex == "female", na.rm = TRUE) # Number of females
s1_squared <- var(matched_data$text_length[matched_data$sex == "male"], na.rm = TRUE) # Variance for males
s2_squared <- var(matched_data$text_length[matched_data$sex == "female"], na.rm = TRUE) # Variance for females

s_pooled <- sqrt(((n_male - 1) * s1_squared + (n_female - 1) * s2_squared) / (n_male + n_female - 2))
mean_male <- mean(matched_data$text_length[matched_data$sex == "male"], na.rm = TRUE)
mean_female <- mean(matched_data$text_length[matched_data$sex == "female"], na.rm = TRUE)

cohens_d <- (mean_male - mean_female) / s_pooled
cohens_d

######number of edits##############################################################################
###############################################################################################

######whole sample#############################################################################
average_edits_deu <- deu %>%
  group_by(sex) %>%
  summarise(
    avg_edits = mean(total_edits, na.rm = TRUE)
  ) %>%
  pivot_longer(-sex, names_to = "category", values_to = "avg_edits")

ggplot(average_edits_deu, aes(x = sex, y = avg_edits, fill = sex)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Gender", y = "Average Number of Edits", fill = "Gender") +
  theme_minimal() +
  scale_fill_manual(values = c("male" = "#67a9cf", "female" = "#ef8a62"))


###t-test not significant
t_test_edits <- t.test(total_edits ~ sex, data = deu)
print(t_test_edits)



######matched sample#############################################################################

average_edits_matched <- matched_data %>%
  group_by(sex) %>%
  summarise(
    avg_edits = mean(total_edits, na.rm = TRUE)
  ) %>%
  pivot_longer(-sex, names_to = "category", values_to = "avg_edits")


###barplot
ggplot(average_edits_matched, aes(x = sex, y = avg_edits, fill = sex)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Gender", y = "Average Number of Edits", fill = "Gender") +
  theme_minimal() +
  scale_fill_manual(values = c("male" = "#67a9cf", "female" = "#ef8a62"))

###boxplot - doesnt make sense because of outliers
ggplot(matched_data, aes(x = sex, y = total_edits)) +
  geom_boxplot(aes(fill = sex)) +
  stat_summary(fun = mean, geom = "point", shape = 20, size = 3, color = "darkred", aes(group = sex)) +
  labs(x = "Gender", y = "Total Number of Edits", fill = "Gender") +
  theme_minimal() +
  scale_fill_manual(values = c("male" = "#67a9cf", "female" = "#ef8a62"))

###t-test not significant
t_test_edits <- t.test(total_edits ~ sex, data = matched_data)
print(t_test_edits)


######number of edits##############################################################################
###############################################################################################


ggplot(deu, aes(x = sex, y = number_of_links)) + 
  geom_boxplot() +
  stat_summary(fun = mean, geom = "point", shape = 20, size = 3, color = "blue", aes(group = sex)) +
  labs(x = "Gender", y = "Number of Links", title = "Boxplot of Number of Links by Gender") +
  theme_minimal()

####t-test - significant 

t_test_result <- t.test(number_of_links ~ sex, data = deu, na.rm = TRUE)
print(t_test_result)

##### cohens d - small effect size 

n_male <- sum(deu$sex == "male", na.rm = TRUE)
n_female <- sum(deu$sex == "female", na.rm = TRUE)
mean_male <- mean(deu$number_of_links[deu$sex == "male"], na.rm = TRUE)
mean_female <- mean(deu$number_of_links[deu$sex == "female"], na.rm = TRUE)
sd_male <- sd(deu$number_of_links[deu$sex == "male"], na.rm = TRUE)
sd_female <- sd(deu$number_of_links[deu$sex == "female"], na.rm = TRUE)

s_pooled <- sqrt(((n_male - 1) * sd_male^2 + (n_female - 1) * sd_female^2) / (n_male + n_female - 2))
cohens_d <- (mean_male - mean_female) / s_pooled

cohens_d