# BIO 118 Laboratory Exercise 7
# Correlation and Simple Linear Regression

# 7.1.1 Load and inspect the data
install.packages("abd")
library(abd)
data("Crickets")
# Inspect the dataset
head(Crickets)

# 7.1.2 Explore the data
library(ggplot2)
ggplot(Crickets, aes(x = sperm.viability, y = lysozyme)) +
  geom_point() +
  labs(
    title = "Sperm Viability and Lysozyme Levels in Crickets",
    x = "Sperm Viability",
    y = "Lysozyme Levels"
  ) +
  theme_minimal()

# 7.1.3 Perform correlation analysis
cor_pearson <- cor.test(
Crickets$sperm.viability,
Crickets$lysozyme,
method = "pearson"
)
cor_pearson

cor_spearman <- cor.test(
  Crickets$sperm.viability,
  Crickets$lysozyme,
  method = "spearman",
  exact = FALSE
)
cor_spearman

# 7.2 Simple Linear Regression
# 7.2.1 Load and inspect the data
data("Rattlesnakes")
# Inspect the first few observations
head(Rattlesnakes)
# Examine the structure and variable names
str(Rattlesnakes)
# Check missing values
colSums(is.na(Rattlesnakes))

# 7.2.2 Explore the data
ggplot(Rattlesnakes, aes(x = meal.size, y = temp.change)) +
  geom_point() +
  labs(
    title = "Meal Size and Postprandial Temperature Change",
    x = "Meal Size",
    y = "Postprandial Temperature Change"
  ) +
  theme_minimal()

# 7.2.3 Fit a simple linear regression model
# Fit the regression model
model <- lm(temp.change ~ meal.size, data = Rattlesnakes)
# Obtain fitted values and residuals
Rattlesnakes$fitted <- fitted(model)
Rattlesnakes$residuals <- residuals(model)
# Examine the estimated coefficients
model

# 7.2.4 Examine the regression results
# Examine the regression output
summary(model)

# 7.2.5 Visualize the fitted regression line
ggplot(Rattlesnakes, aes(x = meal.size, y = temp.change)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Simple Linear Regression of Meal Size and Temperature Change",
    x = "Meal Size",
    y = "Postprandial Temperature Change"
  ) +
  theme_minimal()

# 7.2.6 Examine model residuals
# Examine fitted values and residuals
head(Rattlesnakes)

# Residuals versus fitted values plot
ggplot(Rattlesnakes, aes(x = fitted, y = residuals)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(
    title = "Residuals versus Fitted Values",
    x = "Fitted Values",
    y = "Residuals"
  ) +
  theme_minimal()

# Regression diagnostic plots
plot(model, which = 2) # Normal Q-Q plot

# Identify the range of observed meal sizes
range(Rattlesnakes$meal.size)
# Confidence interval for the mean response
predict(model,
        newdata = data.frame(meal.size = 10),
        interval = "confidence")
# Prediction interval for an individual observation
predict(model,
        newdata = data.frame(meal.size = 10),
        interval = "prediction")




