#SOCI502-Milestone 2: Cleaning Data
#Author: Ally Finnerty

#Load packages
library(tidyverse)
library(here)

#Read raw Census data
raw_metis_2016 <- read_csv(
  here("milestone_2_files", "raw_data",
       "raw_metis_2016.csv"))

raw_metis_2021 <- read_csv(
  here("milestone_2_files", "raw_data",
       "raw_metis_2021.csv"))

#Clean 2016 Census data

clean_metis_2016 <- raw_metis_2016 |>
  select(
    Province = `Region Name`,
    Total_Population = Population,
    Metis_Population = `v_CA16_3864: Métis`
  ) |>
  mutate(Census_Year = 2016)

#Clean 2021 Census data

clean_metis_2021 <- raw_metis_2021 |>
  select(
    Province = `Region Name`,
    Total_Population = Population,
    Metis_Population = `v_CA21_4213: Métis`) |>
  mutate(Census_Year = 2021)

#Combine both Census years

clean_metis_data <- bind_rows(
  clean_metis_2016,
  clean_metis_2021)

#Clean up province names

clean_metis_data <- clean_metis_data |>
  mutate(
    Province = str_remove(Province, " \\(.*\\)")) |>
  select(
    Province,
    Census_Year,
    Total_Population,
    Metis_Population) |>
  arrange(Province, Census_Year)

#view cleaned dataset
print(clean_metis_data)

#Save the cleaned data in a new folder
dir.create(
  here("milestone_2_files", "clean_data"),
  showWarnings = FALSE)

#Save the cleaned dataset
write_csv(
  clean_metis_data,
  here("milestone_2_files", "clean_data",
       "clean_metis_data.csv"))
