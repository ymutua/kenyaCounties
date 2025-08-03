#' Kenya County Governors Data
#'
#' A dataset containing information about current and former governors of Kenya's 47 counties.
#'
#' @format A data frame with variables:
#' \describe{
#'   \item{county_code}{Numeric county code (1-47)}
#'   \item{county_name}{Name of the county}
#'   \item{governor_name}{Full name of the governor (2017-2022 term)}
#'   \item{political_party}{Political party of the governor}
#'   \item{deputy_governor_name}{Full name of the deputy governor}
#'   \item{term_start}{Start date of term (YYYY-MM-DD)}
#'   \item{term_end}{End date of term (YYYY-MM-DD)}
#'   \item{previous_governor}{Name of previous governor (if applicable)}
#'   \item{election_year}{Year of election}
#' }
#' @source Kenya Electoral Commission, County Government websites
"governors"

#' Kenya County Spatial Boundaries
#'
#' Spatial polygons (sf object) representing the boundaries of Kenya's 47 counties.
#'
#' @format An sf data frame with variables:
#' \describe{
#'   \item{county_code}{Numeric county code (1-47)}
#'   \item{county_name}{Name of the county}
#'   \item{area_km2}{Area of county in square kilometers}
#'   \item{geometry}{Spatial geometry (polygon)}
#' }
#' @source Kenya National Bureau of Statistics, Survey of Kenya
"county_boundaries"

#' Kenya County Administrative Information
#'
#' Administrative and demographic information for Kenya's counties.
#'
#' @format A data frame with variables:
#' \describe{
#'   \item{county_code}{Numeric county code (1-47)}
#'   \item{county_name}{Name of the county}
#'   \item{county_capital}{County capital/headquarters}
#'   \item{established_date}{Date county government was established}
#' }
#' @source Kenya National Bureau of Statistics
"county_info"

#' Kenya Gross County Product Data
#'
#' Economic data showing Gross County Product for Kenya's counties.
#'
#' @format A data frame with economic indicators
#' @source Kenya National Bureau of Statistics
"countyGCP"

#' Kenya County Population Data
#'
#' Population statistics for Kenya's counties.
#'
#' @format A data frame with population data
#' @source Kenya National Bureau of Statistics, Census data
"countyPopulation"