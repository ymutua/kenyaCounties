#' Get Governor Information by County
#'
#' Retrieve governor information for a specific county or all counties.
#'
#' @param county_name Character. Name of the county (optional)
#' @param county_code Numeric. County code 1-47 (optional)
#' @return A data frame with governor information
#' @export
#' @examples
#' get_governor("Nairobi")
#' get_governor(county_code = 47)
get_governor <- function(county_name = NULL, county_code = NULL) {
  if (!is.null(county_name)) {
    return(governors[governors$county_name == county_name, ])
  }
  if (!is.null(county_code)) {
    return(governors[governors$county_code == county_code, ])
  }
  return(governors)
}

#' Get County Boundary
#'
#' Retrieve spatial boundary for a specific county or all counties.
#'
#' @param county_name Character. Name of the county (optional)
#' @param county_code Numeric. County code 1-47 (optional)
#' @return An sf object with county boundaries
#' @export
#' @examples
#' get_county_boundary("Nairobi")
#' get_county_boundary(county_code = 47)
get_county_boundary <- function(county_name = NULL, county_code = NULL) {
  if (!requireNamespace("sf", quietly = TRUE)) {
    stop("sf package is required for spatial operations")
  }
  
  if (!is.null(county_name)) {
    return(county_boundaries[county_boundaries$county_name == county_name, ])
  }
  if (!is.null(county_code)) {
    return(county_boundaries[county_boundaries$county_code == county_code, ])
  }
  return(county_boundaries)
}

#' List Counties by Political Party
#'
#' Get counties grouped by the political party of their governors.
#'
#' @param party Character. Political party name (optional)
#' @return A data frame with counties and their governors' parties
#' @export
#' @examples
#' list_counties_by_party("UDA")
#' list_counties_by_party()
list_counties_by_party <- function(party = NULL) {
  if (!is.null(party)) {
    return(governors[governors$political_party == party, c("county_name", "governor_name", "political_party")])
  }
  return(governors[, c("county_name", "governor_name", "political_party")])
}

#' Calculate County Statistics
#'
#' Get summary statistics about counties (area, population, etc.).
#'
#' @return A data frame with county statistics
#' @export
#' @examples
#' county_stats()
county_stats <- function() {
  if (!requireNamespace("sf", quietly = TRUE)) {
    stop("sf package is required for spatial operations")
  }
  
  merged_data <- merge(county_boundaries, countyPopulation, by = "county_code")
  stats <- data.frame(
    total_counties = nrow(merged_data),
    total_area_km2 = sum(merged_data$area_km2, na.rm = TRUE),
    total_population_2019 = sum(merged_data$`2019`, na.rm = TRUE),
    avg_area_km2 = mean(merged_data$area_km2, na.rm = TRUE),
    avg_population_2019 = mean(merged_data$`2019`, na.rm = TRUE)
  )
  return(stats)
}