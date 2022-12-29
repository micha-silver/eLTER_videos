## ----relter-loading, message=FALSE, warning=FALSE------------------------------------
if (!require("ReLTER", quietly = TRUE))
  remotes::install_github("ropensci/ReLTER")

# Convenient way to load list of additional packages
pkg_list <- c("sf", "terra", "ReLTER", "tmap")
lapply(pkg_list,require, character.only = TRUE)
tmap_options(check.and.fix = TRUE)
tmap_mode("view")


## ----relter-maintainer---------------------------------------------------------------
library(ReLTER)
maintainer("ReLTER")


## ----relter-citation-----------------------------------------------------------------
citation("ReLTER")


## ----relter-functions----------------------------------------------------------------
head(ls("package:ReLTER"), 20)


## ----relter-donana-------------------------------------------------------------------
donana = get_ilter_generalinfo(country_name = "Spain",
                              site_name = "Doñana")
(donana_id = donana$uri)


## ----relter-plot-donana--------------------------------------------------------------
donana_polygon <- get_site_info(donana_id, category = "Boundaries")
tm_basemap("OpenStreetMap.Mapnik") + 
  tm_shape(donana_polygon) +
  tm_fill(col = "blue", alpha = 0.3)


## ----relter-species-donana-----------------------------------------------------------
species_occur <-  get_site_speciesOccurrences(donana_id,
                                              list_DS = "gbif", limit=10)

# Variables available from GBIF:
colnames(species_occur$gbif)


## ----relter-species-variables--------------------------------------------------------
dplyr::select(species_occur$gbif, name, eventDate)


## ----relter-kinord-info--------------------------------------------------------------
loch_kinord <- get_ilter_generalinfo(country_name = "United K",
                              site_name = "Loch Kinord")
(loch_kinord_id = loch_kinord$uri)
loch_kinord_details <- get_site_info(loch_kinord_id,
                                 c("Contacts", "EnvCharacts", "Parameters"))

print(paste("Site manager:",
            loch_kinord_details$generalInfo.siteManager[[1]]['name'],
            loch_kinord_details$generalInfo.siteManager[[1]]['email']))


## ----relter-kinord-envcharacteristics------------------------------------------------
print(paste("Annual average air temperature:",
            loch_kinord_details$envCharacteristics.airTemperature.yearlyAverage))
print(paste("Annual precipitation:",
            loch_kinord_details$envCharacteristics.precipitation.yearlyAverage))


## ----relter-kinord-geobonbiome-------------------------------------------------------
print(paste("GeoBonBiome: ",
            loch_kinord_details$envCharacteristics.geoBonBiome))

loch_kinord_vegetation <- loch_kinord_details$envCharacteristics.vegetation
cat("Vegetation: \n", stringr::str_wrap(loch_kinord_vegetation, 70))


## ----elter-slovakia------------------------------------------------------------------
lter_slovakia_id = "https://deims.org/networks/3d6a8d72-9f86-4082-ad56-a361b4cdc8a0"
lter_slovakia_sites <- get_network_sites(lter_slovakia_id)
lter_slovakia_sites$title


## ----relter-slovakia-map-------------------------------------------------------------
lter_slovakia <- produce_network_points_map(lter_slovakia_id, "SVK")
svk <- readRDS("gadm36_SVK_0_sp.rds")  # downloaded by produce_network_points_map()
tm_basemap("OpenStreetMap.Mapnik") + 
  lter_slovakia + 
  tm_shape(svk) +   tm_borders(col = "blue", lwd = 1) + 
  tm_scale_bar(position = c("right", "bottom"))

