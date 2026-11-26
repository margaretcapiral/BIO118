
# ============================================================
# LABORATORY EXERCISE 9: MODELING BIOLOGICAL SYSTEMS
# 9.1 Modeling Plant Biomass Growth
# ============================================================

# 9.1.1 Identify the components of the system

# Stock: Plant biomass
# Inflow: Biomass production
# Outflow: Biomass loss
# Constants:
# - Growth rate
# - Loss rate
# - Sunlight availability
# - Water availability
# - Nutrient availability


# 9.1.2 Install and load the package

install.packages("sdbuildR")
library(sdbuildR)


# 9.1.3 Create the model and define the stock

# Create an empty model
plant_model <- stockflow()

# Add model information
plant_model <- meta(
  plant_model,
  name = "Plant Growth Model",
  caption = "Plant biomass under different water availability conditions"
)

# Define plant biomass stock
plant_model <- stock(
  plant_model,
  biomass,
  eqn = 10,
  label = "Plant Biomass"
)

# Visualize the model
plot(plant_model)


# 9.1.4 Define the inflow and outflow

# Add biomass growth (inflow)
plant_model <- flow(
  plant_model,
  production,
  eqn = "production_rate * biomass *
         sunlight * water * nutrients",
  to = "biomass",
  label = "Biomass Production"
)

# Add biomass loss (outflow)
plant_model <- flow(
  plant_model,
  loss,
  eqn = "loss_rate * biomass",
  from = "biomass",
  label = "Biomass Loss"
)

# Visualize the model
plot(plant_model)


# 9.1.5 Define the model parameters

plant_model <- plant_model |>
  constant(
    production_rate,
    eqn = 0.10,
    label = "Intrinsic Production Rate"
  ) |>
  constant(
    loss_rate,
    eqn = 0.02,
    label = "Biomass Loss Rate"
  ) |>
  constant(
    sunlight,
    eqn = 0.80,
    label = "Sunlight Availability"
  ) |>
  constant(
    water,
    eqn = 0.70,
    label = "Water Availability"
  ) |>
  constant(
    nutrients,
    eqn = 0.90,
    label = "Nutrient Availability"
  )


# 9.1.6 Visualize the stock-and-flow model

# Display the defined constants
as.data.frame(plant_model, type = "constant")

# Display the model structure, including constants
plot(plant_model, show_constants = TRUE)


# 9.1.7 Set the simulation period

plant_model <- sim_settings(
  plant_model,
  start = 0,
  stop = 20,
  time_units = "weeks"
)


# 9.1.8 Check the model

# Check model structure and equations
summary(plant_model)


# 9.1.9 Run the simulation

# Run the simulation
plant_sim <- simulate(plant_model)

# Plot simulation results
plot(plant_sim)

# View the simulation results
head(as.data.frame(plant_sim))

# View the final simulation values
tail(as.data.frame(plant_sim))


# 9.1.10 Examine the effect of reduced water availability

# Create a model with reduced water availability
plant_model_low_water <- update(
  plant_model,
  water,
  eqn = 0.30
)

# Simulate reduced water availability
plant_sim_low_water <- simulate(
  plant_model_low_water
)

# Visualize the results
plot(plant_sim_low_water)


# 9.1.11 Compare the two simulations using ggplot2

library(ggplot2)
library(dplyr)

# Extract baseline results
baseline <- as.data.frame(plant_sim) |>
  filter(variable == "biomass") |>
  mutate(Scenario = "Baseline")

# Extract reduced-water results
low_water <- as.data.frame(plant_sim_low_water) |>
  filter(variable == "biomass") |>
  mutate(Scenario = "Reduced water")

# Combine results
comparison <- bind_rows(baseline, low_water)

# Plot both scenarios
ggplot(comparison, aes(x = time, y = value,
                       color = Scenario)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Plant Biomass Under Different Water Conditions",
    x = "Time (weeks)",
    y = "Plant Biomass (g)",
    color = "Scenario"
  ) +
  theme_minimal()
