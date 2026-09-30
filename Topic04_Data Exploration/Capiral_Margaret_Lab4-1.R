# BIO 118 Laboratory Exercise 4A

# Data Visualization Using ggplot2

# 4.1. Getting Started with ggplot2

# 4.2. Install and Load ggplot2
install.packages("ggplot2")
library(ggplot2)

# 4.4. Creating a Basic ggplot2 Visualization
# 4.4.1 Initialize the Plot
ggplot(
  data = iris,
  aes(x = Sepal.Length, y = Sepal.Width)
)

# 4.5. Adding a Geometry

# 4.5.1 Scatter Plot: geom_point()

ggplot(
  data = iris,
  aes(x = Sepal.Length, y = Sepal.Width)
) +
  geom_point()

# scatter plot with color
ggplot(
  data = iris,
  aes(
    x = Sepal.Length,
    y = Sepal.Width,
    color = Species
  )
) +
  geom_point()

# 4.5.2. Line Plot: geom_line()
ggplot(
  data = airquality,
  aes(x = Day, y = Temp)
) +
  geom_line()

ggplot(
  airquality,
  aes(
    x = Day,
    y = Temp,
    group = Month,
    color = factor(Month)
  )
) +
  geom_line()

# 4.5.3. Bar Plot: geom_bar()
ggplot(data = iris[25:130,], aes(x = Species)) +
  geom_bar()

ggplot(
  data = iris[25:130, ],
  aes(
    x = Species,
    fill = Species 
  )
) +
  geom_bar()

# 4.5.4. Histogram: geom_histogram()
ggplot(iris, aes(x = Sepal.Length)) +
  geom_histogram()
  # specify width
ggplot(
  iris,
  aes(x = Sepal.Length)
) +
  geom_histogram(binwidth = 0.5)
  # mapping fill
ggplot(
  iris,
  aes(x = Sepal.Length)
) +
  geom_histogram(
    binwidth = 0.5,
    fill = "lightblue",
    color = "black"
  )

# 4.5.5. Box Plot: geom_boxplot()
ggplot(
  iris,
  aes(
    x = Species,
    y = Sepal.Length
  )
) +
  geom_boxplot()

  # Use fill to distinguish the groups.
ggplot(
  iris,
  aes(
    x = Species,
    y = Sepal.Length,
    fill = Species
  )
) +
  geom_boxplot()

# 4.5.6. Bar Plots Using Existing Values: geom_col()
mean_petal <- aggregate(Petal.Length ~ Species, data = iris, mean)
# view the result
mean_petal
# create the bar plot
ggplot(
  mean_petal,
  aes(
    x = Species,
    y = Petal.Length,
    fill = Species
  )
) +
  geom_col()

# 4.5.7. Adding a Trend Line: geom_smooth()
ggplot(
  iris,
  aes(
    x = Sepal.Length,
    y = Sepal.Width,
    color = Species
  )
) +
  geom_point() +
  geom_smooth(
    method = "lm",
    se = FALSE
  )

# 4.5.8. Heatmaps: geom_tile()
temperature_data <- data.frame(
  Site = c(
    "Site A", "Site A", "Site A",
    "Site B", "Site B", "Site B",
    "Site C", "Site C", "Site C"
  ),
  Month = c(
    "June", "July", "August",
    "June", "July", "August",
    "June", "July", "August"
  ),
  Temperature = c(
    27.2, 28.1, 28.5,
    26.8, 27.5, 28.0,
    29.0, 29.4, 30.1
  )
)
temperature_data
  # heatmap
ggplot(
  temperature_data,
  aes(
    x = Site,
    y = Month,
    fill = Temperature
  )
) +
  geom_tile()

# 4.6. Customizing a Plot

# 4.6.1 Add Titles and Labels Using labs()

ggplot(
  iris,
  aes(
    x = Sepal.Length,
    y = Sepal.Width,
    color = Species
  )
) +
  geom_point() +
  labs(
    title = "Sepal Length and Sepal Width",
    subtitle = "Measurements of three Iris species",
    x = "Sepal Length (cm)",
    y = "Sepal Width (cm)",
    caption = "Data from the iris dataset",
    color = "Species")

# 4.6.2 Annotating a Plot with annotate()
ggplot(
  iris,
  aes(
    x = Petal.Length,
    y = Petal.Width,
    color = Species
  )
) +
  geom_point() +
  annotate(
    "text",
    x = 6,
    y = 2.5,
    label = "Large petal dimensions"
  )

# 4.6.3. Faceting: facet_wrap()
ggplot(
  iris,
  aes(
    x = Sepal.Length,
    y = Sepal.Width,
    color = Species
  )
) +
  geom_point() +
  facet_wrap(~ Species)

