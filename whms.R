library(dplyr)
library(sf)
library(mapview)


whms <- read_sf("https://geo.vliz.be/geoserver/MarineRegions/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=MarineRegions%3Aworldheritagemarineprogramme&maxFeatures=1000&outputFormat=application/json")
mapview(whms)

whms_df <- st_drop_geometry(whms)
write.csv(whms_df, "whms.csv",
          row.names = FALSE)

# merge sites and buffers
sf_use_s2(FALSE) # otherwise error https://github.com/r-spatial/sf/issues/1762
whms_merged <- whms %>%
  group_by(full_name) %>%
  summarize(area_km2 = sum(area_km2),
            mrgid = first(mrgid),
            refid = first(refid)) %>%
  st_drop_geometry()
write.csv(whms_merged, "whms_merged.csv",
          row.names = FALSE)
