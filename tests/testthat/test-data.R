test_that("datasets have correct structure", {
  # Test governors dataset
  expect_s3_class(governors, "data.frame")
  expect_equal(nrow(governors), 47)
  expect_true(all(c("county_code", "county_name", "governor_name", "political_party") %in% names(governors)))
  
  # Test county_info dataset
  expect_s3_class(county_info, "data.frame")
  expect_equal(nrow(county_info), 47)
  expect_true(all(c("county_code", "county_name", "county_capital") %in% names(county_info)))
  
  # Test countyGCP dataset
  expect_s3_class(countyGCP, "data.frame")
  expect_true("county_code" %in% names(countyGCP))
  
  # Test countyPopulation dataset
  expect_s3_class(countyPopulation, "data.frame")
  expect_true("county_code" %in% names(countyPopulation))
})

test_that("county codes are valid", {
  expect_true(all(governors$county_code %in% 1:47))
  expect_true(all(county_info$county_code %in% 1:47))
  expect_equal(length(unique(governors$county_code)), 47)
})

test_that("no missing essential data", {
  expect_false(any(is.na(governors$county_name)))
  expect_false(any(is.na(governors$governor_name)))
  expect_false(any(is.na(county_info$county_name)))
})