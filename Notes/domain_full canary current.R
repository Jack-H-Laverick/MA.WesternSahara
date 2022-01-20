
Tidy_packages <- c("tidyverse", "sf", "rnaturalearth") # List handy data packages
lapply(Tidy_packages, library, character.only = TRUE)      # Load packages

Sahara <- readRDS("./Objects/Domains.rds")
Canary <- readRDS("../Canary Isles/Objects/Domains.rds")
SM <- readRDS("../Mauritania-Senegal/Objects/Domains.rds")

Cape <- st_linestring(matrix(c(-14, -16, 26.1, 28), ncol = 2, byrow = FALSE)) %>% 
  st_sfc() %>% 
  st_as_sf(label = "Cape Bojador", crs = 4326)

world <- ne_countries(scale = "medium", returnclass = "sf") %>%             # Get a world map
  st_transform(crs = crs)                                                   # Assign polar projection

#### Plot ####

ggplot() +
  #geom_sf(data = world, size = 0.1, fill = "black") +
  geom_sf(data = Sahara, fill = "yellow", colour = "black", size = 0.1) +
  geom_sf(data = Canary, fill = "blue", colour = "black", size = 0.1) +
  geom_sf(data = SM, fill = "green", colour = "black", size = 0.1) +
  geom_sf(data = Cape, colour = "red") +
  coord_sf(xlim = c(-23, -10), ylim = c(11, 33), expand = F) + # Specify the plotting window for SF maps   theme_minimal() +
  labs(caption = "All 3 Canary current implementations, red line is Cape Bojador.") +
  theme_minimal() +
  NULL

ggsave("./Notes/Whole canary current.png")
