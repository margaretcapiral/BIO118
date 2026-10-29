# BIO 118 Laboratory Exercise 6B
# Comparing Groups: Three or More Groups and Two-Factor Comparisons

# 6.1. Comparing Means of More than Two Groups
# 6.1.1 Load and inspect the data
# Load the dataset
data("iris")
# Inspect the data
head(iris)
str(iris)
summary(iris)
# Count the observations in each species
table(iris$Species)

# 6.1.2 Explore the data
library(ggplot2)
# Histograms by species
ggplot(iris, aes(x = Sepal.Length)) +
  geom_histogram(bins = 10, color = "white") +
  facet_wrap(~Species) +
  labs(
    title = "Distribution of Sepal Length by Species",
    x = "Sepal Length (cm)",
    y = "Number of Flowers"
  ) +
  theme_minimal()

# create a box plot
ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  geom_boxplot() +
  labs(
    title = "Sepal Length Across Iris Species",
    x = "Species",
    y = "Sepal Length (cm)"
  ) +
  theme_minimal()

# calculate descriptive statistics
library(dplyr)
iris %>%
  group_by(Species) %>%
  summarise(
    n = n(),
    mean_length = mean(Sepal.Length),
    sd_length = sd(Sepal.Length)
  )

# 6.1.4 Assess the Assumptions and Choose an Appropriate Test
# A. Assess Normality
# create a Q-Q plot
ggplot(iris, aes(sample = Sepal.Length)) +
  stat_qq() +
  stat_qq_line() +
  facet_wrap(~Species) +
  labs(
    title = "Normal Q-Q Plots of Sepal Length",
    x = "Theoretical Quantiles",
    y = "Sample Quantiles"
  ) +
  theme_minimal()

# perform Shapiro test on iris setosa
shapiro.test(
  iris$Sepal.Length[iris$Species == "setosa"]
)

# Shapiro test on iris versicolor
shapiro.test(
  iris$Sepal.Length[iris$Species == "versicolor"]
)

# Shapiro test on iris virginica
shapiro.test(
  iris$Sepal.Length[iris$Species == "virginica"]
)

# B. Assess Equality of Variances
# perform levene’s test
library(car)
leveneTest(
  Sepal.Length ~ Species,
  data = iris
)

# 6.1.5 Perform One-Way ANOVA
# Perform one-way ANOVA
anova_result <- aov(
  Sepal.Length ~ Species,
  data = iris
)
# Display the ANOVA results
summary(anova_result)

# 6.1.6 Conduct Pairwise Comparisons Using Tukey's HSD
# Perform Tukey's HSD test
TukeyHSD(anova_result)

# 6.1.7 Perform the Kruskal–Wallis Test
# Perform the Kruskal-Wallis test
kruskal.test(
  Sepal.Length ~ Species,
  data = iris
)

# 6.1.8 Conduct Pairwise Comparisons After Kruskal–Wallis
pairwise.wilcox.test(
  iris$Sepal.Length,
  iris$Species,
  p.adjust.method = "bonferroni"
)

# 6.2. Comparing Means Across Two Factors
# 6.2.2 Load and inspect the data
# Load the dataset
data("ToothGrowth")
# Inspect the data
head(ToothGrowth)
str(ToothGrowth)
summary(ToothGrowth)
# Check the number of observations
nrow(ToothGrowth)
# Count observations by supplement type and dose
table(ToothGrowth$supp, ToothGrowth$dose)

# Convert dose to a categorical variable
ToothGrowth$dose <- as.factor(ToothGrowth$dose)
# Verify the variable types
str(ToothGrowth)

# 6.2.4 Explore the Data
# summarize the observations
library(dplyr)
ToothGrowth_summary <- ToothGrowth %>%
  group_by(supp, dose) %>%
  summarise(
    n = n(),
    mean_length = mean(len),
    sd_length = sd(len),
    .groups = "drop" # removes grouping after calculations are complete
  )
# compare mean tooth lengths
library(ggplot2)
ggplot(
  ToothGrowth,
  aes(x = dose, y = len, fill = supp)
) +
  geom_boxplot() +
  labs(
    title = "Tooth Length by Supplement Type and Dose",
    x = "Vitamin C Dose (mg/day)",
    y = "Tooth Length",
    fill = "Supplement Type"
  ) +
  theme_minimal()

# create an interaction plot
ggplot(
  ToothGrowth_summary,
  aes(
    x = dose,
    y = mean_length,
    color = supp,
    group = supp
  )
) +
  geom_line() +
  geom_point(size=3) +
  labs(
    title = "Interaction Between Supplement Type and Dose",
    x = "Vitamin C Dose (mg/day)",
    y = "Mean Tooth Length",
    color = "Supplement Type"
  ) +
  theme_minimal()

# 6.2.5 Assess the Assumptions
# A. Fit the model
# Fit the two-way ANOVA model
anova_result <- aov(
  len ~ supp * dose,
  data = ToothGrowth
)
# Inspect the model
summary(anova_result)

# B. Examine the residuals
# Histogram of residuals
hist(
  residuals(anova_result),
  main = "Histogram of ANOVA Residuals",
  xlab = "Residuals"
)

# Normal Q-Q plot
qqnorm(residuals(anova_result))
qqline(residuals(anova_result))

# # perform Shapiro test
shapiro.test(residuals(anova_result))

# C. Assess equality of variances
library(car)
leveneTest(
  len ~ supp * dose,
  data = ToothGrowth
)

# 6.2.6 Perform Two-Way ANOVA
# Display the two-way ANOVA results
summary(anova_result)

# 6.2.7 Conduct Follow-Up Comparisons
# # Compare supplement types
TukeyHSD(
  anova_result,
  which = "supp"
)

# # Compare dose levels
TukeyHSD(
  anova_result,
  which = "dose"
)




