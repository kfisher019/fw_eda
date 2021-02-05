# authenticate for GCP
bq_auth(path=Sys.getenv('gcp_credentials')) 
gcs_auth(Sys.getenv('gcp_credentials')) 
# data-science
# bq connection
prodcon <- dbConnect(
  bigrquery::bigquery(),
  project = "freightwaves-engineering-prod")
# read in polygons
#---> zip3 polygons! <---#
d1 <- tbl(prodcon, 'warehouse.zip3_voronoi') %>%
  collect()
v1 <- tbl(prodcon, 'warehouse.geo_zip3ptgrid') %>%
  collect()


library(tmap)
tmap_mode("view")
d1 %>%
  sf::st_as_sf(wkt = "geom") %>%
  tm_shape() +
  tm_polygons()

d1 %>%
  sf::st_as_sf(wkt = "geom",crs = 4326) %>%
  filter(zip3 %in% c('307','373','374')) %>%
  tm_shape() +
  tm_polygons('zip3')

d1 %>%
  sf::st_as_sf(wkt = "geom",crs = 4326) %>%
  filter(zip3 %in% c('307','373','374')) %>%
  tm_shape() +
  tm_polygons('zip3',alpha=0.3) +
  tm_basemap("Stamen.TonerLite")

# from Scott:
#https://cran.r-project.org/web/packages/tmap/vignettes/tmap-getstarted.html
# from Brad:
#https://cran.r-project.org/web/packages/sf/vignettes/sf5.html
# from me:
# https://geocompr.robinlovelace.net/spatial-class.html
tm_mode("plot")