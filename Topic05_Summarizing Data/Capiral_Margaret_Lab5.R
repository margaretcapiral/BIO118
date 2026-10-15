# 5.1. Load and inspect the iris dataset
data(iris)

# 5.2. Measures of central tendency

# 5.2.1 Mean
library(dplyr)
iris %>%
  group_by(Species) %>%
  summarise(
    Mean = mean(Sepal.Length)
  )

# 5.2.2 Median
iris %>%
  group_by(Species) %>%
  summarise(
    Median = median(Sepal.Length)
  )

# 5.2.3 Mode
# create a function to calculate the mode
mode_function <- function(x) {
  frequencies <- table(x)
  names(frequencies)[which.max(frequencies)]
}
# use the function to calculate the mode of sepal length for each species
iris %>%
  group_by(Species) %>%
  summarise(
    Mode = mode_function(Sepal.Length)
  )

# 5.3 Measures of variability

# 5.3.1 Range
iris %>%
  group_by(Species) %>%
  summarise(
    Minimum = min(Sepal.Length),
    Maximum = max(Sepal.Length),
    Range = Maximum - Minimum
  )

# 5.3.2 Variance
iris %>%
  group_by(Species) %>%
  summarise(
    Variance = var(Sepal.Length)
  )

# 5.3.3 Standard deviation
iris %>%
  group_by(Species) %>%
  summarise(
    SD = sd(Sepal.Length)
  )

# 5.3.4 Interquartile range (IQR)
iris %>%
  group_by(Species) %>%
  summarise(
    Q1 = quantile(Sepal.Length, 0.25),
    Q3 = quantile(Sepal.Length, 0.75),
    IQR = IQR(Sepal.Length)
  )

# 5.4 Frequency distribution
# create a frequency table
species_freq <- table(iris$Species)
species_freq
# calculate the relative frequency and percentage
# Relative frequency
prop.table(species_freq)
# Percentage
prop.table(species_freq) * 100
# combine counts and percentages in a single table
iris %>%
  count(Species, name = "Frequency") %>%
  mutate(
    Percentage = round(Frequency / sum(Frequency) * 100, 2)
  )

# 5.5 Measures of distribution
install.packages("e1071") # Run only if the package is not installed
library(e1071)
# calculate skewness and kurtosis
iris %>%
  group_by(Species) %>%
  summarise(
    Skewness = skewness(Sepal.Length),
    Kurtosis = kurtosis(Sepal.Length)
  )

# 5.6 Visualizing the data

# 5.6.1 Histogram
library(ggplot2)
ggplot(iris, aes(x = Sepal.Length)) +
  geom_histogram(binwidth = 0.3) +
  facet_wrap(~ Species) +
  labs(
    title = "Distribution of Sepal Length by Iris Species",
    x = "Sepal Length (cm)",
    y = "Frequency"
  )

# 5.6.2 Boxplots
ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  geom_boxplot() +
  labs(
    title = "Sepal Length by Iris Species",
    x = "Species",
    y = "Sepal Length (cm)"
  )

