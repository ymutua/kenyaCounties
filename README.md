# kenyaCounties

An R package providing comprehensive data about Kenya's 47 county governments.

## Installation

```r
# Install from GitHub (when available)
devtools::install_github("ymutua/kenyaCounties")

# Or install locally
# devtools::install_local("path/to/kenyaCounties")
```

## Features

- **Governor Information**: Current and former governors, deputy governors, political parties
- **Spatial Data**: County boundaries as sf objects with area calculations
- **Administrative Data**: Sub-counties, wards, constituencies, establishment dates
- **Helper Functions**: Easy data access and filtering functions

## Usage

```r
library(kenyaCounties)

# Get all governors
governors

# Get specific governor information
get_governor("Nairobi")
get_governor(county_code = 47)

# Get county boundaries
county_boundaries
get_county_boundary("Mombasa")

# List counties by political party
list_counties_by_party("UDA")

# Get county statistics
county_stats()
```

## Data Sources

- Kenya Electoral Commission
- Kenya National Bureau of Statistics
- County Government websites
- Survey of Kenya

## Datasets

1. **governors**: Governor and deputy governor information
2. **county_boundaries**: Spatial boundaries (sf objects)
3. **county_info**: Administrative information

## Contributing

Please feel free to contribute by:
- Adding missing data
- Updating governor information
- Improving spatial accuracy
- Adding new features