# BIO 118 Laboratory Exercise 6A
# Comparing Groups: One-Sample and Two-Sample Tests

library(dplyr)
# 6.1. Comparing One Sample to a Reference Value

# 6.1.1 Load and inspect the data

# examine the dataset structure
data("trees")
head(trees)
str(trees)
summary(trees$Height)
# check missing values or unusual observations
sum(is.na(trees$Height))

# 6.1.2 Explore the data
library(tidyverse)
# create a histogram
ggplot(trees, aes(x = Height)) +
  geom_histogram(bins = 10) +
  labs(
    title = "Distribution of Black Cherry Tree Heights",
    x = "Height (feet)",
    y = "Number of Trees"
  ) +
  theme_minimal()
# create a box plot
ggplot(trees, aes(x= "", y = Height)) +
  geom_boxplot() +
  labs(
    title = "Black Cherry Tree Heights",
    x = NULL,
    y = "Height (feet)"
  ) +
  theme_minimal()

# 6.1.3 Formulate the hypotheses

# 6.1.4 Assess the Assumptions and Choose an Appropriate Test
# create a Q-Q plot
ggplot(trees, aes(sample = Height)) +
  stat_qq() +
  stat_qq_line() +
  labs(
    title = "Normal Q-Q Plot of Tree Heights",
    x = "Theoretical Quantiles",
    y = "Sample Quantiles"
  ) +
  theme_minimal()

# perform Shapiro test
shapiro.test(trees$Height)

# 6.1.5 Perform the one-sample t-test
# perform t-test
t.test(trees$Height, mu = 75)

# 6.1.6 Interpret the results

# 6.1.7 One-Sample Wilcoxon Signed-Rank Test
tree_sample <- data.frame(
  Tree_ID = 1:20,
  Height = c(
    35, 36, 37, 38, 39,
    40, 41, 42, 43, 44,
    52, 53, 54, 55, 56,
    57, 58, 59, 60, 61
  )
)
tree_sample

# create a histogram
ggplot(tree_sample, aes(x = Height)) +
  geom_histogram(bins = 10, color = "white") +
  labs(
    title = "Distribution of Simulated Tree Heights",
    x = "Tree Height (feet)",
    y = "Number of Trees"
  ) +
  theme_minimal()

# create a box plot
ggplot(tree_sample, aes(x = "", y = Height)) +
  geom_boxplot() +
  labs(
    title = "Simulated Tree Heights",
    x = NULL,
    y = "Tree Height (feet)"
  ) +
  theme_minimal()

# d. Assess normality
# Q-Q plot
ggplot(tree_sample, aes(sample = Height)) +
  stat_qq() +
  stat_qq_line() +
  labs(
    title = "Normal Q-Q Plot of Simulated Tree Heights",
    x = "Theoretical Quantiles",
    y = "Sample Quantiles"
  ) +
  theme_minimal()

shapiro.test(tree_sample$Height)

# e. Perform the One-Sample Wilcoxon Signed-Rank Test
# perform the Wilcoxon Signed-Rank Test
wilcox.test(
  tree_sample$Height,
  mu = 45,
  alternative = "two.sided",
  conf.int = TRUE
)

# 6.2. Comparing Paired Samples
# 6.2.1 Understand the Research Question

# 6.2.2 Load and inspect the data
data("sleep")
head(sleep)
str(sleep)

# 6.2.4 Prepare the Paired Data
# reshape to wide format
library(tidyverse)
sleep_wide <- sleep %>%
  pivot_wider(
    names_from = group,
    values_from = extra,
    names_prefix = "drug"
  )
head(sleep_wide)

# calculate the within-subject difference
sleep_wide <- sleep_wide %>%
  mutate(difference = drug1 - drug2)
head(sleep_wide)

# 6.2.5 Explore the Differences
ggplot(sleep_wide, aes(x = difference)) +
  geom_histogram(bins = 6, color = "white") +
  labs(
    title = "Distribution of Paired Differences in Sleep Increase",
    x = "Difference (Drug 1 - Drug 2, hours)",
    y = "Number of Subjects"
  ) +
  theme_minimal()

ggplot(sleep_wide, aes(sample = difference)) +
  stat_qq() +
  stat_qq_line() +
  labs(
    title = "Normal Q-Q Plot of Paired Differences",
    x = "Theoretical Quantiles",
    y = "Sample Quantiles"
  ) +
  theme_minimal()

shapiro.test(sleep_wide$difference)
  
# 6.2.6 Perform the Paired t-test
t.test(
  sleep_wide$drug1,
  sleep_wide$drug2,
  paired = TRUE
)

# 6.2.7 Perform the Wilcoxon Signed-Rank Test
wilcox.test(
  sleep_wide$drug1,
  sleep_wide$drug2,
  paired = TRUE,
  alternative = "two.sided"
)

# 6.3. Comparing Means of Two Independent Groups
# 6.3.1 Understand the research question
data("iris")
head(iris)
str(iris)

# 6.3.3 Prepare the data
data_subset <- iris %>%
  filter(Species %in% c("setosa", "versicolor"))
head(data_subset)
# check the number of observations in each group
table(data_subset$Species)

# remove unused factor levels
data_subset <- droplevels(data_subset)
# check the number of observations in each group
table(data_subset$Species)

# 6.3.5 Explore the data
# create a histogram
ggplot(data_subset, aes(x = Sepal.Length)) +
  geom_histogram(bins = 10, color = "white") +
  facet_wrap(~Species) +
  labs(
    title = "Distribution of Sepal Length by Species",
    x = "Sepal Length (cm)",
    y = "Number of Flowers"
  ) +
  theme_minimal()

# create a boxplot
ggplot(data_subset, aes(x = Species, y = Sepal.Length)) +
  geom_boxplot() +
  labs(
    title = "Comparison of Sepal Length Between Species",
    x = "Species",
    y = "Sepal Length (cm)"
  ) +
  theme_minimal()

# calculate the mean and standard deviation for each group
data_subset %>%
  group_by(Species) %>%
  summarise(
    n = n(),
    mean_length = mean(Sepal.Length),
    sd_length = sd(Sepal.Length)
  )

# 6.3.6 Assess the assumptions
# create Q-Q plot
ggplot(data_subset, aes(sample = Sepal.Length)) +
  stat_qq() +
  stat_qq_line() +
  facet_wrap(~Species) +
  labs(
    title = "Normal Q-Q Plots of Sepal Length by Species",
    x = "Theoretical Quantiles",
    y = "Sample Quantiles"
  ) +
  theme_minimal()

# Use shapiro test
shapiro.test(
  data_subset$Sepal.Length[data_subset$Species == "setosa"]
)

shapiro.test(
  data_subset$Sepal.Length[data_subset$Species == "versicolor"]
)

# examine variances using levene’s test
library(car)
leveneTest(
  Sepal.Length ~ Species,
  data = data_subset
)

# 6.3.7 Perform Welch's Two-Sample t-Test
# Welch’s t-test
t.test(
  Sepal.Length ~ Species,
  data = data_subset
)

# 6.3.8 Demonstrate the Mann–Whitney U Test
wilcox.test(
  Sepal.Length ~ Species,
  data = data_subset,
  alternative = "two.sided"
)


