#2.1.1 Character Data
species_name <- "Avicennia marina"
species_upper <- toupper(species_name)
print(species_upper) # Output: "AVICENNIA MARINA"
class(species_upper) # Output: “character”

#2.1.2 Numeric Data
water_temp <- 28.6
temp_fahrenheit <- (water_temp * 9/5) + 32
print(temp_fahrenheit)
class(temp_fahrenheit)

#2.1.3 Integer Data
sample_size <- 50L
sqrt_sample_size <- sqrt(sample_size)
print(sqrt_sample_size) # Output: 7.071068
class(sample_size) # This should return "integer"
class(sqrt_sample_size) # This should return "numeric"

#2.1.4 Logical Data
average_temp <- 28.6
is_conservation_area <- TRUE
is_temp_high <- average_temp > 25
print(is_temp_high) # Output: TRUE
class(is_temp_high) # This should return "logical"

#2.2.1 Arithmetic Operators
plant_growth <- 10.5
total_growth <- plant_growth * 5
print(total_growth) # Output: 52.5

#2.2.2 Relational Operators
region_A <- 3.8
region_B <- 4.2
is_region_B_richer <- region_B > region_A
print(is_region_B_richer) # Output: TRUE

#2.2.3 Logical Operators
is_species_X_present <- TRUE
is_species_Y_present <- TRUE
is_either_species_present <- is_species_X_present | is_species_Y_present
print(is_either_species_present) # Output: TRUE

# 2.3 Practice
# 2.3.1 Monitoring Species Population in Different Habitats
species_name <- "Setophaga petechia"
species_upper <- toupper(species_name)
print(species_upper) 
class(species_upper) 

habitat_A_population <- 320
habitat_B_population <- 275

total_population <- habitat_A_population + habitat_B_population
print (total_population)

is_habitat_A_larger <- habitat_A_population > habitat_B_population
print (is_habitat_A_larger)

population_difference <- habitat_A_population - habitat_B_population
print(population_difference)

# 2.3.2 Analyzing Environmental Data for Climate Change Impact
current_temperature <- 25
predicted_increase <- 3.8
future_temperature <- current_temperature + predicted_increase
current_temperature_farenheit <- (current_temperature * 9/5) + 32
future_temperature_farenheit <- (future_temperature * 9/5) + 32
exceeds_threshold <- future_temperature > 5
print (current_temperature)
print (predicted_increase)
print (future_temperature)
print (current_temperature_farenheit)
print (future_temperature_farenheit)
print (exceeds_threshold)

# 2.3.3 Evaluating Pollutant Levels in a river
chemical_X_concentration <- 15.3
chemical_Y_concentration <- 9.8
is_chemical_X_safe <- chemical_X_concentration < 10
is_chemical_Y_safe <- chemical_Y_concentration < 10
are_both_safe <- is_chemical_X_safe & is_chemical_Y_safe
print (chemical_X_concentration)
print (chemical_Y_concentration)
print (is_chemical_X_safe)
print (is_chemical_Y_safe)
print (are_both_safe)

# 2.1 Create and Manipulate Data Structures
# 2.1.1 Vectors
# Create a numeric vector
species_count <- c(120, 85, 100, 95, 150)
# Calculate the total number of individuals
total_individuals <- sum(species_count)
print(paste("Total number of individuals observed:", total_individuals))
"Total number of individuals observed: 550"

# Subset to get the count of the third species
third_species_count <- species_count[3]
print(paste("Number of individuals of the third species:", third_species_count))

# 2.1.2
temperature_data <- matrix(
  c(22, 24, 23, 25, 18, 20, 19, 21, 16, 17, 15, 18), nrow = 4, ncol = 3)
colnames(temperature_data) <- c("Location 1", "Location 2", "Location 3")
rownames(temperature_data) <- c("Month 1", "Month 2", "Month 3", "Month 4")

# Calculate the average temperature for each location
avg_temp_per_location <- colMeans(temperature_data)
print("Average temperatures for each location:")
print(avg_temp_per_location)

# Subset to get temperatures for Location 2
location2_temps <- temperature_data[, "Location 2"]
print("Temperatures for Location 2:")
print(location2_temps)

