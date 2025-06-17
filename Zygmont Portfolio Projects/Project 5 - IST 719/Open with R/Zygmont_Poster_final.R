
# Final Poster Project Code
# Air Pollution Data
# Author: Samantha Zygmont

# IST 719: Information Visualizations

# Data is loaded in from WHO 
# https://www.who.int/data/gho/data/indicators/indicator-details/GHO/ambient-air-pollution-attributable-deaths
# Data set title from WHO: "Ambient air pollution attributable deaths"
air <- read.csv("data.csv"
                  , header = TRUE
                  , stringsAsFactors = FALSE)

# Explore head of data
head(air)

# Explore structure of data
str(air)

# Based on the str function there are many unnecessary columns and missing values
# Therefore the data needed to be cleaned

# Cleaning

library(dplyr)

# Drop NAs 
# Keep necessary columns
air_clean <- air %>%
  select(
    Location,
    Period,
    Sex = Dim1,
    Disease = Dim2,
    DeathRate = FactValueNumeric,
    LowerCI = FactValueNumericLow,
    UpperCI = FactValueNumericHigh
  ) %>%
  filter(!is.na(DeathRate)) %>%
  mutate(
    Sex = factor(Sex, levels = c("Male", "Female", "Both sexes")),
    Disease = as.factor(Disease)
  )

str(air_clean)
# confirm (still have 32,490 obs x 7 col)

# Question 1: Is there a relationship between death rate ranges
# and disease burden by gender?

library(ggplot2)

# Plot 1: Death Rate by Disease and Gender

ggplot(air_clean, aes(x = Disease, y = DeathRate, color = Sex)) +
  geom_point(position = position_jitter(width = 0.2), alpha = 0.7) +
  geom_errorbar(aes(ymin = LowerCI, ymax = UpperCI), width = 0.2, alpha = 0.5) +
  scale_color_manual(values = c("Male" = "#1f77b4", "Female" = "#000000", "Both sexes" = "#bdbdbd")) +
  labs(
    title = "Death Rate by Disease and Gender",
    x = "Disease",
    y = "Death Rate (per 100,000)",
    color = "Gender"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(size = 14, face = "bold"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )

# Plot 2: Number of deaths by gender

# Summarize total DeathRate by Sex
death_summary <- air_clean %>%
  group_by(Sex) %>%
  summarise(TotalDeaths = sum(DeathRate, na.rm = TRUE))

# plot
ggplot(death_summary, aes(x = Sex, y = TotalDeaths, fill = Sex)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("Male" = "#1f77b4", "Female" = "#000000", "Both sexes" = "#bdbdbd")) +
  labs(
    title = "Total Death Rate by Gender",
    x = "Gender",
    y = "Sum of Death Rates"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(size = 14, face = "bold")
  )

# Plot 3: Total Death Rate by Disease

# Summarize total DeathRate by Disease
disease_summary <- air_clean %>%
  group_by(Disease) %>%
  summarise(TotalDeaths = sum(DeathRate, na.rm = TRUE)) %>%
  arrange(desc(TotalDeaths))

# Plot
ggplot(disease_summary, aes(x = reorder(Disease, TotalDeaths), y = TotalDeaths)) +
  geom_bar(stat = "identity", fill = "#1f77b4") +
  labs(
    title = "Total Death Rate by Disease",
    x = "Disease Type",
    y = "Sum of Death Rates"
  ) +
  coord_flip() +
  theme_minimal() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    plot.title = element_text(size = 14, face = "bold"),
    axis.text.y = element_text(size = 10)
  )


# Question 2: Are certain countries or regions 
# disproportionately affected by specific pollution-related diseases?

# Load libraries
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(countrycode)

# Plot 4: Map plot

map_data <- air_clean %>%
  filter(Sex == "Both sexes", Disease == "ALL CAUSES") %>%
  group_by(Location) %>%
  summarize(DeathRate = mean(DeathRate, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(iso3 = countrycode(Location, origin = "country.name", destination = "iso3c"))

world <- ne_countries(scale = "medium", returnclass = "sf")

# Merge death data with map
world_data <- left_join(world, map_data, by = c("iso_a3" = "iso3"))

ggplot(data = world_data) +
  geom_sf(aes(fill = DeathRate), color = "grey30", size = 0.1) +
  scale_fill_gradient(
    low = "#deebf7",
    high = "#08519c",
    na.value = "lightgrey",
    name = "Deaths per 100k"
  ) +
  theme_minimal() +
  labs(
    title = "Air Pollution Death Rate by Country",
    subtitle = "Both Sexes | All Causes"
  ) +
  theme(
    legend.position = "bottom",
    legend.key.width = unit(2, "cm"),         # Wider color bar
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 9),
    legend.margin = margin(t = 10),            # Margin above legend
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(size = 11),
    plot.margin = margin(10, 10, 20, 10)       # Add space below plot
  )

# Question 3: Do air pollution-attributed death rates vary significantly 
# based on disease type across countries?

# Plot 5: Most prevalent diseases in China and India

#install.packages("patchwork")
library(patchwork)

# Summarize
china_data <- air_clean %>%
  filter(Location == "China") %>%
  group_by(Disease) %>%
  summarise(TotalDeaths = sum(DeathRate, na.rm = TRUE))

india_data <- air_clean %>%
  filter(Location == "India") %>%
  group_by(Disease) %>%
  summarise(TotalDeaths = sum(DeathRate, na.rm = TRUE))

# China plot
p1 <- ggplot(china_data, aes(x = reorder(Disease, TotalDeaths), y = TotalDeaths)) +
  geom_bar(stat = "identity", fill = "#1f77b4") +
  coord_flip() +
  labs(title = "China", x = "Disease", y = "Total Death Rate") +
  theme_minimal() +
  theme(panel.grid = element_blank())

# India plot
p2 <- ggplot(india_data, aes(x = reorder(Disease, TotalDeaths), y = TotalDeaths)) +
  geom_bar(stat = "identity", fill = "#bdbdbd") +
  coord_flip() +
  labs(title = "India", x = "Disease", y = "Total Death Rate") +
  theme_minimal() +
  theme(panel.grid = element_blank())

# Combine them side by side
p1 + p2 + plot_layout(ncol = 2) + plot_annotation(title = "Most Prevalent Diseases: China vs. India")

