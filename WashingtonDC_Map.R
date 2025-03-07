install.packages("sf")
install.packages("tmap")
install.packages("tidyverse")

library(sf)
library(tmap)
library(tidyverse)


df_dec_04 <- read.csv("./Data/WMATA_Ridership_Summary.xlsx - December_04_2024.csv")
df_dec_21 <- read.csv("./Data/WMATA_Ridership_Summary.xlsx - December_21_2024.csv")
df_jun_05 <- read.csv("./Data/WMATA_Ridership_Summary.xlsx - June_05_2024.csv")
df_jun_15 <- read.csv("./Data/WMATA_Ridership_Summary.xlsx - June_15_2024.csv")
df_mar_06 <- read.csv("./Data/WMATA_Ridership_Summary.xlsx - March_6_2024.csv")
df_mar_23 <- read.csv("./Data/WMATA_Ridership_Summary.xlsx - March_23_2024.csv")
df_sep_04 <- read.csv("./Data/WMATA_Ridership_Summary.xlsx - September_4_2024.csv")
df_sep_21 <- read.csv("./Data/WMATA_Ridership_Summary.xlsx - September_21_2024.csv")
df_lat_long <- read.csv("./Spatial Data/Longitude _ Latitude for Stations.csv")

dc_boundary <- st_read("./Spatial Data/Washington_DC_Boundary/Washington_DC_Boundary.shp")

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

# trend: metro station location vs amount of people that use the metro among all 8 days
all_8_days_avg <- df_lat_long %>%
  full_join(total_dec_04_df, by = "Station.Name") %>%
  full_join(total_dec_21_df, by = "Station.Name") %>%
  full_join(total_jun_05_df, by = "Station.Name") %>%
  full_join(total_jun_15_df, by = "Station.Name") %>%
  full_join(total_mar_06_df, by = "Station.Name") %>%
  full_join(total_mar_23_df, by = "Station.Name") %>%
  full_join(total_sep_04_df, by = "Station.Name") %>%
  full_join(total_sep_21_df, by = "Station.Name")

all_8_days_avg <- all_8_days_avg %>%
  mutate(avg.x.x = replace_na(avg.x.x, 0),
         avg.y.y = replace_na(avg.y.y, 0))

all_8_days_avg <- all_8_days_avg %>% 
  mutate(row_sum = rowSums(select(., -Station.Name, -Longitude, -Latitude))) %>%
  mutate(total_avg = row_sum / 8)


#--
stations <- data.frame(
  id = 1:98,
  name = all_8_days_avg$Station.Name,
  longitude = all_8_days_avg$Longitude,
  latitude = all_8_days_avg$Latitude,
  Attendees = all_8_days_avg$total_avg
)

stations_sf <- st_as_sf(stations, coords = c("longitude", "latitude"), crs = 4326)


tmap_mode("view")

# map
tm_shape(dc_boundary) +
  tm_shape(stations_sf) +
  tm_bubbles(size = "Attendees", col ="blue", alpha = 0.5) +
  tm_borders() +
  tm_basemap("OpenStreetMap")

# trend: the difference in people between weekdays and weekends per location of the metro station
all_weekdays_avg <- df_lat_long %>%
  full_join(total_dec_04_df, by = "Station.Name") %>%
  full_join(total_jun_05_df, by = "Station.Name") %>%
  full_join(total_mar_06_df, by = "Station.Name") %>%
  full_join(total_sep_04_df, by = "Station.Name") 

all_weekdays_avg <- all_weekdays_avg %>%
  mutate(avg.y = replace_na(avg.y, 0))

all_weekdays_avg <- all_weekdays_avg %>% 
  mutate(row_sum = rowSums(select(., -Station.Name, -Longitude, -Latitude))) %>%
  mutate(total_avg = row_sum / 4)

#--
stations <- data.frame(
  id = 1:98,
  name = all_weekdays_avg$Station.Name,
  longitude = all_weekdays_avg$Longitude,
  latitude = all_weekdays_avg$Latitude,
  Attendees = all_weekdays_avg$total_avg
)

stations_sf <- st_as_sf(stations, coords = c("longitude", "latitude"), crs = 4326)


tmap_mode("view")

# map
tm_shape(dc_boundary) +
  tm_shape(stations_sf) +
  tm_bubbles(size = "Attendees", col ="blue", alpha = 0.5) +
  tm_borders() +
  tm_basemap("OpenStreetMap")

#-------------------------------------------------------------------------------

all_weekends_avg <- df_lat_long %>%
  full_join(total_dec_21_df, by = "Station.Name") %>%
  full_join(total_jun_15_df, by = "Station.Name") %>%
  full_join(total_mar_23_df, by = "Station.Name") %>%
  full_join(total_sep_21_df, by = "Station.Name")

all_weekends_avg <- all_weekends_avg %>%
  mutate(avg.y = replace_na(avg.y, 0))

all_weekends_avg <- all_weekends_avg %>% 
  mutate(row_sum = rowSums(select(., -Station.Name, -Longitude, -Latitude))) %>%
  mutate(total_avg = row_sum / 4)

#--
stations <- data.frame(
  id = 1:98,
  name = all_weekends_avg$Station.Name,
  longitude = all_weekends_avg$Longitude,
  latitude = all_weekends_avg$Latitude,
  Attendees = all_weekends_avg$total_avg
)

stations_sf <- st_as_sf(stations, coords = c("longitude", "latitude"), crs = 4326)


tmap_mode("view")

# map
tm_shape(dc_boundary) +
  tm_shape(stations_sf) +
  tm_bubbles(size = "Attendees", col ="blue", alpha = 0.5) +
  tm_borders() +
  tm_basemap("OpenStreetMap")

#-------------------------------------------------------------------------------