# 2.1.3 Data Frames
# Create a data frame for species data
species_data <- data.frame(
  Species = c("Oak", "Pine", "Maple", "Birch", "Spruce"),
  Count = c(120, 85, 100, 95, 150),
  Habitat = c("Forest", "Forest", "Forest", "Forest", "Forest"))

# Calculate the average count of individuals
avg_count <- mean(species_data$Count)
print(paste("Average count of individuals:", avg_count))

# Subset data frame to get species with count greater than 100
high_count_species <- subset(species_data, Count > 100)
print("Species with count greater than 100:")
print(high_count_species)

# 2.1.4 Lists
# Create a list to store different types of data
ecosystem_data <- list(
  species_count = c(120, 85, 100, 95, 150),
  temperature_data = matrix(
    c(22, 24, 23, 25, 18, 20, 19, 21, 16, 17, 15, 18),
    nrow = 4,
    ncol = 3
  ),
  species_data = data.frame(
    Species = c("Oak", "Pine", "Maple", "Birch", "Spruce"),
    Count = c(120, 85, 100, 95, 150),
    Habitat = c("Forest", "Forest", "Forest", "Forest", "Forest")
  )
)
# Access and print the temperature data component
print("Temperature data:")
print(ecosystem_data$temperature_data)

# 2.1.5 Factors
# Create a character vector
habitat <- c("Mangrove", "Seagrass", "Mangrove",
             "Coral Reef", "Seagrass")
# Convert the vector into a factor
habitat_factor <- factor(habitat)
# Check the class
class(habitat_factor)
# Display the factor levels
levels(habitat_factor)
# Count observations in each habitat type
table(habitat_factor)


# 2.2 Practice

# 2.2.1 Working with DNA Sequences
sequence <- "ATGCGTAC"
nchar(sequence)

library(stringr)

sequence <- "ATGCGTAC"
str_count(sequence, "A")

# Create a character vector named dna_sequences
dna_sequences <- c("ATGCGTACGTAGCTAGCGT", "ATGCGTACGTAGTTAGCGT", "ATGCGTACGTAGATAGCGT")
nchar(dna_sequences)
str_count(dna_sequences, "A")

# 2.2.2 Monitoring Species Population in Different Habitats
# Create the data frame
biodiversity_data <- data.frame(
  Species = c("Oak", "Pine", "Maple", "Birch", "Spruce", 
              "Cedar", "Ash", "Fir", "Beech"),
  Count = c(120, 85, 100, 60, 150, 75, 55, 95, 110),
  Habitat = c("Forest_A", "Forest_A", "Forest_A",
              "Forest_B", "Forest_B", "Forest_B",
              "Forest_C", "Forest_C", "Forest_C")
)

# Display the data frame
print(biodiversity_data)

# Calculate the total number of individuals in each habitat
total_per_habitat <- tapply(
  biodiversity_data$Count,
  biodiversity_data$Habitat,
  sum
)

# Print the totals
print(total_per_habitat)

# Find and print species with a count less than 60
species_less_than_60 <- subset(biodiversity_data, Count < 60)

print(species_less_than_60)

# 2.2.3 Monitoring Temperature Changes
# Create the matrix
monthly_temps <- matrix(
  c(2.5, 3.1, 6.2, 10.5, 15.3, 20.1, 22.4, 21.9, 18.3, 13.8, 7.5, 3.9,
    2.7, 3.5, 6.8, 11.0, 16.0, 21.0, 23.1, 22.5, 19.0, 14.5, 8.0, 4.1),
  nrow = 12,
  ncol = 2
)

# Name the rows and columns
rownames(monthly_temps) <- c(
  "January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
)

colnames(monthly_temps) <- c("Year_1", "Year_2")

# Display the matrix
print(monthly_temps)

# Calculate the average temperature for each year
average_temps <- colMeans(monthly_temps)

# Display the average temperatures
print(average_temps)

# Check if Year 2 had a higher average temperature than Year 1
year_2_higher <- average_temps["Year_2"] > average_temps["Year_1"]

print(year_2_higher)

# Subset the matrix for summer months: June, July, and August
summer_temps <- monthly_temps[c("June", "July", "August"), ]

# Display the summer temperatures
print(summer_temps)













