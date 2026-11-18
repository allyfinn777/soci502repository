#SOCI502-Milestone 2: Testing Data
#Author: Ally Finnerty

#Load packages
library(tidyverse)
library(here)

#Read in clean metis data CSV
clean_metis_data <- read_csv(
  here("milestone_2_files", "clean_data", 
       "clean_metis_data.csv"))

# TEST 1: Check provinces and Census years

#Each province should appear once in 2016 and once in 2021.

stopifnot(
  nrow(clean_metis_data) == 6,
  setequal(
    clean_metis_data$Province,
    c("Manitoba", "Saskatchewan", "Alberta")),
  setequal(
    clean_metis_data$Census_Year,
    c(2016, 2021)),
  !anyDuplicated(
    clean_metis_data[c("Province", "Census_Year")]))

print("Test 1 passed! All provinces and Census years are correct.")

# TEST 2: Check population values

#Population values should not be missing or negative.
#The Métis population cannot exceed the total provincial population.

stopifnot(
  !anyNA(clean_metis_data),
  all(clean_metis_data$Metis_Population >= 0),
  all(clean_metis_data$Total_Population > 0),
  all(
    clean_metis_data$Metis_Population <=
      clean_metis_data$Total_Population))

print("Test 2 passed! All population values are valid.")

# TEST 3: Check original population counts

#Read in the original raw census datasets

raw_metis_2016 <- read_csv(
  here("milestone_2_files", "raw_data",
       "raw_metis_2016.csv"))

raw_metis_2021 <- read_csv(
  here("milestone_2_files", "raw_data",
       "raw_metis_2021.csv"))

#Calculate the original Metis population totals for each Census year

raw_total_2016 <- sum(
  raw_metis_2016$`v_CA16_3864: Métis`)

raw_total_2021 <- sum(
  raw_metis_2021$`v_CA21_4213: Métis`)

#Calculate the cleaned Metis population totals for each Census year

clean_total_2016 <- clean_metis_data |>
  filter(Census_Year == 2016) |>
  summarise(Total = sum(Metis_Population)) |>
  pull(Total)

clean_total_2021 <- clean_metis_data |>
  filter(Census_Year == 2021) |>
  summarise(Total = sum(Metis_Population)) |>
  pull(Total)

#Check that the raw and cleaned totals match

stopifnot(
  raw_total_2016 == clean_total_2016,
  raw_total_2021 == clean_total_2021)

print("Test 3 passed! Raw and cleaned population totals match.")

#If all tests complete
print("All tests passed successfully!")
