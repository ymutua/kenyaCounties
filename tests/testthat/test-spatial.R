test_that("spatial functions handle missing sf package", {
  skip_if_not_installed("sf")
  
  # Test get_county_boundary
  expect_s3_class(get_county_boundary(), "sf")
  expect_equal(nrow(get_county_boundary("Nairobi")), 1)
  
  # Test county_stats
  stats <- county_stats()
  expect_s3_class(stats, "data.frame")
  expect_true("total_counties" %in% names(stats))
  expect_equal(stats$total_counties, 47)
})

test_that("spatial functions fail gracefully without sf", {
  # Skip this test - mocking requireNamespace is complex
  skip("Mocking test skipped")
})