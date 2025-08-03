# kenyaCounties 0.1.0

* Initial release
* Added datasets for Kenya's 47 counties:
  - `governors`: Governor information and political parties
  - `county_boundaries`: Spatial boundaries with area calculations
  - `county_info`: Administrative information
  - `countyGCP`: Gross County Product data
  - `countyPopulation`: Population statistics
* Added helper functions:
  - `get_governor()`: Retrieve governor information
  - `get_county_boundary()`: Get spatial boundaries
  - `list_counties_by_party()`: Filter by political party
  - `county_stats()`: Summary statistics
  - `load_county_boundaries()`: Load shapefiles
  - `plot_county_map()`: Create county maps