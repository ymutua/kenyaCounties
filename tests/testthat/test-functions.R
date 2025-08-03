test_that("get_governor works correctly", {
  # Test all governors
  all_govs <- get_governor()
  expect_s3_class(all_govs, "data.frame")
  expect_equal(nrow(all_govs), 47)
  
  # Test by county name
  nairobi_gov <- get_governor("Nairobi")
  expect_equal(nrow(nairobi_gov), 1)
  expect_equal(nairobi_gov$county_name, "Nairobi")
  
  # Test by county code
  county_47 <- get_governor(county_code = 47)
  expect_equal(nrow(county_47), 1)
  expect_equal(county_47$county_code, 47)
  
  # Test invalid inputs
  expect_equal(nrow(get_governor("InvalidCounty")), 0)
  expect_equal(nrow(get_governor(county_code = 99)), 0)
})

test_that("list_counties_by_party works correctly", {
  # Test all parties
  all_parties <- list_counties_by_party()
  expect_s3_class(all_parties, "data.frame")
  expect_equal(ncol(all_parties), 3)
  expect_equal(nrow(all_parties), 47)
  
  # Test specific party
  odm_counties <- list_counties_by_party("ODM")
  expect_s3_class(odm_counties, "data.frame")
  expect_true(all(odm_counties$political_party == "ODM"))
  
  # Test non-existent party
  fake_party <- list_counties_by_party("FAKE_PARTY")
  expect_equal(nrow(fake_party), 0)
})

test_that("get_county_population works correctly", {
  # Test single county
  nairobi_pop <- get_county_population("Nairobi")
  expect_s3_class(nairobi_pop, "data.frame")
  expect_equal(nrow(nairobi_pop), 1)
  
  # Test by county code
  county_47_pop <- get_county_population(county_code = 47)
  expect_equal(nrow(county_47_pop), 1)
  
  # Test all counties
  all_pop <- get_county_population()
  expect_equal(nrow(all_pop), 47)
})

test_that("get_county_data works with multiple counties and years", {
  # Test single county with population
  single_data <- get_county_data("Nairobi", population = TRUE)
  expect_s3_class(single_data, "data.frame")
  expect_equal(nrow(single_data), 1)
  
  # Test multiple counties
  multi_data <- get_county_data(c("Nairobi", "Mombasa"), population = TRUE)
  expect_equal(nrow(multi_data), 2)
  
  # Test with years filter
  year_data <- get_county_data("Nairobi", population = TRUE, years = c(2019, 2020))
  expect_true("pop_2019" %in% names(year_data))
  expect_true("pop_2020" %in% names(year_data))
})

test_that("function inputs are validated", {
  # Test NULL inputs work
  expect_no_error(get_governor(NULL, NULL))
  expect_no_error(list_counties_by_party(NULL))
  expect_no_error(get_county_population(NULL, NULL))
  
  # Test empty string inputs
  expect_equal(nrow(get_governor("")), 0)
  expect_equal(nrow(list_counties_by_party("")), 0)
  expect_equal(nrow(get_county_population("")), 0)
})