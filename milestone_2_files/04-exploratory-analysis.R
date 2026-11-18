#SOCI502-Milestone 2: Exploratory Data Analysis (EDA)
#Author: Ally Finnerty

#Load packages
library(tidyverse)
library(here)
library(scales)
library(tidyr)

#Read in clean Metis data
clean_metis_data <- read_csv(
  here("milestone_2_files", "clean_data",
       "clean_metis_data.csv"))

#View cleaned dataset
print(clean_metis_data)

# GRAPH 1: Metis population by province and Census year
metis_pop_graph <- ggplot(
  clean_metis_data,
  aes(
    x = Province,
    y = Metis_Population,
    fill = factor(Census_Year))
) +
  geom_col(position = "dodge") +
  scale_fill_manual(
    values = c("2016" = "#F4A6C1",
               "2021" = "#9B59B6")
  ) +
  scale_y_continuous(labels = comma) +
  labs(
    title = "Métis Population in the Prairie Provinces",
    subtitle = "2016 and 2021 Canadian Census",
    x = "Province",
    y = "Métis Population",
    fill = "Census Year",
    caption = "Source: Statistics Canada, 2016 and 2021 Census"
  ) +
  theme_minimal()

print(metis_pop_graph)

# GRAPH 2: Absolute population increase

#Calculate population change between 2016 and 2021
metis_change <- clean_metis_data |>
  select(Province, Census_Year, Metis_Population) |>
  pivot_wider(
    names_from = Census_Year,
    values_from = Metis_Population,
    names_prefix = "Population_"
  ) |>
  mutate(
    Population_Increase = Population_2021 - Population_2016
  )

#View population change
print(metis_change)


#Graph 2: Absolute Metis population increase

metis_increase_graph <- ggplot(
  metis_change,
  aes(
    x = Province,
    y = Population_Increase
  )
) +
  geom_col(fill = "#9B59B6") +
  geom_text(
    aes(label = comma(Population_Increase)),
    vjust = -0.5
  ) +
  scale_y_continuous(
    labels = comma,
    expand = expansion(mult = c(0, 0.15))
  ) +
  labs(
    title = "Métis Population Increase by Province",
    subtitle = "Population change between 2016 and 2021",
    x = "Province",
    y = "Population Increase",
    caption = "Source: Statistics Canada, 2016 and 2021 Census"
  ) +
  theme_minimal()

print(metis_increase_graph)

# GRAPH 3: Percentage of population growth

#Calculate percentage growth in Metis population
metis_change <- metis_change |>
  mutate(
    Growth_Rate = 
      (Population_Increase / Population_2016) * 100)

#Graph it
metis_percent_graph <- ggplot(
  metis_change,
  aes(
    x = Province,
    y = Growth_Rate
  )
) +
  geom_col(fill = "#F4A6C1") +
  geom_text(
    aes(label = paste0(round(Growth_Rate, 2), "%")),
    vjust = -0.5
  ) +
  scale_y_continuous(
    labels = label_number(suffix = "%"),
    expand = expansion(mult = c(0, 0.15))
  ) +
  labs(
    title = "Métis Population Growth by Province",
    subtitle = "Percentage change between 2016 and 2021",
    x = "Province",
    y = "Population Growth (%)",
    caption = "Source: Statistics Canada, 2016 and 2021 Census"
  ) +
  theme_minimal()

print(metis_percent_graph)
