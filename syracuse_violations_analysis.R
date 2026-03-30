#Syracuse Code Violations Final Project IST 719
#Author: Jessica Aimunmondion 

code <- read_csv("~/Library/Mobile Documents/com~apple~CloudDocs/GRAD SCHOOL/Fall 2025/IST 719 | Prof. Erdogan/Final Project/Code_Violations.csv")

#changing date column title
code <- code %>% 
  mutate(
    open_date = ymd_hms(open_date),
    comply_by_date = ymd_hms(comply_by_date)
  )

#removing duplicated rows
code <- code %>% distinct()

#violations per property 
violations_per_property <- code %>% 
  count(complaint_address, name = "violation_count")

#Plot 1: Histogram

#count violation types 
top10 <- code %>%
  count(violation, sort = TRUE) %>%
  slice_head(n = 10)

library(ggplot2)

ggplot(top10, aes(x = reorder(violation, n), y = n)) +
  geom_col(fill = "navy") +
  coord_flip() +
  labs(
    title = "Top 10 Most Common Code Violations in Syracuse",
    x = "Violation Type",
    y = "Count"
  ) +
  theme_minimal(base_size = 14)


#Plot 2: Syracuse Neighborhood w/ most violations
city_boundary <- st_read("~/Library/Mobile Documents/com~apple~CloudDocs/GRAD SCHOOL/Fall 2025/IST 719 | Prof. Erdogan/Syracuse_City_Boundary/Syracuse_City_Boundary.shp")
neighborhoods <- st_read("~/Library/Mobile Documents/com~apple~CloudDocs/GRAD SCHOOL/Fall 2025/IST 719 | Prof. Erdogan/Syracuse_Neighborhoods_8343203286223227545/Syracuse_Neighborhoods.shp")

#coordinate fix
code_clean <- code %>%
  filter(!is.na(Longitude), !is.na(Latitude))
code_sf <- code_clean %>%
  st_as_sf(coords = c("Longitude", "Latitude"), crs = 4326)

#Joining violations to neighborhoods 
code <- code %>%
  mutate(
    Neighborhood = str_to_title(Neighborhood)  # standardize names
  )
#neighb count violations 
neighborhood_counts <- code %>%
  filter(!is.na(Neighborhood), Neighborhood != "") %>%
  count(Neighborhood, name = "violation_count")

#joining to shapefile
neighborhoods_joined <- neighborhoods %>%
  left_join(neighborhood_counts,
            by = c("Name" = "Neighborhood"))

#transform crs to match neighborhoods
code_sf <- st_transform(code_sf, st_crs(neighborhoods))

#spatial join to assign neighborhood names
code_joined <- st_join(
  code_sf,
  neighborhoods[, "Name"],
  join = st_within
)

#choloropleth
library(sf)
library(dplyr)
library(ggplot2)

# 1. Convert cleaned data to sf points
code_sf <- code_clean %>%
  st_as_sf(coords = c("Longitude", "Latitude"), crs = 4326)

# 2. Match CRS to neighborhoods shapefile
code_sf <- st_transform(code_sf, st_crs(neighborhoods))

# 3. Spatial join to assign neighborhood names
code_joined <- st_join(
  code_sf,
  neighborhoods[, "Name"],
  join = st_within
)

# 4. Count violations per neighborhood
neighborhood_counts <- code_joined %>%
  st_drop_geometry() %>%
  count(Name, name = "violation_count")

# 5. Join counts back to polygons
neighborhoods_joined <- neighborhoods %>%
  left_join(neighborhood_counts, by = c("Name" = "Name"))

# 6. Centroids for neighborhood labels
neighborhood_labels <- neighborhoods_joined %>%
  st_point_on_surface() %>%
  mutate(label = Name)

# 7. Syracuse University point (manual coordinates)
su_point <- data.frame(
  name = "Syracuse University",
  Longitude = -76.1351,
  Latitude = 43.0392
) %>%
  st_as_sf(coords = c("Longitude", "Latitude"), crs = 4326) %>%
  st_transform(st_crs(neighborhoods))

