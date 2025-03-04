install.packages("sf")
install.packages("tmap")
install.packages("tidyverse")

library(sf)
library(tmap)
library(tidyverse)

dc_boundary <- st_read("./Washington_DC_Boundary/Washington_DC_Boundary.shp")

stations <- data.frame(
  id = 1:5,
  name = c("Woodley Park", "Wiehle-Reston East", "Wheaton", "West Hyattsville", "West Falls Church"),
  longitude = c(-77.05242321, -77.34012166, -77.05031694, -76.96931636, -77.18893041),
  latitude = c(38.92470253, 38.94809156, 39.03887999, 38.95565362, 38.90102198),
  visitors = c(500, 1200, 800, 300, 1500)
)

# Convert the data frame to an `sf` object
stations_sf <- st_as_sf(stations, coords = c("longitude", "latitude"), crs = 4326)


tmap_mode("view")

# Create a map
tm_shape(dc_boundary) +
  tm_shape(stations_sf) +
  tm_bubbles(size = "visitors", col ="blue", alpha = 0.5) +
  tm_borders() +
  tm_basemap("OpenStreetMap")


df_dec_04 <- read.csv("./Data/WMATA_Ridership_Summary.xlsx - December_04_2024.csv")
df_dec_21 <- read.csv("./Data/WMATA_Ridership_Summary.xlsx - December_21_2024.csv")
df_jun_05 <- read.csv("./Data/WMATA_Ridership_Summary.xlsx - June_05_2024.csv")
df_jun_15 <- read.csv("./Data/WMATA_Ridership_Summary.xlsx - June_15_2024.csv")
df_mar_06 <- read.csv("./Data/WMATA_Ridership_Summary.xlsx - March_6_2024.csv")
df_mar_23 <- read.csv("./Data/WMATA_Ridership_Summary.xlsx - March_23_2024.csv")
df_sep_04 <- read.csv("./Data/WMATA_Ridership_Summary.xlsx - September_4_2024.csv")
df_sep_21 <- read.csv("./Data/WMATA_Ridership_Summary.xlsx - September_21_2024.csv")

total_dec_04_df <- df_dec_04 %>%
  # to change of the type of the column to numeric and remove the K
  mutate(Avg.Daily.Entries = as.numeric(gsub("K", "", Avg.Daily.Entries))) %>%
  group_by(Station.Name) %>%
  summarise(avg = mean(Avg.Daily.Entries, na.rm = TRUE)*1000)

total_dec_21_df <- df_dec_21 %>%
  mutate(Avg.Daily.Entries = as.numeric(gsub("K", "", Avg.Daily.Entries))) %>%
  group_by(Station.Name) %>%
  summarise(avg = mean(Avg.Daily.Entries, na.rm = TRUE)*1000)

total_jun_05_df <- df_jun_05 %>%
  mutate(Avg.Daily.Entries = as.numeric(gsub("K", "", Avg.Daily.Entries))) %>%
  group_by(Station.Name) %>%
  summarise(avg = mean(Avg.Daily.Entries, na.rm = TRUE)*1000)

total_jun_15_df <- df_jun_15 %>%
  mutate(Avg.Daily.Entries = as.numeric(gsub("K", "", Avg.Daily.Entries))) %>%
  group_by(Station.Name) %>%
  summarise(avg = mean(Avg.Daily.Entries, na.rm = TRUE)*1000)

total_mar_06_df <- df_mar_06 %>%
  mutate(Avg.Daily.Entries = as.numeric(gsub("K", "", Avg.Daily.Entries))) %>%
  group_by(Station.Name) %>%
  summarise(avg = mean(Avg.Daily.Entries, na.rm = TRUE)*1000)

total_mar_23_df <- df_mar_23 %>%
  mutate(Avg.Daily.Entries = as.numeric(gsub("K", "", Avg.Daily.Entries))) %>%
  group_by(Station.Name) %>%
  summarise(avg = mean(Avg.Daily.Entries, na.rm = TRUE)*1000)

total_sep_04_df <- df_sep_04 %>%
  mutate(Avg.Daily.Entries = as.numeric(gsub("K", "", Avg.Daily.Entries))) %>%
  group_by(Station.Name) %>%
  summarise(avg = mean(Avg.Daily.Entries, na.rm = TRUE)*1000)

total_sep_21_df <- df_sep_21 %>%
  mutate(Avg.Daily.Entries = as.numeric(gsub("K", "", Avg.Daily.Entries))) %>%
  group_by(Station.Name) %>%
  summarise(avg = mean(Avg.Daily.Entries, na.rm = TRUE)*1000)

all_8_day_avg <- total_dec_04_df %>%
  full_join(total_dec_21_df, by = "Station.Name") %>%
  full_join(total_jun_05_df, by = "Station.Name") %>%
  full_join(total_jun_15_df, by = "Station.Name") %>%
  full_join(total_mar_06_df, by = "Station.Name") %>%
  full_join(total_mar_23_df, by = "Station.Name") %>%
  full_join(total_sep_04_df, by = "Station.Name") %>%
  full_join(total_sep_21_df, by = "Station.Name")

#doesn't work!
all_8_day_avg_test <- total_dec_04_df %>%
  full_join(total_dec_21_df, by = "Station.Name") %>%
  mutate(avg = avg.x + avg.y) %>%
  select(-avg.x, -avg.y) %>%
  full_join(total_jun_05_df, by = "Station.Name") %>%
  mutate(avg = avg + avg.x) %>%
  select(-avg.x) %>%
  full_join(total_jun_15_df, by = "Station.Name") %>%
  mutate(avg = avg + avg.x) %>%
  select(-avg.x) %>%
  full_join(total_mar_06_df, by = "Station.Name") %>%
  mutate(avg = avg + avg.x) %>%
  select(-avg.x) %>%
  full_join(total_mar_23_df, by = "Station.Name") %>%
  mutate(avg = avg + avg.x) %>%
  select(-avg.x) %>%
  full_join(total_sep_04_df, by = "Station.Name") %>%
  mutate(avg = avg + avg.x) %>%
  select(-avg.x) %>%
  full_join(total_sep_21_df, by = "Station.Name") %>%
  mutate(avg = avg + avg.x)

