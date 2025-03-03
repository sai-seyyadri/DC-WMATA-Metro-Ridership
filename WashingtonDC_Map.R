install.packages("sf")
install.packages("tmap")

library(sf)
library(tmap)

dc_boundary <- st_read("/Users/roshan/Downloads/Washington_DC_Boundary/Washington_DC_Boundary.shp")

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

