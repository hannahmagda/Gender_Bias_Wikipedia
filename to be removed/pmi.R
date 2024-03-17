

# 
# compute_PMI <- function(male_vocabulary, female_vocabulary) {
#   # Calculate total counts for male and female words
#   total_male_count <- sum(male_vocabulary$count)
#   total_female_count <- sum(female_vocabulary$count)
#   
#   # Calculate total counts for both male and female words combined
#   total_count <- total_male_count + total_female_count
#   
#   # Calculate probabilities p_c (probability of each class)
#   p_c_male <- total_male_count / total_count
#   p_c_female <- total_female_count / total_count
#   
#   # Merge male and female vocabularies
#   merged_vocabulary <- merge(male_vocabulary, female_vocabulary, by = "word", suffixes = c("_male", "_female"), all = TRUE)
#   
#   # Fill missing counts with zeros
#   merged_vocabulary[is.na(merged_vocabulary)] <- 0
#   
#   # Calculate probabilities p_w, p_male_w, p_female_w, and PMI values for each word
#   merged_vocabulary$p_w <- (merged_vocabulary$count_male + merged_vocabulary$count_female) / total_count
#   merged_vocabulary$p_male_w <- merged_vocabulary$count_male / total_count
#   merged_vocabulary$p_female_w <- merged_vocabulary$count_female / total_count
#   
#   merged_vocabulary$PMI_male <- log(merged_vocabulary$p_male_w / (merged_vocabulary$p_w * p_c_male)) / -log(merged_vocabulary$p_male_w)
#   merged_vocabulary$PMI_female <- log(merged_vocabulary$p_female_w / (merged_vocabulary$p_w * p_c_female)) / -log(merged_vocabulary$p_female_w)
#   
#   return(merged_vocabulary)
# }
# 
# PMI_results <- compute_PMI(male_vocabulary_common, female_vocabulary_common)
# 
# 
# min_p <- 0.05
# 
# # Filter the DataFrame for female PMI values
# top_female <- PMI_results[PMI_results$PMI_female > min_p, ]
# # Sort the filtered DataFrame by 'PMI_female' in descending order
# top_female <- top_female[order(-top_female$PMI_female), ]
# # Select the top 10 rows
# top_female <- head(top_female, 100)
# 
# # Filter the DataFrame for male PMI values
# top_male <- PMI_results[PMI_results$PMI_male > min_p, ]
# # Sort the filtered DataFrame by 'PMI_male' in descending order
# top_male <- top_male[order(-top_male$PMI_male), ]
# # Select the top 10 rows
# top_male <- head(top_male, 100)
# 
# # Print the top female PMI words
# print("Top Female PMI Words:")
# print(top_female)
# 
# print("Top male PMI Words:")
# print





library(dplyr)

# Berechnen der Gesamtanzahlen
total_male_count <- sum(corpus_transposed$male)
total_female_count <- sum(corpus_transposed$female)
total_count <- total_male_count + total_female_count

# Wahrscheinlichkeiten für jede Klasse
p_c_male <- total_male_count / total_count
p_c_female <- total_female_count / total_count

# Hinzufügen der PMI-Berechnungen zum DataFrame
pmi_df <- corpus_transposed %>%
  mutate(p_w = (male + female) / total_count,
         p_male_w = male / total_count,
         p_female_w = female / total_count,
         PMI_male = log(p_male_w / (p_w * p_c_male)) / -log(p_male_w),
         PMI_female = log(p_female_w / (p_w * p_c_female)) / -log(p_female_w))

min_p <- 0.01

# Filter the DataFrame for female PMI values
top_female <- pmi_df[pmi_df$PMI_female > min_p, ]
# Sort the filtered DataFrame by 'PMI_female' in descending order
top_female <- top_female[order(-top_female$PMI_female), ]
# Select the top 10 rows
top_female <- head(top_female, 200)

# Filter the DataFrame for male PMI values
top_male <- pmi_df[pmi_df$PMI_male > min_p, ]
# Sort the filtered DataFrame by 'PMI_male' in descending order
top_male <- top_male[order(-top_male$PMI_male), ]
# Select the top 10 rows
top_male <- head(top_male, 200)

# Print the top female PMI words
print("Top Female PMI Words:")
print(top_female)

print("Top male PMI Words:")
print(top_male)
