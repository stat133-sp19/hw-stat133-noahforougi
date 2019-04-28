context("testing the main functions")
source("/Users/user/Desktop/hw-stat133/binomial/R/main_functions_and_methods.R")

test_that("testing that bin_choose function works",{
  expect_equal(bin_choose(2,1), 2)
  expect_error(bin_choose(1, 2),"number of successes cannot be greater than the number of trials" )
  expect_length(bin_choose(10,0.5),1)
})

test_that("testing that bin_probability function works",{
  expect_length(bin_probability(0:2, 5, 1), 3)
  expect_equal(bin_probability(success = 0:2, trials = 5, prob = 0.5), c(0.03125, 0.15625, 0.31250))
  expect_is(bin_probability(0:2, 5, 1), "numeric")
})

test_that("testing that bin_distribution works", {
  expect_type(bin_distribution(10,0.5), "list")
  expect_length(bin_distribution(10,0.5), 2)
  expect_is(bin_distribution(10,.5),  c("bindis"   ,  "data.frame"))
})

test_that("testing that bin_cumulative works", {
  expect_type(bin_cumulative(10,0.5), "list")
  expect_length(bin_cumulative(10,0.5), 3)
  expect_is(bin_cumulative(10,.5), "data.frame")
})