# 4.6.4. Applying Simple Themes
# theme_minimal()
ggplot(
  iris,
  aes(
    x = Sepal.Length,
    y = Sepal.Width,
    color = Species
  )
) +
  geom_point() +
  theme_minimal()
# theme_classic()
ggplot(
  iris,
  aes(
    x = Sepal.Length,
    y = Sepal.Width,
    color = Species
  )
) +
  geom_point() +
  theme_classic()
# theme_bw()
ggplot(
  iris,
  aes(
    x = Sepal.Length,
    y = Sepal.Width,
    color = Species
  )
) +
  geom_point() +
  theme_bw()
# theme_void()
ggplot(
  iris,
  aes(
    x = Sepal.Length,
    y = Sepal.Width,
    color = Species
  )
) +
  geom_point() +
  theme_void()

# 4.6.5 Combining Multiple Layers
ggplot(
  iris,
  aes(
    x = Sepal.Length,
    y = Sepal.Width,
    color = Species
  )
) +
  geom_point() +
  geom_smooth(
    method = "lm",
    se = FALSE
  ) +
  labs(
    title = "Relationship Between Sepal Length and Sepal Width",
    x = "Sepal Length (cm)",
    y = "Sepal Width (cm)",
    color = "Iris Species"
  ) +
  theme_classic()

# 4.7. Saving a Plot: ggsave()
# assign plot to an object
sepal_plot <- ggplot(
  iris,
  aes(
    x = Sepal.Length,
    y = Sepal.Width,
    color = Species
  )
) +
  geom_point() +
  theme_classic() +
  labs(
    title = "Sepal Dimensions by Iris Species",
    x = "Sepal Length (cm)",
    y = "Sepal Width (cm)",
    color = "Species"
  )
# display the plot
sepal_plot
# save the plot as a JPEG file
ggsave(
  "sepal_plot.jpeg",
  plot = sepal_plot,
  width = 6,
  height = 4,
  dpi = 300
)

# Practice Exercise
# 1
ggplot(
  data = airquality,
  aes(
    x = Wind,
    y = Ozone,
    color = factor(Month)
  )
) +
  geom_point(na.rm = TRUE) +
  labs (
    title = "Relationship between Wind and Ozone"
  )

# 2
ggplot(
  airquality,
  aes(
    x = Day,
    y = Ozone,
    group = Month,
    color = factor(Month)
  )
) +
  geom_line(na.rm = TRUE) +
  labs (
    title = "How Ozone Changes Across Day"
  )

# 3
ggplot(
  airquality,
  aes(x = Wind)
) +
  geom_histogram(
    binwidth = 1.5,
    fill = "lightblue",
    color = "black"
  ) + labs (
    title = "Distribution of Wind"
  )

# 4
ggplot(
  airquality,
  aes(
    x = Month,
    y = Temp,
    fill = factor(Month)
  )
) +
  geom_boxplot() +
  theme_classic() +
  labs (
    title = "Temperature Distribution Across 5 Months"
  )

# 5
ggplot(
  airquality,
  aes(
    x = Wind,
    y = Temp,
    color = factor(Month)
  )
) +
  geom_point() +
  geom_smooth(
    method = "lm",
    se = FALSE
  ) + 
  labs (
    title = "Relationship Between Wind and Temp"
  )

# 6
ggplot(
  airquality,
  aes(
    x = Wind,
    y = Ozone,
    color = factor(Month)
  )
) +
  geom_point(na.rm = TRUE) +
  facet_wrap(~ Month) +
  labs (
    title = "Relationship Between Wind and Ozone"
  )

# 7
mean_Temp <- aggregate(Temp ~ Month, data = airquality, mean)
ggplot(
  mean_Temp,
  aes(
    x = Month,
    y = Temp,
    fill = factor(Month)
  )
) +
  geom_col() +
  labs (
    title = "Mean Temperature for Each Month"
  )

# 8
ggplot(
  airquality,
  aes(
    x = Day,
    y = Month,
    fill = Temp
  )
) +
  geom_tile() +
  theme_bw()

# 9
Wind_and_Ozone_Relationship_plot <- ggplot(
  data = airquality,
  aes(
    x = Wind,
    y = Ozone,
    color = factor(Month)
  )
) +
  geom_point(na.rm = TRUE) +
  labs (
    title = "Relationship between Wind and Ozone"
  )

ggsave(
  "Capiral_Margaret_Plot.jpeg",
  plot = Wind_and_Ozone_Relationship_plot,
  width = 6,
  height = 4,
  dpi = 300
)

