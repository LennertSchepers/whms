library(sf)
library(mapview)

whms <- read_sf("https://geo.vliz.be/geoserver/MarineRegions/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=MarineRegions%3Aworldheritagemarineprogramme&maxFeatures=1000&outputFormat=application/json")
mapview(whms)

whms_df <- st_drop_geometry(whms)
write.csv(whms_df, "whms.csv",
          row.names = FALSE)
