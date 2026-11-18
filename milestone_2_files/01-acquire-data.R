# SOCI502-Milestone 2: Acquire Data
# Author: Ally Finnerty

#Load packages
library(tidyverse)
library(cancensus)
library(here)

# Create a folder to store the raw data
dir.create(here("milestone_2_files", "raw_data"), showWarnings = FALSE)

#2016 Census Data
#I will come back here to read in more regions 
#to compare rural and urban centres

raw_metis_2016 <- get_census(
  dataset = "CA16",
  regions = list(
    PR = c("46", "47", "48")),
  vectors = c("v_CA16_3864"),
  level = "PR")

#View raw 2016 data
raw_metis_2016

#2021 Census Data

raw_metis_2021 <- get_census(
  dataset = "CA21",
  regions = list(
    PR = c("46", "47", "48")),
  vectors = c("v_CA21_4213"),
  level = "PR")

#View raw 2021 data
raw_metis_2021

#Save raw data as CSV files
write_csv(
  raw_metis_2016,
  here("milestone_2_files", "raw_data", "raw_metis_2016.csv"))

write_csv(
  raw_metis_2021,
  here("milestone_2_files", "raw_data", "raw_metis_2021.csv"))

#Check that both files saved
list.files(here("milestone_2_files","raw_data"))