# 4.1. Loading and Exploring the Dataset
# 4.1.1 Load the required package
install.packages("tidyverse")
library(tidyverse)

data("who")
glimpse(who)
head(who)

# 4.2. Examining Missing Data
colSums(is.na(who))

# 4.3 Tidying the Dataset
# 4.3.1 Convert the dataset to long format
# convert to long format
who_tidy <- who %>%
  pivot_longer(
    cols = c(-country, -iso2, -iso3, -year),
    names_to = "profile",
    values_to = "cases"
  )
# inspect result
glimpse(who_tidy)

# 4.3.2 Separate the information contained in profile
# standardize profile names
who_tidy <- who_tidy %>%
  mutate(
    profile = gsub("newrel_", "new_rel_", profile)
  )
# separate the profile
who_tidy <- who_tidy %>%
  separate(
    profile,
    into = c("new", "type", "sex_age")
  ) %>%
  separate(
    sex_age,
    into = c("sex", "age"),
    sep = "(?<=m|f)"
  )
# inspect the dataset
glimpse(who_tidy)

# 4.4 Defining the Data for Analysis
# create filtered dataset
tb_data <- who_tidy %>%
  filter(
    type == "sp",
    !is.na(cases)
  )
# inspect the data
glimpse(tb_data)

# 4.5. Exploring Variation and Distributions
# 4.5.1 TB cases across years
tb_by_year <- tb_data %>%
  group_by(year) %>%
  summarise(
    total_cases = sum(cases, na.rm = TRUE)
  )
# inspect the results
tb_by_year
# create a line plot
ggplot(
  tb_by_year,
  aes(
    x = year,
    y = total_cases
  )
) +
  geom_line() +
  labs(
    title = "Recorded TB Cases Over Time",
    x = "Year",
    y = "Total Recorded Cases"
  ) +
  theme_classic()
print(tb_by_year, n = Inf)

# 4.5.2 Comparing Categories: Summarize cases by sex
tb_by_sex <- tb_data %>%
  group_by(sex) %>%
  summarise(
    total_cases = sum(cases, na.rm = TRUE)
  )
tb_by_sex
# visualize the comparison
ggplot(
  tb_by_sex,
  aes(
    x = sex,
    y = total_cases,
    fill = sex
  )
) +
  geom_col() +
  labs(
    title = "Recorded TB Cases by Sex",
    x = "Sex",
    y = "Total Recorded Cases"
  ) +
  theme_classic()

# 4.5.3 Examining Variation Across Age Groups: Summarize by age group
tb_by_age <- tb_data %>%
  group_by(age) %>%
  summarise(
    total_cases = sum(cases, na.rm = TRUE)
  )
tb_by_age
# visualize the result
ggplot(
  tb_by_age,
  aes(
    x = age,
    y = total_cases
  )
) +
  geom_col() +
  labs(
    title = "Recorded TB Cases by Age Group",
    x = "Age Group",
    y = "Total Recorded Cases"
  ) +
  theme_classic()

# 4.6 Bivariate Analysis
tb_year_sex <- tb_data %>%
  group_by(year, sex) %>%
  summarise(
    total_cases = sum(cases, na.rm = TRUE)
  )
glimpse(tb_year_sex)
# visualize the relationship
ggplot(
  tb_year_sex,
  aes(
    x = year,
    y = total_cases,
    color = sex
  )
) +
  geom_line() +
  labs(
    title = "Recorded TB Cases Over Time by Sex",
    x = "Year",
    y = "Total Recorded Cases",
    color = "Sex"
  ) +
  theme_classic()

# 4.7. Multivariable Exploration
# summarize the data
tb_year_age_sex <- tb_data %>%
  group_by(year, age, sex) %>%
  summarise(
    total_cases = sum(cases, na.rm = TRUE)
  )
glimpse(tb_year_age_sex)
# create facetted scatter plot
ggplot(
  tb_year_age_sex,
  aes(
    x = year,
    y = total_cases,
    color = sex
  )
) +
  geom_point() +
  facet_wrap(~ age) +
  labs(
    title = "Recorded TB Cases Over Time by Age Group and Sex",
    x = "Year",
    y = "Total Recorded Cases",
    color = "Sex"
  ) +
  theme_classic()

# 4.8 Investigating Unusual Observations
ggplot(
  tb_data,
  aes(x = "", y = cases)
) +
  geom_boxplot() +
  labs(
    title = "Distribution of Recorded TB Cases",
    x = NULL,
    y = "Number of Recorded Cases"
  ) +
  theme_classic()


