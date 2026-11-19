# BIO 118 Laboratory Exercise 8A
# Multiple Linear Regression

# 8.1 Understand the dataset
?trees

# 8.1.1 Load and inspect the dataset

# Load the built-in dataset
data(trees)

# View the first six observations
head(trees)

# Examine the structure of the dataset
str(trees)

# Obtain descriptive statistics
summary(trees)

# 8.1.2 Explore the relationships among variables

library(ggplot2)

# Volume versus Girth
ggplot(trees, aes(x = Girth, y = Volume)) +
  geom_point(size = 2) +
  labs(
    title = "Tree Volume vs. Girth",
    x = "Girth (inches)",
    y = "Volume (cubic feet)"
  ) +
  theme_minimal()

# Volume versus Height
ggplot(trees, aes(x = Height, y = Volume)) +
  geom_point(size = 2) +
  labs(
    title = "Tree Volume vs. Height",
    x = "Height (feet)",
    y = "Volume (cubic feet)"
  ) +
  theme_minimal()

# Correlation matrix
cor(trees)

# 8.1.3 Fit the multiple linear regression model

# Fit the multiple linear regression model
model_mlr <- lm(Volume ~ Girth + Height,
                data = trees)

model_mlr

# 8.1.4 Interpret the regression output

# Display the model summary
summary(model_mlr)

# 8.1.5 Check model assumptions

# Residuals vs Fitted plot
plot(model_mlr, which = 1)

# Normal Q-Q plot
plot(model_mlr, which = 2)

# Load package
library(car)

# Calculate VIF
vif(model_mlr)

# 8.1.6 Generate predictions

# Create a new observation
new_tree <- data.frame(
  Girth = 15,
  Height = 75
)

# Predict tree volume
predict(model_mlr, newdata = new_tree)

# Add predicted volume to the original dataset
trees$Predicted_Volume <- predict(model_mlr)

# Compare observed and predicted values
head(trees)

# Observed versus predicted volume
ggplot(trees, aes(x = Predicted_Volume, y = Volume)) +
  geom_point(size = 2) +
  geom_abline(
    intercept = 0,
    slope = 1,
    linetype = "dashed"
  ) +
  labs(
    title = "Observed vs. Predicted Tree Volume",
    x = "Predicted Volume (cubic feet)",
    y = "Observed Volume (cubic feet)"
  ) +
  theme_minimal()

