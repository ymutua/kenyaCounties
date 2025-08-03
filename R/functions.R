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

#' Get County Population Data
#'
#' Retrieve population data for a specific county or all counties.
#'
#' @param county_name Character. Name of the county (optional)
#' @param county_code Numeric. County code 1-47 (optional)
#' @return A data frame with population data
#' @export
#' @examples
#' get_county_population("Nairobi")
#' get_county_population(county_code = 47)
get_county_population <- function(county_name = NULL, county_code = NULL) {
  if (!is.null(county_name)) {
    return(countyPopulation[countyPopulation$county_name == county_name, ])
  }
  if (!is.null(county_code)) {
    return(countyPopulation[countyPopulation$county_code == county_code, ])
  }
  return(countyPopulation)
}

#' Get Comprehensive County Data
#'
#' Retrieve multiple datasets for one or more counties based on specified arguments.
#'
#' @param county_name Character vector. Name(s) of the county/counties (optional)
#' @param county_code Numeric vector. County code(s) 1-47 (optional)
#' @param population Logical. Include population data (default: FALSE)
#' @param GCP Logical. Include Gross County Product data (default: FALSE)
#' @param years Numeric vector. Specific years to include (optional, returns all if NULL)
#' @return A merged data frame with requested data
#' @export
#' @examples
#' get_county_data("Nairobi", population = TRUE, GCP = TRUE)
#' get_county_data(county_code = 47, population = TRUE, years = c(2019, 2020))
#' get_county_data(c("Nairobi", "Mombasa"), GCP = TRUE, years = 2015:2020)
#' get_county_data(county_code = c(1, 2, 47), population = TRUE)
get_county_data <- function(county_name = NULL, county_code = NULL, population = FALSE, GCP = FALSE, years = NULL) {
  # Start with basic county info
  if (!is.null(county_name)) {
    result <- county_info[county_info$county_name %in% county_name, ]
  } else if (!is.null(county_code)) {
    result <- county_info[county_info$county_code %in% county_code, ]
  } else {
    result <- county_info
  }
  
  # Add population data if requested
  if (population) {
    pop_data <- if (!is.null(county_name)) {
      countyPopulation[countyPopulation$county_name %in% county_name, ]
    } else if (!is.null(county_code)) {
      countyPopulation[countyPopulation$county_code %in% county_code, ]
    } else {
      countyPopulation
    }
    
    # Filter by years if specified
    if (!is.null(years)) {
      year_cols <- intersect(as.character(years), names(pop_data))
      if (length(year_cols) > 0) {
        pop_data <- pop_data[, c("county_code", "county_name", year_cols)]
      }
    }
    
    result <- merge(result, pop_data, by = "county_code", all.x = TRUE)
  }
  
  # Add GCP data if requested
  if (GCP) {
    gcp_data <- if (!is.null(county_name)) {
      countyGCP[countyGCP$county_name %in% county_name, ]
    } else if (!is.null(county_code)) {
      countyGCP[countyGCP$county_code %in% county_code, ]
    } else {
      countyGCP
    }
    
    # Filter by years if specified
    if (!is.null(years)) {
      year_cols <- intersect(as.character(years), names(gcp_data))
      if (length(year_cols) > 0) {
        gcp_data <- gcp_data[, c("county_code", "county_name", year_cols)]
      }
    }
    
    result <- merge(result, gcp_data, by = "county_code", all.x = TRUE)
  }
  
  return(result)
}