#' Load County Boundaries from Shapefile
#'
#' Helper function to load and prepare county boundary spatial data.
#'
#' @param shapefile_path Character. Path to the county boundaries shapefile
#' @param county_code_col Character. Name of county code column in shapefile
#' @param county_name_col Character. Name of county name column in shapefile
#' @return An sf object with county boundaries
#' @export
#' @examples
#' \dontrun{
#' boundaries <- load_county_boundaries("data-raw/kenya_counties.shp")
#' }
load_county_boundaries <- function(shapefile_path, 
                                  county_code_col = "COUNTY_COD", 
                                  county_name_col = "COUNTY_NAM") {
  if (!file.exists(shapefile_path)) {
    stop("Shapefile not found at: ", shapefile_path)
  }
  
  boundaries <- sf::st_read(shapefile_path, quiet = TRUE)
  
  # Standardize column names
  boundaries <- boundaries %>%
    dplyr::rename(
      county_code = !!county_code_col,
      county_name = !!county_name_col
    ) %>%
    dplyr::mutate(
      area_km2 = as.numeric(sf::st_area(.) / 1000000),
      county_code = as.numeric(county_code)
    ) %>%
    dplyr::select(county_code, county_name, area_km2, geometry)
  
  return(boundaries)
}

#' Plot County Map
#'
#' Create a simple map of Kenya counties.
#'
#' @param county_boundaries sf object with county boundaries
#' @param fill_var Character. Variable to use for fill color (optional)
#' @return A ggplot object
#' @export
#' @examples
#' \dontrun{
#' plot_county_map(county_boundaries)
#' }
plot_county_map <- function(county_boundaries, fill_var = NULL) {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("ggplot2 package is required for plotting")
  }
  
  p <- ggplot2::ggplot(county_boundaries) +
    ggplot2::geom_sf(color = "white", size = 0.2) +
    ggplot2::theme_void() +
    ggplot2::labs(title = "Kenya Counties")
  
  if (!is.null(fill_var) && fill_var %in% names(county_boundaries)) {
    p <- p + ggplot2::aes_string(fill = fill_var)
  } else {
    p <- p + ggplot2::geom_sf(fill = "lightblue", color = "white", size = 0.2)
  }
  
  return(p)
}