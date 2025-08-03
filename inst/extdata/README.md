# External Data

Place your spatial data files here:

## Required Files:
- `kenya_counties.shp` - County boundary shapefile
- `kenya_counties.shx` - Shapefile index
- `kenya_counties.dbf` - Attribute data
- `kenya_counties.prj` - Projection information

## Data Sources:
- Kenya National Bureau of Statistics
- Survey of Kenya
- Kenya Open Data Portal

## Usage:
```r
# Load boundaries from shapefile
boundaries <- load_county_boundaries("inst/extdata/kenya_counties.shp")

# Save as package data
usethis::use_data(county_boundaries, overwrite = TRUE)
```