# 8. FINAL CHOROPLETH WITH SU LABEL
ggplot() +
  geom_sf(
    data = city_boundary,
    fill = "grey95",
    color = "black",
    size = 0.3
  ) +
  
  geom_sf(
    data = neighborhoods_joined,
    aes(fill = violation_count),
    color = "white",
    size = 0.2
  ) +
  
  # neighborhood labels
  geom_sf_text(
    data = neighborhood_labels,
    aes(label = label),
    color = "white",
    size = 1.5,     # adjust smaller
    fontface = "bold",
    check_overlap = TRUE
  ) +
  
  # Syracuse University point
  geom_sf(
    data = su_point,
    color = "darkorange",
    size = 3,
    shape = 19
  ) +
  
  # Syracuse University label
  geom_sf_text(
    data = su_point,
    aes(label = name),
    color = "darkorange",
    size = 3,
    fontface = "bold",
    nudge_y = 0.002
  ) +
  
  scale_fill_gradientn(
    colours = c(
      "dodgerblue",  # low
      "blue",        # mid
      "navy"         # high
    ),
    na.value = "grey80",
    name = "Violations"
  ) +
  
  labs(
    title = "Code Violations Across Syracuse Neighborhoods",
    subtitle = "Choropleth with Neighborhood Labels and Syracuse University",
    fill = "Violations"
  ) +
  
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(size = 18, face = "bold"),
    panel.grid = element_blank()
  )

#Plot 3: Violations over time
#cleaning date 
library(lubridate)

#removing time zone
code_clean <- code_clean %>%
  mutate(
    violation_date_clean = gsub("\\+.*$", "", violation_date),   # remove +00
    violation_date_clean = gsub("\\.\\d+", "", violation_date_clean)  # remove .xxx
  )


code_clean <- code_clean %>%
  mutate(
    violation_date = parse_date_time(
      violation_date_clean,
      orders = c("Y/m/d H:M:S")
    )
  )

#monthly time series 
code_time <- code_clean %>%
  mutate(
    year_month = floor_date(violation_date, unit = "month")
  ) %>%
  count(year_month, name = "violation_count")

#violations over time 

ggplot(code_time, aes(x = year_month, y = violation_count)) +
  geom_line(color = "navyblue", size = 1) +
  geom_point(color = "darkorange", size = 1.5) +
  
  scale_x_datetime(
    date_breaks = "1 year",
    date_labels = "%Y",
    limits = c(
      as.POSIXct("2017-01-01", tz = "UTC"),
      as.POSIXct("2025-12-31", tz = "UTC")
    )
  ) +
  scale_y_continuous(n.breaks = 10) +
  labs(
    title = "Violations Over Time",
    subtitle = "Monthly trend of code violations in Syracuse",
    x = "Year",
    y = "Violations"
  ) +
  
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(size = 18, face = "bold"),
    panel.grid.minor = element_blank()
    
  )

#Plot 4: repeat offenders

#with neighborhood
offender_counts <- code_clean %>%
  filter(!is.na(complaint_address),
         complaint_address != "",
         !is.na(Neighborhood),
         Neighborhood != "") %>%
  count(complaint_address, Neighborhood, name = "violation_count") %>%
  arrange(desc(violation_count))

#top10 repeat offenders
top10_offenders <- offender_counts %>%
  slice_max(order_by = violation_count, n = 10)
#putting legend in order of neighborhood 
top10_offenders <- top10_offenders %>%
  mutate(
    Neighborhood = fct_inorder(Neighborhood)
  )


# reorder neighborhoods in top-10 order
top10_offenders <- top10_offenders %>%
  mutate(Neighborhood = fct_inorder(Neighborhood))

# repeat offenders colored by neighborhood 
neigh_colors <- c(
  "#001B38",  # deep navy but not too dark
  "#00305C",  # dark rich blue
  "#00467A",  # deep ocean blue
  "#005B9B",  # vibrant deep blue
  "#0070BB",  # bold medium blue
  "#1E89DC",  # vibrant but controlled blue
  "#48A5EF",  # lighter, still saturated blue
  "#7AC0F9",  # light bright blue
  "#A7D8FF",  # pale vibrant sky blue
  "#D6ECFF"   # lightest blue
)

# final lollipop plot
ggplot(top10_offenders, 
       aes(x = fct_reorder(complaint_address, violation_count),
           y = violation_count,
           color = Neighborhood)) +
  
  geom_segment(aes(xend = complaint_address, y = 0, yend = violation_count),
               color = "grey60", size = 1) +
  
  geom_point(size = 5) +
  
  scale_color_manual(values = neigh_colors) +
  
  coord_flip() +
  
  labs(
    title = "Top 10 Repeat Offender Addresses",
    subtitle = "Colored by Neighborhood",
    x = "Address",
    y = "Violations",
    color = "Neighborhood"
  ) +
  
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(size = 18, face = "bold"),
    legend.position = "right",
    panel.grid.minor = element_blank()
  )

#Plot 5
